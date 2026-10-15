# Image generation for lesson materials

`generate_images.py` turns prompts written in a markdown file into images, using an image model (default
`gemini-3-pro-image-preview`) served through the company litellm proxy. It uses only the Python standard library.

## Setup
1. The script needs the proxy URL and the API key from two **environment variables**. Their names are intentionally
   not stored in this repo. Find out which variables hold them (ask whoever set up your proxy access, or look through
   your environment), then fill in `BASE_URL_VAR` and `API_KEY_VAR` at the top of the script. Don't commit the
   filled-in names, and never write the values themselves into any file.
2. Make sure the model you use is available on the proxy (the proxy's model list shows the image models).

## Usage (from the repo root)
```
uv run --no-project python tools/image_generation/generate_images.py [regex] [--model M] [--prompts FILE] [--out DIR]
```
- `regex` - only generate files whose name matches (e.g. `img_C3`); default is all.
- `--prompts` - markdown file with prompts (default: `image_prompts.md` next to the script).
- `--out` - output folder (default: `out/` next to the script, git-ignored). Existing files are skipped, so delete a
  file to regenerate it. Copy the images you want to keep to the lesson's `Support/` folder.
- Gemini sometimes answers `503 high demand`; the script retries automatically.

## Prompt file format
- A block under the heading `## Common style` is prepended to every prompt.
- Every other ```` ```text ```` block is one prompt; the output filename is the `` `img_*.png` `` in the closest heading above it.

## Contents
- `image_prompts.md` - prompts for the Lesson 4 Exercise 1 pictures (keys, summarize vs mutate, left joins, granularity),
  with the example data and colour code they share, and which generated version is used in the lesson.

## Tips learned
- Image models garble text and misplace arrows; state exact table contents and where each arrow starts and ends.
- Review every image against its prompt (values, row counts, colours) before using it; expect 1-3 retries per picture.
- A simplified version of a picture (fewer rows and columns) usually comes out cleaner than the full-detail one.
