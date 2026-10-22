# Image prompts for Lesson 5 Exercise 2 (model validation)

Prompts for an image model (used: `gemini-3-pro-image-preview`) for the pictures in
`Lessons/Lesson5/Exercises/Lesson5_Ex2_ModelValidation.Rmd` (saved in `Lessons/Lesson5/Support/img_*.png`).
`generate_images.py` reads this file with `--prompts` (see `README.md`), so keep the structure: each prompt is a
```` ```text ```` block under a `###` heading that ends with the output filename in backticks.

Every concept has three versions with increasing visual complexity (`_L1` minimal, `_L2` medium, `_L3` detailed), so
they can be compared and the best one for teaching picked. Generated images are never exact - review each one against
its prompt and regenerate if needed.

## Example data (for the grouped RMSE pictures)

Made-up values. 10 policies already sorted by predicted burning cost, 5 groups of 2 (equal weights for simplicity).

| Predicted | Actual |
|---|---|
| 40 | 0 |
| 60 | 150 |
| 90 | 20 |
| 110 | 60 |
| 140 | 300 |
| 170 | 0 |
| 220 | 180 |
| 260 | 90 |
| 330 | 600 |
| 400 | 250 |

Group means (predicted / actual): group 1 = 50 / 75, group 2 = 100 / 40, group 3 = 155 / 150, group 4 = 240 / 135,
group 5 = 365 / 425.

## Common style (prepended to every prompt)

```text
Clean flat educational infographic for a university data science class. Pure white background, no 3D, no shadows,
no gradients, no people, no decorative shapes, no icons other than those explicitly asked for.
Landscape 16:9. All text in English, spelled exactly as given; do not add any other words, labels, numbers,
captions or brackets. Use a clean sans-serif font for titles and a monospace font for tables and code.
Tables are drawn as simple rectangular grids with thin dark-grey borders and a bold header row.
Every table and chart has exactly the rows, columns and values listed - do not add, drop, reorder or rename any.
Arrows must start and end exactly on the elements they are described to connect.

STRICT COLOUR CODE - use exactly these colours, in every picture, and never use a colour for anything else:
- BLUE (#2F6FDE, pale #DCE8FB) = training data (the data the model is fitted on).
- AMBER (#F5A623, pale #FDEBC8) = validation data (the data the model has not seen).
- GREY (#9CA3AF, pale #E5E7EB) = neutral / unused elements and axes.
- Chart lines: actual = red-orange line (#F8766D) with round markers, predicted (fitted) = blue line (#619CFF) with
  round markers.
- GROUP TINTS (only when rows are shown as groups): group 1 lavender (#E9E3F7), group 2 peach (#FFE6D0),
  group 3 sand (#F1EBD0), group 4 mint (#DDF3E4), group 5 pale rose (#FBE1EA); each group has its own tint applied to
  the whole row, never reused for another group.
Arrows are thick dark grey (#374151) with short labels.
Do not print the colour codes or the colour names.
```

---

## D. Validation approaches

### `img_D_validation_methods_L1.png`

```text
LEVEL 1 - MINIMAL. Title: "Three ways to split the data".
Three panels side by side, each a single horizontal strip made of small square blocks (20 blocks per strip), with a
one-word-per-line label under it and nothing else. No arrows, no legend, no pro / con text.
Panel 1, label "Out of sample": the 20 blocks are randomly mixed - 16 blue and 4 amber blocks in a scattered order.
Panel 2, label "Out of time": the first 16 blocks are blue, the last 4 are amber (a clean split left to right), with a
thin grey arrow under the whole strip pointing right (time).
Panel 3, label "Cross validation": five strips stacked on top of each other, each strip has 5 big blocks, in every
strip exactly one block is amber and the other four are blue, and the amber block moves one place to the right in each
following strip (diagonal).
Small legend at the bottom: a blue square with "train", an amber square with "validation".
```

### `img_D_validation_methods_L2.png`

```text
LEVEL 2 - MEDIUM. Title: "Three ways to split the data".
Three panels side by side, each with a bold panel title, a one-line subtitle in grey, a picture, and below the picture
two small arrows: a blue-labelled arrow "fit on train" and an amber-labelled arrow "score on validation".
Panel 1 title "Out of sample", subtitle "random 80 / 20 split": a rounded rectangle containing a scatter of 25 small
dots, 20 blue and 5 amber, randomly mixed.
Panel 2 title "Out of time", subtitle "past vs. future": a horizontal timeline with year ticks 2012, 2013, 2014, 2015,
2016, 2017. The part 2012-2016 is a long blue bar labelled "train", the part 2017 is a short amber bar labelled
"validation".
Panel 3 title "Cross validation", subtitle "every part gets its turn": a row of 5 equal boxes labelled "part 1" ...
"part 5"; below it three example rows of the same 5 boxes where in the first row box 1 is amber and the rest blue, in
the second row box 2 is amber, in the third row box 5 is amber (with three dots between the rows to show it continues).
Legend at the bottom: blue square "train", amber square "validation".
```

### `img_D_validation_methods_L3.png`

```text
LEVEL 3 - DETAILED. Title: "Three ways to split the data".
Three panels side by side. Each panel has: a bold title, a one-line subtitle in grey, a picture, a "How:" line, and two
short one-line notes at the bottom, one with a green check mark (#2E9E5B) "good for" and one with an amber warning
triangle "watch out". Legend at the very bottom: blue square "train", amber square "validation".
Panel 1 title "Out of sample", subtitle "random 80 / 20 split". Picture: a small table with columns Policy | Year with
10 rows, the rows' left cell filled blue for 8 rows and amber for 2 rows, randomly mixed (rows: 1 2014, 2 2016,
3 2012, 4 2015, 5 2013, 6 2017, 7 2014, 8 2016, 9 2015, 10 2012). "How:" sample(n_rows, 0.8 * n_rows).
Check: "simple, fast". Warning: "ignores time".
Panel 2 title "Out of time", subtitle "past vs. future". Picture: a horizontal timeline with ticks 2012 to 2017; the bar over
2012-2016 blue "train", over 2017 amber "validation", and a vertical dashed line between 2016 and 2017 labelled "today".
"How:" Year <= 2016 vs. Year == 2017. Check: "mimics real use". Warning: "needs enough years".
Panel 3 title "Cross validation", subtitle "every part gets its turn". Picture: a grid with 5 rows (labelled "round 1" ...
"round 5") and 5 columns; in each round exactly one cell is amber (round 1 = column 1, round 2 = column 2, ...,
diagonal), all other cells blue; to the right of the grid a small box "average of 5 scores". "How:" split into k = 5
parts. Check: "uses all data". Warning: "k times more work".
```

---

## E. Grouped RMSE and the lift chart

### `img_E_grouped_rmse_L1.png`

```text
LEVEL 1 - MINIMAL. Title: "Compare actual and predicted by group".
A single line chart. X axis labelled "risk group (low to high predicted risk)" with the 5 ticks 1, 2, 3, 4, 5. Y axis
labelled "burning cost" without numbers. Two lines with round markers and a small legend "actual" and "predicted":
predicted (blue) rises smoothly and steeply: 50, 100, 155, 240, 365 at groups 1 to 5. Actual (red-orange) follows it
closely but zig-zags a bit around it: 75, 40, 150, 135, 425. Behind the lines, light grey vertical bars of equal height
at each of the 5 groups (the equal group sizes). No other text, no grid except faint horizontal lines.
```

### `img_E_grouped_rmse_L2.png`

```text
LEVEL 2 - MEDIUM. Title: "From single policies to risk groups".
Three steps from left to right, connected by thick arrows with the labels "sort by prediction", "cut into 5 groups",
"average per group".
Step 1: a small table with columns Predicted | Actual and 10 rows in the order below, header grey; no tints:
40 | 0 ; 60 | 150 ; 90 | 20 ; 110 | 60 ; 140 | 300 ; 170 | 0 ; 220 | 180 ; 260 | 90 ; 330 | 600 ; 400 | 250.
Step 2: the same table, but every two neighbouring rows share one group tint (rows 1-2 lavender, rows 3-4 peach,
rows 5-6 sand, rows 7-8 mint, rows 9-10 pale rose) and a bracket with a group number 1 to 5 on the right of each pair.
Step 3: a line chart (x axis ticks 1 to 5 labelled "group", y axis labelled "burning cost") with two lines with round
markers and a legend "actual" and "predicted": predicted (blue) 50, 100, 155, 240, 365, actual (red-orange)
75, 40, 150, 135, 425. Under the chart, one line of text: "RMSE is computed on these 5 points".
```

### `img_E_grouped_rmse_L3.png`

```text
LEVEL 3 - DETAILED. Title: "Grouped RMSE: compare groups, not single policies".
Left half: the table from the data below, columns Group | Predicted | Actual with 10 rows, each pair of rows tinted with
its group tint (group 1 lavender rows 1-2, group 2 peach rows 3-4, group 3 sand rows 5-6, group 4 mint rows 7-8, group 5
pale rose rows 9-10):
1 | 40 | 0 ; 1 | 60 | 150 ; 2 | 90 | 20 ; 2 | 110 | 60 ; 3 | 140 | 300 ; 3 | 170 | 0 ; 4 | 220 | 180 ; 4 | 260 | 90 ;
5 | 330 | 600 ; 5 | 400 | 250.
A thick arrow labelled "mean per group" from the table to a second, small table in the middle with columns
Group | Predicted | Actual, 5 rows, each in its group tint: 1 | 50 | 75 ; 2 | 100 | 40 ; 3 | 155 | 150 ; 4 | 240 | 135 ;
5 | 365 | 425.
Right half: top - a line chart (x axis ticks 1 to 5 labelled "group", y axis "burning cost") with two lines with round
markers and a legend "actual" and "predicted" using the 5 group means (predicted blue 50, 100, 155, 240, 365; actual
red-orange 75, 40, 150, 135, 425), vertical dotted grey connectors between the actual and predicted marker in each group.
Bottom - the formula in a bordered box: "RMSE = sqrt( mean( (predicted - actual)^2 ) )" and under it the note "computed
over the 5 groups".
Bottom strip across the picture: two small side-by-side comparison boxes: left box with a red-orange scattering of
many individual points all over and the text "single policies: very noisy", right box with 5 points close to a rising line and the
text "groups: the signal is visible".
```
