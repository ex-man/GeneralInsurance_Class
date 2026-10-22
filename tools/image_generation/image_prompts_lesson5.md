# Image prompts for Lesson 5 Exercise 2 (model validation)

Prompts for an image model (used: `gemini-3-pro-image-preview`) for the pictures in
`Lessons/Lesson5/Exercises/Lesson5_Ex2_ModelValidation.Rmd` (saved in `Lessons/Lesson5/Support/img_*.png`).
`generate_images.py` reads this file with `--prompts` (see `README.md`), so keep the structure: each prompt is a
```` ```text ```` block under a `###` heading that ends with the output filename in backticks.

The validation picture is the medium-complexity version picked from three tried levels (minimal / medium / detailed;
the other two are in git history, commit "Lesson 5: review Ex1-3 ..."). The grouped RMSE story is split into two
sequential pictures built from elements of the medium and detailed versions. Generated images are never exact - review
each one against its prompt and regenerate if needed.

## Example data (for the grouped RMSE pictures)

Made-up values. 10 policies with equal weights; the raw order is unsorted, after sorting by predicted burning cost
they form 5 groups of 2.

| Predicted | Actual |
|---|---|
| 170 | 0 |
| 400 | 250 |
| 60 | 150 |
| 260 | 90 |
| 40 | 0 |
| 330 | 600 |
| 110 | 60 |
| 220 | 180 |
| 140 | 300 |
| 90 | 20 |

Sorted: 40/0, 60/150, 90/20, 110/60, 140/300, 170/0, 220/180, 260/90, 330/600, 400/250.
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

### `img_D_validation_methods.png`

```text
Title: "Three ways to split the data".
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

---

## E. Grouped RMSE and the lift chart (two sequential pictures)

### `img_E1_group_the_data.png`

```text
Title: "Grouped RMSE, step 1: from raw data to group means".
Three tables from left to right, connected by two thick arrows labelled "sort by prediction" and "average per group".
Table 1, small caption "raw data": columns Predicted | Actual, 10 rows in exactly this order, header grey, no tints:
170 | 0 ; 400 | 250 ; 60 | 150 ; 260 | 90 ; 40 | 0 ; 330 | 600 ; 110 | 60 ; 220 | 180 ; 140 | 300 ; 90 | 20.
Table 2, small caption "sorted by predicted", the same columns and 10 rows sorted by Predicted increasing:
40 | 0 ; 60 | 150 ; 90 | 20 ; 110 | 60 ; 140 | 300 ; 170 | 0 ; 220 | 180 ; 260 | 90 ; 330 | 600 ; 400 | 250.
Every two neighbouring rows share one group tint (rows 1-2 lavender, rows 3-4 peach, rows 5-6 sand, rows 7-8 mint,
rows 9-10 pale rose) and a curly bracket with the group number 1 to 5 stands on the right of each pair.
Table 3, small caption "group means", columns Group | Predicted | Actual, 5 rows, each in its group tint:
1 | 50 | 75 ; 2 | 100 | 40 ; 3 | 155 | 150 ; 4 | 240 | 135 ; 5 | 365 | 425.
The arrows must not overlap the tables or the brackets. No other text.
```

### `img_E2_compare_groups.png`

```text
Title: "Grouped RMSE, step 2: compare actual and predicted by group".
Left: a small table with caption "group means", columns Group | Predicted | Actual, 5 rows, each in its group tint
(group 1 lavender, group 2 peach, group 3 sand, group 4 mint, group 5 pale rose):
1 | 50 | 75 ; 2 | 100 | 40 ; 3 | 155 | 150 ; 4 | 240 | 135 ; 5 | 365 | 425.
A thick arrow labelled "plot" points from this table to a line chart in the centre (x axis ticks 1 to 5 labelled
"group", y axis labelled "burning cost", legend "actual" and "predicted") with two lines with round markers:
predicted (blue) 50, 100, 155, 240, 365; actual (red-orange) 75, 40, 150, 135, 425; thin vertical dotted grey
connectors between the actual and predicted marker in each group. Under the chart a bordered box with the formula
"RMSE = sqrt( mean( (predicted - actual)^2 ) )" and the note "computed over the 5 groups".
Right, stacked as two small boxes with a bold heading each: top box "single policies: very noisy" showing many red-orange
points scattered all over with no visible pattern; bottom box "groups: the signal is visible" showing 5 blue points
rising clearly along a line. No other text.
```
