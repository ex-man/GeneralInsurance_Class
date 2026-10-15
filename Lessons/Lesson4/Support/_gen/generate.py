"""Generate images from Support/image_prompts.md via the litellm proxy.

Auth: needs the litellm proxy URL and API key from two environment variables. Their names are deliberately not
stored in the repo - ask the user which variables hold them, or search the environment for them, then fill in
BASE_URL_VAR and API_KEY_VAR below (never hard-code the values themselves).
Usage (from repo root):
    uv run --no-project python Lessons/Lesson4/Support/_gen/generate.py [regex] [model]
Existing files in _gen/out are skipped (delete to regenerate).
"""
import base64
import json
import os
import re
import sys
import time
import urllib.request
import urllib.error
from pathlib import Path

PROMPTS = Path("Lessons/Lesson4/Support/image_prompts.md")
OUT = Path("Lessons/Lesson4/Support/_gen/out")

pattern = sys.argv[1] if len(sys.argv) > 1 else "."
model = sys.argv[2] if len(sys.argv) > 2 else "gemini-3-pro-image-preview"
BASE_URL_VAR = ""  # name of the env variable with the litellm proxy URL (ask the user / search env)
API_KEY_VAR = ""  # name of the env variable with the litellm API key (ask the user / search env)
if not (BASE_URL_VAR and API_KEY_VAR):
    sys.exit("Fill in BASE_URL_VAR and API_KEY_VAR (names of the env variables) at the top of this script.")
base = os.environ[BASE_URL_VAR].rstrip("/")
key = os.environ[API_KEY_VAR]

md = PROMPTS.read_text(encoding="utf-8")
# split into (heading line, first code block after it)
blocks, style, head, buf = [], None, None, None
for line in md.splitlines():
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

OUT.mkdir(parents=True, exist_ok=True)
for head, text in blocks:
    m = re.search(r"`(img_[^`]*\.png)`", head)
    if not m or not re.search(pattern, m.group(1)):
        continue
    fn = m.group(1)
    out = OUT / fn
    if out.exists():
        print("skip", fn)
        continue
    prompt = f"{style}\n\nPICTURE:\n{text}"
    body = json.dumps({"model": model, "prompt": prompt, "n": 1}).encode()
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
