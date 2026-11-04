# Image prompts for Lesson 6 Exercise 1 (variable selection)

Prompts for an image model (used: `gemini-3-pro-image-preview`) for the pictures in
`Lessons/Lesson6_alt/Exercises/Lesson6_Ex1_VariableSelection.Rmd` (saved in `Lessons/Lesson6_alt/Support/img_*.png`).
`generate_images.py` reads this file with `--prompts` (see `README.md`), so keep the structure: each prompt is a
```` ```text ```` block under a `###` heading that ends with the output filename in backticks.

Forward selection is tried in three variants of the same story (A minimal, B rounds as columns of a table, C a staircase);
generated images are never exact - review each one against its prompt (values, arrows, colours) and regenerate if needed.

## Example data (for the forward selection pictures)

Made-up training deviance values (lower is better). The base model "vehicle type" has deviance 1950.

| Round | Model before | Tried variable | Training deviance | Winner |
|---|---|---|---|---|
| 1 | vehicle type (1950) | BonusMalus | 1620 | yes |
| 1 | vehicle type (1950) | Time on book | 1930 | |
| 1 | vehicle type (1950) | Sum insured | 1935 | |
| 1 | vehicle type (1950) | Capacity | 1945 | |
| 2 | + BonusMalus (1620) | Time on book | 1605 | yes |
| 2 | + BonusMalus (1620) | Sum insured | 1610 | |
| 2 | + BonusMalus (1620) | Capacity | 1618 | |
| 3 | + BonusMalus + Time on book (1605) | Sum insured | 1596 | yes |
| 3 | + BonusMalus + Time on book (1605) | Capacity | 1600 | |

## Common style (prepended to every prompt)

```text
Clean flat educational infographic for a university data science class. Pure white background, no 3D, no shadows,
no gradients, no people, no decorative shapes, no icons other than those explicitly asked for.
Landscape 16:9. All text in English, spelled exactly as given; do not add any other words, labels, numbers,
captions or brackets. Use a clean sans-serif font for titles and labels and a monospace font for numbers.
Every box, table and chart has exactly the elements and values listed - do not add, drop, reorder or rename any.
Arrows must start and end exactly on the elements they are described to connect.

STRICT COLOUR CODE - use exactly these colours, in every picture, and never use a colour for anything else:
- BLUE (#2F6FDE, pale #DCE8FB) = the model that is already in use and the training deviance numbers.
- GREEN (#2E9E5B, pale #D9F2E3) = the winner of a round, the variable that is kept.
- GREY (#9CA3AF, pale #E5E7EB) = candidates that lost the round, and neutral elements.
Arrows are thick dark grey (#374151) with short labels.
Do not print the colour codes or the colour names.
```

---

## A. Forward selection

### `img_F1_forward_minimal.png`

```text
Title: "Forward selection: try every variable, keep the best, repeat".
A horizontal flow of three rounds from left to right, connected by thick arrows labelled "keep the winner".
Each round is a rounded box with a bold heading ("Round 1", "Round 2", "Round 3"). Inside each box, a pale blue
rounded label at the top shows the current model, then a vertical list of the tried variables, one per line, each as
"+ variable : number". The winner line has a pale green background, the lines that lost have a pale grey background.
Round 1, current model "vehicle type": "+ BonusMalus : 1620" (green), "+ Time on book : 1930" (grey),
"+ Sum insured : 1935" (grey), "+ Capacity : 1945" (grey).
Round 2, current model "vehicle type + BonusMalus": "+ Time on book : 1605" (green), "+ Sum insured : 1610" (grey),
"+ Capacity : 1618" (grey).
Round 3, current model "vehicle type + BonusMalus + Time on book": "+ Sum insured : 1596" (green),
"+ Capacity : 1600" (grey).
Below the three boxes, one line of text: "lowest training deviance wins". No other text.
```

### `img_F2_forward_table.png`

```text
Title: "Forward selection step by step".
One table with a bold header row and three columns: "Round" | "Tried" | "Training deviance". Rows are grouped by round
with a thick border between rounds; the row of the winner of each round is filled pale green, the other rows pale grey.
Round 1: Tried "+ BonusMalus" 1620 (green); "+ Time on book" 1930; "+ Sum insured" 1935; "+ Capacity" 1945.
Round 2: "+ BonusMalus + Time on book" 1605 (green); "+ BonusMalus + Sum insured" 1610; "+ BonusMalus + Capacity" 1618.
Round 3: "+ BonusMalus + Time on book + Sum insured" 1596 (green); "+ BonusMalus + Time on book + Capacity" 1600.
To the right of the table, a vertical pale blue column of three rounded boxes stacked top to bottom, labelled "model after round 1"
(content "vehicle type + BonusMalus"), "model after round 2" (content "+ Time on book"), "model after round 3"
(content "+ Sum insured"), each connected by a thick arrow from the green row of its round. No other text.
```

### `img_F3_forward_staircase.png`

```text
Title: "Forward selection: a staircase of models".
A staircase with four steps rising from left to right. Each step is a pale blue block with the model written on it:
step 0 "vehicle type", step 1 "+ BonusMalus", step 2 "+ Time on book", step 3 "+ Sum insured".
Under each step 1-3, a small row of the candidates that were tried and lost in that round, drawn as pale grey rounded
chips: under step 1 "Time on book", "Sum insured", "Capacity"; under step 2 "Sum insured", "Capacity";
under step 3 "Capacity". Each step is connected to the next by a thick arrow labelled "best of the rest".
A green rounded chip with the variable name sits on top of each of steps 1-3 as the winner of that round.
Next to each step a monospace number for the training deviance: 1950, 1620, 1605, 1596. No other text.
```

---

## B. The L1 penalty (not used in the lesson any more)

The picture was removed from Ex1 when the lasso section was simplified; the file is no longer in `Lesson6_alt/Support/`.
The prompt stays here in case the geometry is wanted again.

### `img_L1_penalty_geometry.png`

```text
Title: "Why the lasso sets coefficients to exactly zero".
Two panels side by side with the same set of axes in each (horizontal axis "coefficient 1", vertical axis
"coefficient 2", both through the origin, thin grey).
Left panel, bold heading "L1 penalty (lasso)": a diamond (a square rotated by 45 degrees) centred at the origin, pale
green fill. A point outside it, in the upper right, with three concentric ellipses around it in blue (the loss
contours). The smallest ellipse that touches the diamond touches it exactly at the top corner of the diamond, which
lies on the vertical axis; mark this touching point with a green dot and the label "coefficient 1 = 0".
Right panel, bold heading "L2 penalty (ridge)": a circle centred at the origin, pale grey fill, the same point and the
same three blue ellipses. The ellipse touches the circle at a point that is NOT on an axis; mark it with a grey dot
and no label.
Below both panels, one line: "corners of the diamond lie on the axes". No other text.
```
