"""Generate images from a prompts markdown file via the litellm proxy.

Auth: needs the litellm proxy URL and API key from two environment variables. Their names are deliberately not
stored in the repo - ask the user which variables hold them, or search the environment for them, then fill in
BASE_URL_VAR and API_KEY_VAR below (never hard-code the values themselves, and do not commit the filled-in names).

Usage: see README.md in this folder.
"""
import argparse
import base64
import json
import os
import re
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

BASE_URL_VAR = ""  # name of the env variable with the litellm proxy URL (ask the user / search env)
API_KEY_VAR = ""  # name of the env variable with the litellm API key (ask the user / search env)

HERE = Path(__file__).resolve().parent

ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
ap.add_argument("pattern", nargs="?", default=".", help="regex; only generate files whose name matches (default: all)")
ap.add_argument("--model", default="gemini-3-pro-image-preview", help="image model served by the proxy")
ap.add_argument("--prompts", type=Path, default=HERE / "image_prompts.md", help="markdown file with the prompts")
ap.add_argument("--out", type=Path, default=HERE / "out", help="output folder (existing files are skipped)")
args = ap.parse_args()

if not (BASE_URL_VAR and API_KEY_VAR):
    sys.exit("Fill in BASE_URL_VAR and API_KEY_VAR (names of the env variables) at the top of this script.")
base = os.environ[BASE_URL_VAR].rstrip("/")
key = os.environ[API_KEY_VAR]

# Parse the markdown: every ```text block is a prompt; its filename is the `img_*.png` in the closest heading above.
# The block under the heading "Common style" is prepended to every prompt.
blocks, style, head, buf = [], None, None, None
for line in args.prompts.read_text(encoding="utf-8").splitlines():
    if buf is None:
        if line.startswith("#"):
            head = line
        elif line.startswith("```text"):
            buf = []
    elif line.startswith("```"):
        if head.startswith("## Common style"):
            style = "\n".join(buf)
        else:
            blocks.append((head, "\n".join(buf)))
        buf = None
    else:
        buf.append(line)

args.out.mkdir(parents=True, exist_ok=True)
for head, text in blocks:
    m = re.search(r"`(img_[^`]*\.png)`", head)
    if not m or not re.search(args.pattern, m.group(1)):
        continue
    fn = m.group(1)
    out = args.out / fn
    if out.exists():
        print("skip", fn)
        continue
    prompt = f"{style}\n\nPICTURE:\n{text}"
    body = json.dumps({"model": args.model, "prompt": prompt, "n": 1}).encode()
    req = urllib.request.Request(
        f"{base}/v1/images/generations", data=body,
        headers={"Content-Type": "application/json", "Authorization": f"Bearer {key}", "x-api-key": key},
    )
    for attempt in range(1, 6):  # Gemini returns transient 503 under load
        try:
            with urllib.request.urlopen(req, timeout=300) as r:
                data = json.load(r)
            out.write_bytes(base64.b64decode(data["data"][0]["b64_json"]))
            print("ok  ", fn, flush=True)
            break
        except (urllib.error.HTTPError, urllib.error.URLError, KeyError, TimeoutError) as e:
            msg = e.read()[:150].decode(errors="replace") if isinstance(e, urllib.error.HTTPError) else repr(e)
            print(f"retry {attempt} {fn}: {msg}", flush=True)
            time.sleep(15 * attempt)
    else:
        print("FAIL", fn)
