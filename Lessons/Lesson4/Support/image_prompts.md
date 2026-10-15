# Image prompts for Lesson 4 Exercise 1

Prompts for an image model (used: `gemini-3-pro-image-preview`) that generate the explanatory pictures used in
`Exercises/Lesson4_Ex1_DataPrep_filled.Rmd`. `Support/_gen/generate.R` reads this file, so keep the structure:
each prompt is a code block under a `###` heading that ends with the output filename in backticks.

Every concept has **three levels** of the same picture:

| Level | File | What it shows |
|---|---|---|
| 1 - full | `img_X.png` | our toy policy / claims data, with code labels |
| 2 - simplified | `img_X_L2.png` | fewer rows and columns, only the values that carry the idea |
| 3 - abstract | `img_X_L3.png` | no real data: coloured cells and letters (A, B, C), just the concept |

The Rmd links the level 1 files; pick whichever level works best and rename / relink it.

## Example data (levels 1 and 2)

The values are made up, but column names and formats match our real data (`Data/data_dictionary.txt`).

**Policy** - one row per policy + object (insured vehicle). Primary key = `NrPolicy` + `NrObject`.

| NrPolicy | NrObject | Year | Dt_Exp_Start | Dt_Exp_End | Veh_type2 | D_age | Premium_earned |
|---|---|---|---|---|---|---|---|
| 10045 | 1 | 2014 | 01.01.2014 | 31.12.2014 | CAR | 34 | 310 |
| 10045 | 2 | 2014 | 01.01.2014 | 31.12.2014 | MOTORBIKE | 34 | 120 |
| 10078 | 1 | 2014 | 01.07.2014 | 31.12.2014 | CAR | 52 | 160 |
| 10112 | 1 | 2015 | 01.01.2015 | 31.12.2015 | TRUCK | 45 | 640 |

**Claims** - one row per claim. `NrPolicy` + `NrObject` is a foreign key to Policy. (In the real data `NrClaim` is
not even fully unique - so the pictures never call it a primary key.)

| NrClaim | NrPolicy | NrObject | Date_of_loss | Paid | Reserves |
|---|---|---|---|---|---|
| 5001 | 10045 | 1 | 14.03.2014 | 1200 | 0 |
| 5002 | 10045 | 1 | 02.11.2014 | 800 | 400 |
| 5003 | 10112 | 1 | 20.06.2015 | 4500 | 1500 |
| 5004 | 10230 | 1 | 05.02.2016 | 2000 | 0 |

Claim 5004 belongs to policy 10230, which is not in our policy data. Claims 5001 and 5002 share the same
policy + object.

**Claims aggregated** to policy + object + claim year (ClmYr and Reserves are left out of the pictures for space; only Paid is shown)

| NrPolicy | NrObject | ClmYr | Paid |
|---|---|---|---|
| 10045 | 1 | 2014 | 2000 |
| 10112 | 1 | 2015 | 4500 |
| 10230 | 1 | 2016 | 2000 |

**Vehicle info** - one row per policy + object

| NrPolicy | NrObject | VEH_brand | Sum_insured |
|---|---|---|---|
| 10045 | 1 | B07 | 12000 |
| 10045 | 2 | B12 | 3000 |
| 10078 | 1 | B07 | 9000 |
| 10112 | 1 | B03 | 25000 |

**Customer info** - one row per policy only (coarser than the base table)

| NrPolicy | Customer_Type |
|---|---|
| 10045 | S |
| 10078 | C |
| 10112 | C |

Checks used in the pictures: `sum(Premium_earned)` over the 4 policy rows = 310 + 120 + 160 + 640 = **1230**; after a
join with raw claims 10045 / 1 appears twice, so the sum becomes 310 + 310 + 120 + 160 + 640 = **1540**.
In B2: n = 2, 2, 1, 1 so `sum(n)` = **6**, but there are only **4** vehicles.

## Common style (prepended to every prompt)

```text
Clean flat educational infographic for a university data science class. Pure white background, no 3D, no shadows,
no gradients, no people, no decorative shapes, no icons other than those explicitly asked for, no title banners other
than the one asked for.
Tables are drawn as simple rectangular grids with thin dark-grey borders, a bold header row and a monospace font
(like a spreadsheet or an R console); text inside cells is centred and large enough to read.
Landscape 16:9. All text in English, spelled exactly as given; do not add any other words, labels, numbers,
brackets, quotes or captions. Values such as 10045 are written plainly, with no brackets or decoration.
Every table has exactly the columns and rows listed - do not add, drop, reorder or rename any of them.
Arrows must start and end exactly on the rows / tables they are described to connect.

STRICT COLOUR CODE - use exactly these colours, in every picture, and never use a colour for anything else:
- BLUE = key / ID columns. Header cell strong blue (#2F6FDE) with white text, body cells pale blue (#DCE8FB).
- GREEN = columns newly added by a join or a calculation. Header strong green (#2E9E5B) with white text,
  body cells pale green (#DDF3E4).
- WHITE cells with grey header (#6B7280, white text) = ordinary data columns.
- GREY = missing values: cells filled LIGHT grey (#E5E7EB), not dark, containing the text NA in medium grey (#6B7280).
- RED = a problem: duplicated rows or wrong results. Whole rows filled pale red (#FBE1E1) with a red (#D64545)
  outline around ALL the affected rows, wrong results written in red with a red cross. Red is used for nothing else.
- YELLOW (#FFD93D, pale #FFF4C2) = "look here": only used to highlight the cells that differ.
- GROUP TINTS (only when rows are shown as groups): each group gets its OWN soft tint applied to the WHOLE row,
  all rows of one group share it and no other group uses it: group 1 lavender (#E9E3F7), group 2 peach (#FFE6D0),
  group 3 sand (#F1EBD0). These tints replace the blue / white cell fills in those rows; headers keep their colour.
- The same column is always the same colour in every table of a picture (e.g. NrPolicy is blue everywhere).
- AMBER (#F5A623) = "possible but less preferred". GREEN check mark (#2E9E5B) = "preferred / correct".
Arrows are thick dark grey (#374151) with short labels in monospace code font.
Do not print the colour codes or the words BLUE / GREEN / RED etc. unless a label asks for it.
```

---

## A. Primary key vs foreign key

### Level 1 - full `img_A_keys.png`

```text
Title at the top: "Primary key vs foreign key".

Left: a table labelled "Policy" with a small badge "PRIMARY KEY = NrPolicy + NrObject".
Columns: NrPolicy | NrObject | Year | Veh_type2 | Premium_earned
Rows:
10045 | 1 | 2014 | CAR | 310
10045 | 2 | 2014 | MOTORBIKE | 120
10078 | 1 | 2014 | CAR | 160
10112 | 1 | 2015 | TRUCK | 640
NrPolicy and NrObject are the blue key columns; the other three are ordinary grey-header columns.
Next to the table a note: "unique: every combination appears exactly once".

Right: a table labelled "Claims" with a badge "FOREIGN KEY = NrPolicy + NrObject".
Columns: NrClaim | NrPolicy | NrObject | Date_of_loss | Paid
Rows:
5001 | 10045 | 1 | 14.03.2014 | 1200
5002 | 10045 | 1 | 02.11.2014 | 800
5003 | 10112 | 1 | 20.06.2015 | 4500
5004 | 10230 | 1 | 05.02.2016 | 2000
NrPolicy and NrObject are blue key columns (same blue as on the left); the other columns are ordinary.
Next to the table a note: "can repeat, can point to a missing policy".

Arrows (use curved arrows so each one ends exactly on its row):
- claim 5001 -> Policy row 10045 | 1 (the FIRST policy row)
- claim 5002 -> Policy row 10045 | 1 (the same FIRST policy row, both arrows end on that one row;
  label: "many claims -> one policy")
- claim 5003 -> Policy row 10112 | 1 (the LAST policy row, not 10078)
- claim 5004 has a red arrow that ends in a red question mark, not on any policy row (label: "no matching policy");
  the row of claim 5004 is pale red.
Policy row 10045 | 2 and row 10078 | 1 receive no arrow.

Small panel at the bottom with a red cross: "NrPolicy alone is NOT a key: 10045 insures a CAR and a MOTORBIKE".
```

### Level 2 - simplified `img_A_keys_L2.png`

```text
Title at the top: "Primary key vs foreign key".
Left: a table "Policy" with only 2 columns, both blue: NrPolicy | NrObject and exactly these 3 rows, in this order:
10045 | 1
10045 | 2
10112 | 1
Badge above it: "PRIMARY KEY" and note below: "each row exactly once".
Right: a table "Claims" with 3 columns: NrClaim | NrPolicy | NrObject; the last two columns are blue (same blue):
5001 | 10045 | 1
5002 | 10045 | 1
5004 | 10230 | 1
Badge above it: "FOREIGN KEY" and note below: "can repeat".
Arrows (curved, each ends exactly on its row): claim 5001 -> Policy row 10045 | 1 (the FIRST policy row); claim 5002 ->
the same FIRST policy row 10045 | 1 (not the second row); the row of 5004 has a red arrow to a red question mark, not
to any policy row, and a pale red fill. The red arrow must end in the empty space BELOW the Policy table's last row,
at a red question mark, clearly not touching any policy row. Policy rows 10045 | 2 and 10112 | 1 receive no arrow.
Nothing else.
```

### Level 3 - abstract `img_A_keys_L3.png`

```text
No real data. Two small tables side by side, only coloured cells, short letters.
Left table: 3 rows, 3 columns. Two columns blue (cells "A1", "B1" / "A1", "B2" / "A2", "B1"), the third column
white with cells "x", "y", "z". Label above: "Primary key = unique". 
Right table: 3 rows, 3 columns. The first two columns blue with a dashed outline (cells "A1", "B1" / "A1", "B1" /
"A9", "B9"), the third column white with cells "p", "q", "r". Label above: "Foreign key = points to the primary key".
Arrows: the first two right rows both point to the left row "A1, B1"; the third right row has a red arrow ending in a
red question mark and a pale red fill.
```

---

## B1. `summarize()` vs `mutate()` after `group_by()`

### Level 1 - full `img_B_summarize_vs_mutate.png`

```text
Title at the top: "group_by() + summarize() vs group_by() + mutate()".

Top centre: input table "Policy", grouped by NrPolicy. Use the GROUP TINTS: the two 10045 rows are lavender across the
whole row, the 10078 row is peach across the whole row, the 10112 row is sand across the whole row (three groups,
three tints; in the result tables of both branches keep the same tint per NrPolicy group).
Columns: NrPolicy | NrObject | Veh_type2 | Premium_earned
Rows:
10045 | 1 | CAR | 310
10045 | 2 | MOTORBIKE | 120
10078 | 1 | CAR | 160
10112 | 1 | TRUCK | 640

Two arrows split into two branches.

LEFT branch, arrow label "summarize(n = n())". The result table is visibly SHORTER: one row per group, the other
columns are gone:
NrPolicy | n
10045 | 2
10078 | 1
10112 | 1
Caption under it: "3 rows: one per group". The n column is green (newly calculated).
Then arrow "filter(n > 1) |> arrange(desc(n))" to:
NrPolicy | n
10045 | 2
Box under the branch: "OVERVIEW: which keys are duplicated, and how many times?".

RIGHT branch, arrow label "mutate(n = n())". The result has the SAME 4 rows and all columns plus a green column n,
the group count copied to every row of its group:
NrPolicy | NrObject | Veh_type2 | Premium_earned | n
10045 | 1 | CAR | 310 | 2
10045 | 2 | MOTORBIKE | 120 | 2
10078 | 1 | CAR | 160 | 1
10112 | 1 | TRUCK | 640 | 1
Caption under it: "4 rows: n repeated on every row of its group".
Then arrow "filter(n > 1) |> arrange(NrPolicy)" to:
NrPolicy | NrObject | Veh_type2 | Premium_earned | n
10045 | 1 | CAR | 310 | 2
10045 | 2 | MOTORBIKE | 120 | 2
In this last table the cells with NrObject and Veh_type2 are yellow (the values that differ).
Box under the branch: "DETAIL: how do the duplicated rows differ?".
```

### Level 2 - simplified `img_B_summarize_vs_mutate_L2.png`

```text
Title: "summarize() vs mutate() after group_by()".
Top centre: a table with 2 columns NrPolicy | Veh_type2 and 4 rows, grouped by NrPolicy (use the GROUP TINTS across the
whole row: the two 10045 rows lavender, the 10078 row peach, the 10112 row sand - three different tints):
10045 | CAR
10045 | MOTORBIKE
10078 | CAR
10112 | TRUCK
LEFT arrow "summarize(n = n())" to a SHORT table (3 rows) with columns NrPolicy | n (n green):
10045 | 2
10078 | 1
10112 | 1
Caption: "one row per group".
RIGHT arrow "mutate(n = n())" to a table with the SAME 4 rows and a green n column:
10045 | CAR | 2
10045 | MOTORBIKE | 2
10078 | CAR | 1
10112 | TRUCK | 1
Caption: "all rows stay, n copied". No other text.
```

### Level 3 - abstract `img_B_summarize_vs_mutate_L3.png`

```text
No real data. Top centre: a small table with 2 columns and 4 rows; rows 1-2 have the same blue key cell "A" and rows
3 and 4 have "B" and "C". The second column holds white cells "x", "y", "z", "w". Rows 1-2 share a lavender tint,
the others a peach tint (groups).
LEFT arrow "summarize()" leads to a table of 3 rows: blue key cells A, B, C and green number cells 2, 1, 1.
Caption: "fewer rows, one per group".
RIGHT arrow "mutate()" leads to the same 4 rows as the input with an extra green column: 2, 2, 1, 1.
Caption: "same rows, number copied to every row of the group".
```

---

## B2. The recycled number trap

### Level 1 - full `img_B_recycled_n_trap.png`

```text
Title at the top: "A number copied to the whole group is a label, not a quantity".
Centre: the table after group_by(NrPolicy) |> mutate(n = n()):
NrPolicy | NrObject | Veh_type2 | n
10045 | 1 | CAR | 2
10045 | 2 | MOTORBIKE | 2
10078 | 1 | CAR | 1
10112 | 1 | TRUCK | 1
NrPolicy is the blue key column, n is the green column. The two "2" values are joined by a bracket labelled
"same fact written twice".
Right side, three small boxes stacked:
1) red cross: "sum(n) = 6" with the note "but there are only 4 vehicles".
2) green check: "filter(n > 1)" with the note "keep the duplicated rows".
3) green check: "read it as info" with the note "this policy has 2 vehicles".
Bottom caption: "Use it to filter or to read - do not aggregate it again."
```

### Level 2 - simplified `img_B_recycled_n_trap_L2.png`

```text
Left: a table with columns NrPolicy | n (n green) and 4 rows: 10045 | 2, 10045 | 2, 10078 | 1, 10112 | 1.
The two "2" cells are joined by a bracket labelled "same fact twice".
Right: a red cross next to "sum(n) = 6 (only 4 rows!)", a green check next to "filter(n > 1)", a green check next to
"read it". No other text.
```

### Level 3 - abstract `img_B_recycled_n_trap_L3.png`

```text
No real data. Left: a table of 4 rows with a blue key column (A, A, B, C) and a green number column (2, 2, 1, 1); the
two 2s are joined by a bracket. Right: a red cross next to the formula "2 + 2 + 1 + 1 = 6" with the note "double
counted"; a green check next to a funnel symbol labelled "filter"; a green check next to an eye symbol labelled "read".
```

---

## C1. Left join chain: the base table stays

### Level 1 - full `img_C1_left_join_chain.png`

```text
Title at the top: "left_join(): the base table keeps its rows, each join only adds columns".

Layout: a 2 x 2 grid of the 4 main tables, read left to right in the top row and then left to right in the bottom
row (table 1 top-left, table 2 top-right, table 3 bottom-left, table 4 bottom-right). Small white circles with the
numbers 1, 2, 3, 4 sit at the top-left corner of the main tables. Arrows: 1 -> 2 (horizontal, top row), 2 -> 3
(a long elbow arrow from the right end of the top row down and back to the left start of the bottom row), 3 -> 4
(horizontal, bottom row). Each arrow carries its join label written ON it. Each of the three small side tables
(claims, vehicle, customer) sits directly next to the label of the arrow it feeds, with a short thin arrow into the
main arrow. Each main table has exactly 4 rows and "4 rows" is written above each of them. The tables get WIDER from
1 to 4; the blue key columns NrPolicy and NrObject stay on the left of every table (no brackets); every newly added
column is green and has exactly the header text given below. Veh_type2 is an ordinary grey-header column, never blue.

Table 1 "Policy (base)":
NrPolicy | NrObject | Veh_type2
10045 | 1 | CAR
10045 | 2 | MOTORBIKE
10078 | 1 | CAR
10112 | 1 | TRUCK

Arrow 1, label "left_join(claims)". Above the arrow a small table "claims (aggregated)":
NrPolicy | NrObject | Paid
10045 | 1 | 2000
10112 | 1 | 4500
10230 | 1 | 2000
The 10230 row falls off the table into a small grey bin, label: "no match in base: dropped".

Table 2 (one green column added):
NrPolicy | NrObject | Veh_type2 | Paid
10045 | 1 | CAR | 2000
10045 | 2 | MOTORBIKE | NA
10078 | 1 | CAR | NA
10112 | 1 | TRUCK | 4500

Arrow 2, label "left_join(vehicle)". The side table "vehicle (1 row per policy + object)" feeding it:
NrPolicy | NrObject | VEH_brand | Sum_insured
10045 | 1 | B07 | 12000
10045 | 2 | B12 | 3000
10078 | 1 | B07 | 9000
10112 | 1 | B03 | 25000
Table 3 (two more green columns):
NrPolicy | NrObject | Veh_type2 | Paid | VEH_brand | Sum_insured
10045 | 1 | CAR | 2000 | B07 | 12000
10045 | 2 | MOTORBIKE | NA | B12 | 3000
10078 | 1 | CAR | NA | B07 | 9000
10112 | 1 | TRUCK | 4500 | B03 | 25000

Arrow 3, label "left_join(customer, by = 'NrPolicy')". Above the arrow a small table "customer (1 row per policy)":
NrPolicy | Customer_Type
10045 | S
10078 | C
10112 | C
Table 4 (one more green column):
NrPolicy | NrObject | Veh_type2 | Paid | VEH_brand | Sum_insured | Customer_Type
10045 | 1 | CAR | 2000 | B07 | 12000 | S
10045 | 2 | MOTORBIKE | NA | B12 | 3000 | S
10078 | 1 | CAR | NA | B07 | 9000 | C
10112 | 1 | TRUCK | 4500 | B03 | 25000 | C
The two "S" cells are joined by a bracket labelled "one value copied to both vehicles".

Bottom caption: "Base table = row anchor. Rows stay, columns grow, NA where nothing matched."
```

### Level 2 - simplified `img_C1_left_join_chain_L2.png`

```text
Title: "left_join(): rows stay, columns grow".
Three tables left to right, each with exactly 3 rows, "3 rows" written above each. Blue key column NrPolicy on the
left of each table; new columns green.
Table 1 "base": NrPolicy: 10045, 10078, 10112 (blue only).
Arrow "left_join(claims)" with a small table above it: 10045 | Paid 2000 and 10230 | Paid 2000; the 10230 row falls
into a grey bin labelled "dropped".
Table 2: NrPolicy | Paid : 10045 | 2000, 10078 | NA (grey cell), 10112 | NA (grey cell).
Arrow "left_join(customer)" with a small table above it: 10045 | S, 10078 | C, 10112 | C.
Table 3: NrPolicy | Paid | Customer_Type: 10045 | 2000 | S, 10078 | NA | C, 10112 | NA | C.
Caption: "Same rows, more columns."
```

### Level 3 - abstract `img_C1_left_join_chain_L3.png`

```text
No real data. A row of 3 tables connected by arrows labelled "left_join". Each has 4 rows (label "4 rows").
Table 1: only a blue column (A, B, C, D).
Table 2: blue column plus one green column: v1, NA, v2, NA (NA cells grey).
Table 3: blue column, the green column from before, and a second green column: w1, w1, w2, w3.
Small side tables feeding each arrow, each with one extra row (letter E) that falls into a grey bin.
Caption: "rows never change, columns grow".
```

---

## C2. Granularity changes through a join

### Level 1 - full `img_C2_granularity_fanout.png`

```text
Title at the top: "Joining a table with MORE rows per key changes your granularity".

Left: table "Policy (4 rows)":
NrPolicy | NrObject | Premium_earned
10045 | 1 | 310
10045 | 2 | 120
10078 | 1 | 160
10112 | 1 | 640
Middle: table "Claims, raw: one row per claim":
NrClaim | NrPolicy | NrObject | Paid
5001 | 10045 | 1 | 1200
5002 | 10045 | 1 | 800
5003 | 10112 | 1 | 4500
BOTH of the first two rows (5001 and 5002) are pale red with one red outline around the two rows (same
NrPolicy + NrObject twice).

Arrows from both input tables to the result table; the label "left_join(by = c('NrPolicy', 'NrObject'))" sits on the
arrow, and "5 rows" is written in red directly above the result table:
NrPolicy | NrObject | Premium_earned | NrClaim | Paid
10045 | 1 | 310 | 5001 | 1200
10045 | 1 | 310 | 5002 | 800
10045 | 2 | 120 | NA | NA
10078 | 1 | 160 | NA | NA
10112 | 1 | 640 | 5003 | 4500
The first two rows are pale red with a red outline; both "310" are red and bold with the label "premium duplicated".
NrClaim and Paid are green columns.

Below the result: a red cross with "sum(Premium_earned) = 1540" and a green check with "true premium = 1230".
Bottom caption: "4 rows in, 5 rows out: one vehicle now appears twice."
```

### Level 2 - simplified `img_C2_granularity_fanout_L2.png`

```text
Title: "More rows per key in the joined table = more rows in the result".
Left: table "base" with columns NrPolicy | Premium: 10045 | 310, 10078 | 160 ("2 rows", NrPolicy blue).
Middle: table "claims" with columns NrPolicy | Paid: 10045 | 1200, 10045 | 800 (both rows pale red; NrPolicy blue).
Arrow "left_join()" to the result with "3 rows" in red: columns NrPolicy | Premium | Paid (Paid green):
10045 | 310 | 1200
10045 | 310 | 800
10078 | 160 | NA
The first two rows are pale red and both 310 are red. Below: red cross "sum(Premium) = 780", green check
"true = 470". No other text.
```

### Level 3 - abstract `img_C2_granularity_fanout_L3.png`

```text
No real data. Left: a table with a blue key column (A, B) and a white column (x, y); "2 rows". Middle: a table with a
blue key column (A, A) and a green column (1, 2), both rows pale red; label "A twice". Arrow "left_join" to the result
with "3 rows" in red: the first row A, x, 1 and the second row A, x, 2 are pale red with both x in red, the third row
B, y, NA with a grey NA cell. Red cross and the caption "row A was duplicated".
```

---

## C3. Resolving granularity before or after the join

### Level 1 - full `img_C3_resolve_granularity.png`

```text
Title at the top: "Fix the granularity BEFORE joining".

On the far left, stacked vertically, two small input tables: "Policy (4 rows)" at the top with columns
NrPolicy | NrObject | Premium_earned (10045 | 1 | 310, 10045 | 2 | 120, 10078 | 1 | 160, 10112 | 1 | 640) and
"Claims raw (3 rows)" below it with columns NrPolicy | NrObject | Paid (10045 | 1 | 1200, 10045 | 1 | 800,
10112 | 1 | 4500); in the claims table the two 10045 rows are pale red. From the two inputs, two clearly separated
horizontal lanes lead to the right: the TOP lane in the upper half and the BOTTOM lane in the lower half. Both
lanes start from BOTH input tables (Policy and Claims) - draw the arrows into each lane from both.

TOP lane, with a big green check mark and the word "PREFERRED":
Step 1, arrow "summarize(Paid = sum(Paid)) by NrPolicy, NrObject" applied to the claims only, giving:
NrPolicy | NrObject | Paid
10045 | 1 | 2000
10112 | 1 | 4500
with the note "claims now at policy + object level".
Step 2, arrow "left_join()" giving the final table with "4 rows" in green:
NrPolicy | NrObject | Premium_earned | Paid
10045 | 1 | 310 | 2000
10045 | 2 | 120 | NA
10078 | 1 | 160 | NA
10112 | 1 | 640 | 4500
Note: "one aggregation, only on the claims columns".

BOTTOM lane, with an amber warning triangle and the words "LESS PREFERRED":
Step 1, arrow "left_join()" with the raw claims giving a table with "5 rows" in red (10045 | 1 | 310 appears twice,
the two rows pale red).
Step 2, arrow "summarize() by NrPolicy, NrObject" giving the same 4-row table as in the top lane.
Two amber notes: "decide for EVERY column how to aggregate it" and "sum(Premium_earned) would double count".

Bottom caption: "Same result, but the top lane is simpler and safer."
```

### Level 2 - simplified `img_C3_resolve_granularity_L2.png`

```text
Title: "Fix the granularity BEFORE joining".
Left, stacked vertically: two tiny inputs. "base" is a one-column table with the blue header NrPolicy and the rows
10045, 10078. "claims" is a TWO-column table with the blue header NrPolicy and the grey header Paid and the rows
10045 | 1200 and 10045 | 800 (each value sits in its own column, in the same row).
TOP lane with a big green check and the word "PREFERRED": arrow "summarize()" to a 1-row claims table (10045 | 2000), then
arrow "left_join()" to a result "2 rows" (10045 | 2000, 10078 | NA).
BOTTOM lane with an amber triangle and the words "LESS PREFERRED": arrow "left_join()" to a result "3 rows" in red
(10045 | 1200, 10045 | 800, 10078 | NA; ONLY the two 10045 rows are pale red, the 10078 row is not red), then arrow
"summarize()" to the same "2 rows" result. Caption: "Same result, but the top lane is simpler and safer."
```

### Level 3 - abstract `img_C3_resolve_granularity_L3.png`

```text
No real data. Two lanes from the same inputs: a blue-key table "base" (A, B) and a table "y" with blue keys (A, A) and a
green column (1, 2).
TOP lane with a green check and "BEFORE": the table y is squeezed into one row (A, 3), then "left_join" gives 2 rows
(A, 3 / B, NA).
BOTTOM lane with an amber triangle and "AFTER": "left_join" gives 3 rows in red (A,1 / A,2 / B,NA), then a squeeze
arrow gives the same 2 rows.
Caption: "Squeeze the table you join, not the result."
```
