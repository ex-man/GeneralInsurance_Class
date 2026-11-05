"""Render the R code of quiz question 3 as an image (the image model garbles code, so it is drawn directly).

Usage (from the repo root):
    uv run --no-project --with pillow python tools/image_generation/render_code_image.py [--out DIR]
Output: img_Q03_r_code.png (1376x768, same palette as the other quiz pictures).
"""
import argparse
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

HERE = Path(__file__).resolve().parent
ap = argparse.ArgumentParser()
ap.add_argument("--out", type=Path, default=HERE / "out")
args = ap.parse_args()

W, H = 1376, 768
BG, PANEL = (30, 42, 90), (18, 26, 58)
COL = {"fn": (255, 200, 61), "num": (255, 107, 107), "pipe": (46, 196, 182), "txt": (255, 255, 255)}

# each line is a list of (text, colour key)
CODE = [
    [("c", "fn"), ("(", "txt"), ("1, 4, 2, 8, -5", "num"), (")", "txt"), (" |>", "pipe")],
    [("  min", "fn"), ("(", "txt"), ("-1000", "num"), (", x = _) ", "txt"), ("|>", "pipe")],
    [("  abs", "fn"), ("()", "txt")],
]

font = ImageFont.truetype("C:/Windows/Fonts/consola.ttf", 64)
cw = font.getlength("M")
line_h = 96
width = max(sum(len(t) for t, _ in line) for line in CODE) * cw
panel_w, panel_h = width + 160, line_h * len(CODE) + 120

img = Image.new("RGB", (W, H), BG)
d = ImageDraw.Draw(img)
x0, y0 = (W - panel_w) / 2, (H - panel_h) / 2
d.rounded_rectangle([x0, y0, x0 + panel_w, y0 + panel_h], radius=28, fill=PANEL, outline=(255, 255, 255), width=3)
for i, line in enumerate(CODE):
    x = x0 + 80
    y = y0 + 60 + i * line_h
    for text, key in line:
        d.text((x, y), text, font=font, fill=COL[key])
        x += len(text) * cw

args.out.mkdir(parents=True, exist_ok=True)
img.save(args.out / "img_Q03_r_code.png")
print("ok   img_Q03_r_code.png")
