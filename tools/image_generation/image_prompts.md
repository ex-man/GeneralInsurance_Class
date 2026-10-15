# Image prompts for Lesson 4 Exercise 1

Prompts for an image model (used: `gemini-3-pro-image-preview`) that generate the six explanatory pictures used in
`Lessons/Lesson4/Exercises/Lesson4_Ex1_DataPrep_filled.Rmd` (saved in `Lessons/Lesson4/Support/img_*.png`).
`generate_images.py` reads this file (see `README.md`), so keep the structure: each prompt is a ```` ```text ````
block under a `###` heading that ends with the output filename in backticks.

These are the simplified versions that were picked for the lesson after trying a full-detail and an abstract
(letters only) variant of each picture; those variants are in git history (commit "Lesson 4 Ex1: add generated
explanatory images"). Generated images are never exact - review each one against its prompt and regenerate if needed.

## Example data

The values are made up, but column names and formats match our real data (`Data/data_dictionary.txt`).

**Policy** - one row per policy + object (insured vehicle). Primary key = `NrPolicy` + `NrObject`.

| NrPolicy | NrObject | Year | Dt_Exp_Start | Dt_Exp_End | Veh_type2 | D_age | Premium_earned |
|---|---|---|---|---|---|---|---|
| 10045 | 1 | 2014 | 01.01.2014 | 31.12.2014 | CAR | 34 | 310 |
| 10045 | 2 | 2014 | 01.01.2014 | 31.12.2014 | MOTORBIKE | 34 | 120 |
| 10078 | 1 | 2014 | 01.07.2014 | 31.12.2014 | CAR | 52 | 160 |
| 10112 | 1 | 2015 | 01.01.2015 | 31.12.2015 | TRUCK | 45 | 640 |

**Claims** - one row per claim. `NrClaim` is the primary key of Claims in the pictures; `NrPolicy` + `NrObject` is
a foreign key to Policy. (Simplification: in the real data 16 claim numbers are duplicated - that is the "surprise"
students find in the exercise itself.)

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

### `img_A_keys.png`

```text
Title at the top: "Primary key vs foreign key".
Left: a table "Policy" with only 2 columns, both blue: NrPolicy | NrObject and exactly these 3 rows, in this order:
10045 | 1
10045 | 2
10112 | 1
Badge above it: "PRIMARY KEY" and note below: "unique: each row exactly once".
Right: a table "Claims" with 3 columns: NrClaim | NrPolicy | NrObject. All three columns are blue (same blue) because
all are keys, exactly these 3 rows in this order:
5001 | 10045 | 1
5002 | 10045 | 1
5003 | 10112 | 1
Two badges above the table: one over the NrClaim column "PRIMARY KEY" (the same badge style as on the Policy table),
and one spanning the NrPolicy and NrObject columns "FOREIGN KEY" (a dashed outline version of the badge).
Note below the table: "foreign key: can repeat, does not always have to match".
Arrows (curved, each ends exactly on its row): claim 5001 -> Policy row 10045 | 1 (the FIRST policy row); claim 5002 ->
the same FIRST policy row 10045 | 1 (not the second row); claim 5003 -> Policy row 10112 | 1 (the LAST policy row).
Policy row 10045 | 2 receives no arrow. The arrows have NO text labels at all (no "connect" or similar). No red colour
anywhere, no question mark, no unmatched row. Nothing else.
```


## B1. `summarize()` vs `mutate()` after `group_by()`

### `img_B_summarize_vs_mutate.png`

```text
Title: "summarize() vs mutate() after group_by()".
COLOURING RULE for this picture: every policy number has its own tint, applied to the cells of the NrPolicy and
Veh_type2 columns of its rows (the header cells keep their normal colour): policy 10045 = lavender (#E9E3F7),
policy 10078 = peach (#FFE6D0), policy 10112 = sand (#F1EBD0). The two 10045 rows share lavender; the 10078 row is
peach; the 10112 row is sand - three clearly different tints, never reused for another policy. The n column is
always green (never tinted by group).
Top centre: a table with 2 columns NrPolicy | Veh_type2 and 4 rows, tinted by the colouring rule:
10045 | CAR
10045 | MOTORBIKE
10078 | CAR
10112 | TRUCK
LEFT arrow "summarize(n = n())" to a SHORT table (3 rows) with columns NrPolicy | n; ONLY the NrPolicy cells are
tinted (10045 lavender, 10078 peach, 10112 sand), the n cells are green:
10045 | 2
10078 | 1
10112 | 1
Caption: "one row per group".
RIGHT arrow "mutate(n = n())" to a table with the SAME 4 rows and a green n column; the NrPolicy and Veh_type2 cells of
each row keep the tint of their policy (as in the input table), the n cells are green:
10045 | CAR | 2
10045 | MOTORBIKE | 2
10078 | CAR | 1
10112 | TRUCK | 1
Caption: "all rows stay, n copied". No other text.
```


## B2. The recycled number trap

### `img_B_recycled_n_trap.png`

```text
Title at the top: "A number copied to the whole group is a label, not a quantity".
Centre: the table after group_by(NrPolicy) |> mutate(n = n()) - exactly 3 columns, there is NO NrObject column:
NrPolicy | Veh_type2 | n
10045 | CAR | 2
10045 | MOTORBIKE | 2
10078 | CAR | 1
10112 | TRUCK | 1
NrPolicy is the blue key column, n is the green column. The two "2" values are joined by a bracket labelled
"same fact written twice".
Right side, three small boxes stacked:
1) red cross: "sum(n) = 6" with the note "but there are only 4 vehicles".
2) green check: "filter(n > 1)" with the note "keep the duplicated rows".
3) green check: "read it as info" with the note "this policy has 2 vehicles".
Bottom caption: "Use it to filter or to read - do not aggregate it again."
```


## C1. Left join chain: the base table stays

### `img_C1_left_join_chain.png`

```text
Title: "left_join(): rows stay, columns grow".
Three tables left to right, each with exactly 3 rows, "3 rows" written above each. Blue key column NrPolicy on the
left of each table; new columns green.
Order of the joins: first a table that matches every base row, then a table that matches only some of them.
Table 1 "base": NrPolicy: 10045, 10078, 10112 (blue only).
Arrow "left_join(customer)" with a small table "customer" above it: NrPolicy | Customer_Type : 10045 | S,
10078 | C, 10112 | C (every base policy has a match).
Table 2: NrPolicy | Customer_Type : 10045 | S, 10078 | C, 10112 | C (Customer_Type green).
Arrow "left_join(claims)" with a small table "claims" above it: NrPolicy | Paid : 10045 | 2000, 10230 | 2000
(only the 10045 row has a match in the base; plain table, no bin, no extra arrow, no red, no marking of the 10230 row).
Table 3: NrPolicy | Customer_Type | Paid : 10045 | S | 2000, 10078 | C | NA, 10112 | C | NA (Paid green, NA cells
light grey).
Caption: "Same rows, more columns."
No bins, no "dropped" labels, no extra arrows.
```


## C2. Granularity changes through a join

### `img_C2_granularity_fanout.png`

```text
Title: "More rows per key in the joined table = more rows in the result".
Top row, two tables side by side with a clear LEFT / RIGHT roles:
- Left: table titled "policy (base)" with a small caption under it "left table": columns NrPolicy | Premium
  (NrPolicy blue): 10045 | 310, 10078 | 160 ("2 rows").
- Right: table titled "claims" with a small caption under it "right table": columns NrClaim | NrPolicy | Paid
  (NrClaim and NrPolicy both blue): 5001 | 10045 | 1200 and 5002 | 10045 | 800; both rows pale red with one red
  outline ("2 rows").
- Between the two tables, centred, a small two-circle Venn symbol (the left circle filled in solid blue, the right
  circle only outlined) with the text "left_join()" under it; from this symbol one thick arrow points DOWN to the
  result table.
Below: the result table with "3 rows" in red above it: columns NrPolicy | Premium | NrClaim | Paid (NrClaim and Paid
green):
10045 | 310 | 5001 | 1200
10045 | 310 | 5002 | 800
10078 | 160 | NA | NA
The first two rows are pale red with one red outline and both 310 are red. Next to the result: red cross
"sum(Premium) = 780", green check "true = 470". No other text.
```


## C3. Resolving granularity before or after the join

### `img_C3_resolve_granularity.png`

```text
Title: "Fix the granularity BEFORE joining".
LAYOUT: horizontal BANDS, read top to bottom, two columns (left = PREFERRED, right = LESS PREFERRED) pushed close to
the centre - leave only a SMALL gap between the columns, just wide enough for the policy (base) table and two short
connectors. The single shared "policy (base)" table (one column, blue header NrPolicy, rows 10045, 10078) appears
exactly ONCE, in the centre, in BAND 3.
Band 0 (header): left: a big green check and the word "PREFERRED" with "summarize the claims first"; right: an amber
warning triangle and the words "LESS PREFERRED" with "join first, summarize after".
Band 1: LEFT only: table "claims": columns NrClaim | NrPolicy | Paid (NrClaim and NrPolicy blue), rows 5001 | 10045 | 1200
and 5002 | 10045 | 800, both rows pale red. RIGHT: empty.
Band 1->2: LEFT only: a short vertical arrow down labelled "summarize()" (it acts on the claims table above it).
Band 2: LEFT: table "claims per policy": columns NrPolicy | Paid, one row 10045 | 2000 (Paid green). RIGHT, at the
SAME height: the same table "claims" as in band 1 (same rows, same pale red).
Band 3 (the JOIN band, centre): LEFT and RIGHT: a short vertical JOIN ARROW pointing down from the band-2 table of
that column; it has NO text label of its own. The two JOIN ARROWS are exactly equally long (about two table rows
tall), with a clear EMPTY GAP of white space between the arrowhead and the table of band 4. Each horizontal
connector from policy (base) must end on the MIDDLE OF THE SHAFT of its vertical JOIN ARROW (in the empty space
between the band-2 table and the band-4 table) - the connector must NEVER touch the band-4 table (neither "joined" nor
the left result table). The right JOIN ARROW starts at the bottom of the raw "claims" table and ends above "joined".
Draw NO vertical bar characters ("|") anywhere, no grey background bands or panels, no cell borders other than thin
grey grid lines. In the centre, at the SAME height as these two join arrows, sits the
"policy (base)" table. Two SHORT, straight, horizontal connectors START at the policy (base) table (no arrowhead on
the policy side) and point OUTWARD, the left one to the middle of the left JOIN ARROW and the right one to the middle
of the right JOIN ARROW, each ending with an arrowhead that touches that vertical arrow (so the base is joined with
the table ABOVE the arrow, not with the table below it). Each connector carries the label "left_join()" written
centred directly above it. These are the only arrows leaving the policy table; no arrowhead points into it.
Band 4: LEFT: result table "2 rows": NrPolicy | Paid: 10045 | 2000, 10078 | NA (Paid green, NA light grey). RIGHT:
table "joined" with "3 rows" in red: NrPolicy | Paid: 10045 | 1200, 10045 | 800, 10078 | NA; ONLY the two 10045 rows
are pale red.
Band 4->5: RIGHT only: a short vertical arrow down labelled "summarize()" (it acts on the joined table above it).
Band 5: RIGHT only: the same result table "2 rows" as on the left (NrPolicy | Paid: 10045 | 2000, 10078 | NA). LEFT: empty.
Caption at the bottom: "Same result, but summarizing the claims first is simpler and safer."
```

