TODO
- Lessons 5-6: code and support material review (see detailed follow-ups from the Lesson 4 review below)
- Lessons 5-6: prepare partial blank versions for students (if applicable)
- Lesson 4: student versions (Lesson4_Ex1_DataPrep.Rmd, Lesson4_Ex2_TargetAnalysis.Rmd) contain [STUDENT TASK]
  markers with suggested blanks / write-from-scratch sections. Before handing out: replace the marked code with ___
  (or delete it for write-from-scratch) and drop the "# Suggested ..." helper comments. Solutions: *_filled.Rmd.
- Lesson 4 Ex1: filled version restructured (helpers check_primary_key / show_highest_duplicates / show_duplicate_info /
  join_summary, period-of-cover filter moved before the join, investigation moved to a Bonus section; saved
  dt_pol_w_claims.rds verified identical). TO DO:
  - [x] 6 explanatory images generated and saved in Lessons/Lesson4/Support/img_*.png (prompts and usage of the
        generator: tools/image_generation/)
  - [ ] manually create the new partially blanked student version Lesson4_Ex1_DataPrep.Rmd from the new _filled.Rmd
        and insert it (the old one still has the previous structure). The helper-function chunk ("Exercise: wrap the
        patterns into helper functions") is filled in the _filled version and is the natural place for blanks.
  - [ ] consider (exploration only, nothing decided): do the "claim within policy cover" fix (and the claim year
        handling) AFTER the join as a simple filter, instead of before it, to streamline the lesson. Points to weigh:
        - currently the fix sits before the join: inner_join claims to policy dates + between() filter, then one
          aggregation (keeps the join itself simple and the saved dt_pol_w_claims.rds is unchanged);
        - post-join would mean: aggregate claims per policy + object + claim year, left join, then drop/blank claim
          columns where the claim year (or loss date) is outside the cover. But claims are aggregated to claim year
          before the join, so the loss date is gone - a post-join filter on the year alone cannot detect claims
          outside the cover within the same year (1 of the 37 such claims) and a dropped claim row would also turn
          the policy row into "no claim" (needs care to keep one row per policy);
        - alternatives: join on the raw claims (fan-out, then aggregate), or aggregate after the join with the loss
          date still available;
        - whichever is chosen must still save an identical dt_pol_w_claims.rds (or L5/L6 data/text need an update, see
          the BLOCKING section below).

## Lesson 5 — follow-ups from Lesson 4 review
- [x] L5 Ex3: port the Lift Chart section from the Class 2025 Posit Cloud export
      (Lesson5_Ex3_InsuranceModeling.Rmd l.378-424 in the 2025 version, placed after the model4 RMSE chunk).
      Also add "plotly", "ggplot2" to `libs` (l.17), as in 2025.
      Keep the repo's homework info block, Student1..N names and
      `dt_pol_w_claims[complete.cases(dt_pol_w_claims[all_vars]), ]` - the 2025 version
      `filter(complete.cases(.[all_vars]))` does not work with the native pipe |>.
- [x] L5 Ex2:31, Ex3:29 — text says "data from Lesson 5", should be "data from Lesson 4".
- [x] L5 Ex1 / Ex2 / Ex3 — state the units once (done in Ex1) (e.g. in Ex1 intro): Time_Exposure = fraction of a year in (0, 1],
      Burning_Cost = loss per policy-year, Ult_Loss = Paid + Reserves (incurred, no IBNR). All prepared in Lesson 4 Ex2.
- [ ] L5 Data/data_dictionary.txt — already synced with Lesson 4 (Capacity cm3, Nr_payments, Settlement_date,
      Time_Exposure / Ult_Loss / Burning_Cost definitions). Keep the two files identical going forward.
- [ ] L5 Data/glm_models.rds — optional: regenerate by re-running Ex3 on the refreshed dt_pol_w_claims_target.rds.
      Verified the change has no material effect (coefficients identical to 3 dp; Ex1 MOTORBIKE -46% / TRUCK +64% unchanged).
- [ ] L5 Homework — hw5 (VEH_brand) and hw8 (BonusMalus) predictors are swapped compared to Class 2025.
      Repo version is consistent (high-cardinality HINT sits on the VEH_brand task) — keep it, just be aware
      when comparing with 2025 materials / submissions.
- [ ] L5 Ex3 `libs` (l.17) — check the purpose of `reshape2`, `patchwork` and `lazyeval`. None are called directly in
      Ex3; likely needed by the sourced Support helpers (emb_chart_plotly.R, get_vars.R, rmse_group.R) or leftovers.
      If a helper needs them, add a comment in cell_01 saying why; if not, consider removing them from `libs`.
- [ ] L5 + L6 `emb_chart_plotly.R` (Lesson5/Support/ and Lesson6/Support/functions/) — fails when the model's embedded
      data already has a `pred` column (e.g. a student added one). When `dt.frm` is NULL the function builds the data
      with `cbind(model$data, data.frame(pred = predict(model, model$data, type = "response")))`. `cbind` keeps the
      existing `pred` and adds a second one, so the duplicate name breaks the later `pred` references. Fix: use
      `dplyr::mutate(model$data, pred = predict(...))` (or overwrite the column) so an existing `pred` is replaced, and
      check the same pattern in any other helper (e.g. `rmse_group.R`, `compare_models.R`).

## Lesson 6 — follow-ups from Lesson 4 review
- [ ] L6 Support/02_data_prep.Rmd:34 — "Load the data from Lesson 5" -> "Lesson 4".
- [ ] L6 Exercises/03_GLM_Improvement_Evaluation.Rmd — train and valid get different transformations:
      - Capacity_banded breaks: l.114 train c(-Inf, 1300, 2000, 3000, Inf) vs l.138 valid c(-Inf, 0, 1300, 2000, 3000, Inf)
      - Sum_insured_capped: l.125 train caps at 15000 vs l.149 valid at 20000 (and the comment says 20000)
      Use identical transformations for both (ideally one helper function applied to train and valid).
- [ ] L6 Data/data_gbm.rds, glm_models.rds — optional regenerate after the target RDS refresh
      (no material change expected; data_gbm.rds is already in year units).
- [ ] L6 README.md:10 and Exercises/04_Final_Model_Fit.Rmd:139 — feedback form URL differs:
      repo `0pijTdVZSR` vs Class 2025 `ry1by313PH`. Confirm the current one before the class.
- [ ] L6 (or L5 Ex3 as a short note) — investigate how to interpret a numeric coefficient in a GLM with log link.
      Example: if exp(Beta) = 0.86 for a numeric variable, is the target (riskiness) 14% lower per one-unit increase,
      or is the interpretation different? Check the exact wording: the multiplier applies to the expected mean of the
      target, per unit of the variable, and is constant on the log scale (same relative effect at every level), unlike
      a linear model where the effect is additive. Also check whether "14% lower" is the right phrasing versus
      "multiplied by 0.86", and whether the target is "riskiness" or the expected loss cost. Decide whether this fits
      as L6 content or as a point in an existing lesson.
- [ ] L6 — variable selection as a natural continuation of the L5 homework. Students struggle with choosing variables
      in L5 and mostly do it by hand, so L6 could cover three approaches:
      1. Programmatic forward selection using RMSE (validation) as the criterion. Start from the base model, try each
         remaining candidate, keep the best, repeat until no candidate improves RMSE. Optionally show exhaustive
         search over all combinations and explain why it becomes infeasible quickly.
      2. Filter/shrinkage method (L1 / lasso, or L2 / ridge, whichever suits the GLM best) to let the penalty drop
         weak variables. Compare the selected set with the forward selection result.
      3. Visual screening that builds on the L5 "unfitted variables" visuals (see `homework_hints.md` and the main
         Lesson 5 material for why unfitted variables are plotted). A helper computes, for each unfitted variable,
         the exposure-weighted mismatch in burning cost (actual vs fitted) by category, then:
         - ranks variables by the highest exposure-weighted mismatch and plots them in that order,
         - flags mismatches that also show a trend (visually, or with a simple exposure-weighted trend measure
           such as a weighted correlation or slope of actual minus fitted against the variable's level).
         This extends the L5 visual check to many variables at once and lets students look only at the plots
         that matter.
      Open questions: whether the helper belongs in `Support/` (shared by L5 and L6) and how much code is acceptable
      for students to read in class.
- [ ] L6 — build an "ideal" feature-engineered dataset as the starting point for the variable selection section.
      Variable selection works better on well-prepared features, so:
      - review the most reasonable adjustment for each variable (banding or capping of categoricals and numerics,
        rare-level grouping, e.g. D_ZIP, Capacity, Construct_year, Sum_insured, Nr_of_seats, VEH_brand),
      - consider numeric transforms where they help, e.g. log transform for skewed variables (Sum_insured,
        Capacity) and squared / polynomial terms for non-linear shapes (e.g. Construct_year, Time_on_book, D_age),
      - create the final dataset in a Support script (or Data/ RDS) with every adjustment documented in comments and
        a short table listing variable, transform, reason and the L5 visual that motivated it,
      - L6 starts with a short section on feature engineering, then loads the improved dataset, so students can
        inspect it if they wish, and continues to variable selection on it.
      Open questions: how many transforms to include (keep it teachable), whether to keep the raw variables alongside
      the transformed ones, and whether the L5 homework should be aligned with the same adjustments (or deliberately
      left on raw data so the difference is visible).

## Class 2026 feedback — pacing and visuals
- [ ] L4 — potentially shorten the data prep, or at least cover it in a more streamlined way. Class 2026 spent one
      whole lesson on L4 data prep and another whole lesson on L4 target analysis.
- [ ] L4 — related: to streamline the target analysis exercise, maybe don't iterate on the visuals so much (e.g. the
      x-axis label rotation, or other cosmetic tweaks).
- [ ] L5 — add visuals that explain what actual vs fitted differences mean, for both fitted and unfitted variables.
      Reuse the new image generation approach in `tools/image_generation/` for this, and use the same images in
      L5 Ex3 and `Lesson5/Homework/homework_hints.md`.
- [ ] L5 — explicitly teach turning a numeric variable into a categorical one as a feature engineering option. It is
      currently only implicit (banding, truncating or rounding). Explain the reasoning with visuals: when the actual
      mean goes up and down with no clear trend, or follows a non-linear (e.g. exponential) trend rather than a
      linear one, a linear term fits poorly and banding into categories captures it better.
      Concrete case for L5 Ex3: after capping `Construct_year` (cell_16-17), the fitted vs actual lines show that a
      monotonic numeric trend does not fit well. Add a comment in the text mentioning that it could be split into
      three bands (early, middle and later years) as a second example of the same idea. No need to implement the
      banding or refit.
- [ ] L5 `Homework/homework_hints.md` — add a hint: if the project/environment restarts repeatedly right after fitting
      a GLM, which often happens for categorical variables with many distinct values in their original unadjusted
      form (e.g. `D_ZIP`), students should increase the computational resources of their environment, following the
      Posit documentation (link: https://docs.posit.co/cloud/guide/projects/#resources-settings).
- [ ] L5 — before the class, increase the Posit Cloud project resources for the homework project so students fitting
      a GLM with the original D_ZIP don't struggle (restarts / out-of-memory). Check what the resource limits are and
      what they cost. Alternative or complement: give students an option to fit on a smaller sample of rows with the
      original D_ZIP, and document that trade-off in the homework hints.
- [ ] L5 — verify how the GLM picks the baseline (reference) level for categorical variables. Check whether R's default
      is alphabetical (first level after sorting, or the factor's level order), or whether our code/data sets it by
      highest exposure or another rule. A student suspects Nr_of_seats uses level 1 rather than level 5 as the
      baseline. Confirm by inspecting `levels()` / `contrasts()` and the coefficient names in the fitted model, and
      check how the homework and Ex3 code create the factors. Then note in the lesson or hints how the baseline is
      chosen and how to change it (e.g. `relevel()` or ordering factor levels by exposure).
- [ ] L4/L5 — consider capping the target (burning cost / Ult_Loss per policy-year) at the 99th percentile before
      L5 modelling and homework, so a few extreme outliers don't dominate RMSE. Investigate thoroughly first:
      - how many policies are above the 99th percentile, and how much of total loss and of RMSE they account for
        (compare RMSE with and without the cap, and check whether model ranking changes),
      - whether the cap belongs in the data (Lesson 4 Ex2 / saved RDS) or in the L5 modelling code,
      - whether capping hides real risk (the cap removes large losses from the fitted model, so the expected loss
        cost is understated; check the exposure-weighted total before and after),
      - what changes in material: L4 Ex2 text and KPIs, L5 Ex1-Ex3 numbers, homework RMSE references and
        homework_hints.md, data_dictionary.txt, and the BLOCKING regeneration list.
- [ ] L5 Homework / Ex3 — some variables (e.g. D_ZIP, VEH_brand) have levels present in train but not in valid, or the
      reverse. Investigate how often this happens and how the GLM predict step handles unseen levels (error, NA, or
      silent drop). Then add updates or snippets to `Homework/homework_hints.md` on how to deal with it (e.g. collapse
      rare levels, group into an "other" category, or align factor levels between train and valid before predicting).
- [ ] L5 Homework — some assignments say to "read the end of the insurance modeling exercise" (Ex3). The hint is
      vague. Investigate: point it to the specific part of the exercise or to `Homework/homework_hints.md`, or drop
      it. The D_ZIP and Capacity info (truncating, rounding) is now in both the Ex3 Rmd and the homework hints, so the
      hint may not be needed at all.
- [ ] L5 Homework instructions — add one sentence saying students should give a brief reasoning for why they chose
      each additional variable, since most do not comment on it. Add it to the homework text (`Homework/` and the
      zadanie files).
- [ ] L5 `Homework/homework_hints.md` — add guidance on interpreting GLM coefficients. Most students read them like
      linear regression coefficients, which is wrong with a log link:
      - categorical: each coefficient is a multiplier relative to the baseline level (exp(Beta)), not an additive
        shift, and the baseline is the level in the intercept (link to the open "baseline level" item above),
      - numeric: exp(Beta) is the multiplier for a one-unit increase, applied to the expected mean; a value of 0.86
        means about 14% lower, and the effect is the same at every level of the variable (see the open "numeric
        coefficient interpretation" item in L6),
      - add one worked example per type, using a variable from the homework, and a short "do not read it like linear
        regression" warning. Material coverage in L5 is thin, so the hints may be the main place for this.

## Lesson 6 alt — blocking items for today (new)
Scope: `Lessons/Lesson6_alt/` (Exercises, Support, Homework). Blocks Lesson 6.
- [x] Bottom-line prose per variable — add a short prose summary of each candidate variable and its final adjustment
      (one paragraph or bullet each, plus Veh_type2_merged as the base). Decide where it goes: `Support/feature_engineering.Rmd`
      (next to the "Summary of the decisions" table, cell_31) and/or `Exercises/Lesson6_Ex1_VariableSelection.Rmd`
      (students read this, the FE file is "read, do not run"). Ex1 intro currently only says "every variable is already
      prepared". Cover all 13 `candidate_vars`; the content should match `decision_table` so the two do not diverge.
- [x] (study done) Deviance vs row-level RMSE for the selections — test whether row-level RMSE (no 5-group aggregation) would make the
      same decisions as the deviance in the three methods. Leave `Support/feature_engineering.Rmd` as it is.
      - Run each step with both criteria: forward selection path (`forward_select`), chart ranking steps 1-2
        (`fit_and_rank`), lasso entry order. Use several seeds of the 80/20 split (and/or CV folds on train).
      - Compare: same variable chosen per step, same best model on the validation path, rank agreement of the
        candidates. Note the target is already capped at the 99.5th percentile, so RMSE outlier effects are smaller here.
      - Decision rule: if they agree, use row-level RMSE in the selection code (simpler to explain) and keep the deviance
        only as a remark; if not, keep the deviance in the selection code.
      - Material either way: the Tweedie unit deviance in LaTeX (matches `tweedie_deviance()`, power 1.5), plus intuition:
        for a Gaussian model the deviance is the RSS, and deviance explained = 1 - D_model / D_null is the GLM analogue of
        R^2. Answers to the open questions (monotone on training data, no complexity penalty, empirical vs statistical)
        go in the reply, not in the material.
- [x] `load_l6_data()` — remove the function and do its work once in `Support/feature_engineering.Rmd`. It currently does
      three things: `Year` to character, `D_age_chart` banding (`cut()`), and the split on the existing `Dataset` column.
      Plan:
      - add the `Year` conversion and `D_age_chart` to the dataset in the FE step (cell_30 / `add_features`), then re-save
        `Data/dt_engineered.rds` (check first that the saved file has the same values and types the function produces),
      - students then read the RDS and filter on `Dataset`, e.g. `dt <- readRDS(...)`, `train <- dt[dt$Dataset == "train", ]`
        (keep one file, no separate train/valid files),
      - update every caller: `Exercises/Lesson6_Ex1_VariableSelection.Rmd` cell_03, `Exercises/Lesson6_Ex2_FinalModel.Rmd`
        cell_03 (file open in the IDE), `Homework/my_homework.R` and `Homework/zadanie/hw_zadanie1-8.R` (the homework text
        mentions load_l6_data),
      - keep `candidate_vars` and `chart_columns` in `Support/selection_helpers.R` (they are not part of the loading; superseded: `candidate_vars` is now hardcoded in Ex1 and the homework, see "L6 homework"),
      - verify the results are unchanged (same train/valid rows, identical coefficients for one model) before and after.
- [x] Forward selection intuition image — generate an illustrative picture (or 2-3 variants to choose from) of the
      forward selection idea: start from the base, try every remaining variable, keep the best, repeat. Use
      `tools/image_generation/`: add a prompts file for Lesson 6 (with a `## Common style` block, as in
      `image_prompts_lesson5.md`), check that the script's proxy variable names are filled in locally (not committed),
      review each output against its prompt (values, arrows, colours). Save the chosen image in `Lesson6_alt/Support/`
      and reference it in Ex1 Method 1.
- [x] Redesign the three helpers so the starting point is passed explicitly (nothing assumes Veh_type2_merged):
      - current state: `forward_select()` and `lasso_entry_order()` take `base` and `start` but default `base` to
        "Veh_type2_merged"; `fit_and_rank()` in Ex1 hard-codes "Veh_type2_merged" and takes only `selected`. The
        mismatch ranking has no `base` argument at all.
      - target: `base` and `start` are explicit arguments of all three methods (no hidden default). Candidates are
        `setdiff(candidate_vars, c(base, start))` inside each method. Move the ranking step (`fit_and_rank` logic) into
        `Support/selection_helpers.R` so the homework uses the same function (e.g. `rank_by_mismatch(train, base, start)`).
      - must work for: (a) base = none, start = none (intercept only: forward selection from scratch, mismatch ranking from
        the intercept model, lasso over all variables); (b) base = Veh_type2_merged, start = none; (c) base = none,
        start = one variable; (d) base = Veh_type2_merged, start = one variable (the homework case, e.g.
        Time_on_book_cap); (e) several start variables.
      - edge cases to check: `reformulate()` with no terms (intercept-only formula), `model.matrix()` and the
        `term_of_column` mapping when there is no base column, lasso with no unpenalised term, the 0.001 penalty for start.
      - empirical test (script, results written down): run every method for cases (a)-(e), check no error, every
        candidate returned once, start variables are in the path from step 0, and that the intercept-only mismatch
        ranking matches a manual calculation for one variable.
- [x] L1 penalty — material for the lasso method in Ex1 (students are not familiar with L1):
      - formula: the glmnet objective is the scaled negative log-likelihood (deviance / 2 over N, with exposure weights)
        plus lambda times the sum of penalty.factor * |beta_j| (base 0, start 0.001, others 1). Verify the exact scaling
        for the Tweedie family in the glmnet docs before writing it down.
      - intuition: the penalty charges for the size of each coefficient; with a strong penalty every coefficient is
        exactly zero, as lambda falls the variable with the largest effect switches on first. `entry_penalty` in the
        output is the lambda at which a variable enters.
      - note: glmnet standardises numeric columns by default (`standardize = TRUE`), so the penalty is on a comparable
        scale; each dummy level is a separate column, so one level can enter alone (already a caveat in Ex1).
      - visuals: a real coefficient-path plot from the fitted glmnet object (`plot(fit, xvar = "lambda")`) shows the entry
        order accurately. Use an AI image (via `tools/image_generation/`) only for the geometric idea (loss contours
        touching the L1 diamond at a corner, L2 circle does not), and check it against the real path.
- [ ] (optional, low priority) Exact lasso scaling check. Only needed if the material states an exact lambda or entry
      penalty formula. The intuition and the entry-order formula in the L1 item above do not need it. Findings so far
      (train split, base Veh_type2_merged, candidates BonusMalus_adj, Time_on_book_cap, Sum_insured_log, Capacity_band):
      - the entry formula's maximum is about 1.375 times glmnet's `lambda[1]`, both with `standardize = FALSE`
        (70.52 vs 51.29) and `standardize = TRUE` (15.84 vs 11.52), so the approximation is off by a constant factor;
      - with `standardize = FALSE`, glmnet's solution is a minimum of the objective in the L1 item (deviance / (2 sum w)
        + lambda * sum p_j |beta_j|), confirmed by a perturbation test;
      - with `standardize = TRUE` the same test failed (glmnet's solution was beaten by a nearby point). This is not yet
        explained (possibly the standardised scaling or convergence), so the objective is not confirmed for that case;
      - the per-candidate entry comparison did not finish (the run timed out with a fine lambda grid).
      If pursued: finish the per-candidate check with a coarser lambda grid, settle the standardised scaling, and check
      against the glmnet docs. If the material keeps only the intuition, drop this item.
- [x] Intercept-only baseline in Ex1 model comparison — add "Intercept only" (`Burning_Cost ~ 1`) as the first row of the
      comparison in cell_15, before "Vehicle type". Keep Veh_type2_merged as the first added variable everywhere in the
      material (Ex1, Ex2, FE, homework base), because the homework starting variable is an extra one on top of it.
- [x] Ex1 backup RDS — save the output of `forward_select()` (cell_05, the only slow step in Ex1) as an `.rds` in
      `Lesson6_alt/Data/` (name TBD, e.g. `fwd_forward_select.rds`), to load if time is short or a student's session crashes. Scope:
      - build it with the same call as cell_05, after the `max_steps` decision, so the file matches the exercise;
      - in Ex1, a `readRDS()` fallback next to cell_05 (e.g. a note "if your session crashed, load this instead");
      - check: the loaded object prints the same as the live `fwd` (same variable order, same deviance values);
      - regenerate it last, otherwise it goes stale if `max_steps` or base/start changes.
      - note: `dplyr`, `statmod` and `glmnet` are not installed in the local R library (`Rscript` 4.6.1), so the
        build step needs them installed first.
- [x] Add `Veh_type2_merged` as a row in the variable tables. It is the base in every model, so it is not a candidate,
      but students should see its treatment in the final feature engineering next to the other 13.
      - Ex1 intro table (`Exercises/Lesson6_Ex1_VariableSelection.Rmd` lines 27-41): add a first row, e.g.
        `Veh_type2_merged` | category | blank, `OTHER`, `TRACTOR` to `CAR` | the base, in every model. Adjust the
        sentence above it ("the other 13 are the candidates") so the table still reads correctly.
      - `Support/feature_engineering.Rmd` decision table (cell_31, `final_forms` / `decision_table`, lines 794-831):
        add a row. `compare_forms()` has no gain to report for the base itself, so either leave `cv_gain_k` as NA /
        "base" or keep the row out of the join. Keep the type and adjustment text identical to the Ex1 row.
      - `Support/feature_engineering.Rmd` "Bottom line per variable" (line 858): the bullet already exists. Check its
        wording matches the new row, and that the rule is stated the same way in `add_features()` (line 701).
      - Keep the rule consistent everywhere: blank, `OTHER` and `TRACTOR` go to `CAR` (cell_07 and `add_features()`).
      - Do not change the base or the model code; this is documentation only.
- [x] Explain the starting variable as a stakeholder requirement, in the Ex1 intro and in the homework text. The concept:
      a stakeholder has asked for a variable to be in the model, so we start from it and the selection methods only decide
      what gets added on top. In Ex1 that variable is `Veh_type2_merged`. In the homework it is a different one for each
      student (their assignment), so `Veh_type2_merged` must not be named as the homework starting variable.
      - Ex1: reword lines 24-25 (`Exercises/Lesson6_Ex1_VariableSelection.Rmd`, "the vehicle type `Veh_type2_merged` is the
        base that is in every model, the other 13 are the candidates") to give the reason, not only the fact. Keep it short.
      - Homework: `Homework/my_homework.R` and `Homework/zadanie/hw_zadanie1-8.R` should present the starting variable as
        the stakeholder's request for that student's assignment (each file names a different one, e.g. `Time_on_book_cap`
        in hw1). Do not describe vehicle type as the homework starting point.
      - Open question for the homework: whether `Veh_type2_merged` stays in every homework model as a base. The current
        homework calls pass only `start` (no `base`), so as written the homework has no base. Decide and state it in the text.
      - Keep the wording consistent with the new `Veh_type2_merged` row (previous todo) and with the "Intercept only" baseline.
      - Documentation only; no change to the base or the model code.
- [x] Remove the `knitr::opts_chunk$set(echo = TRUE)` setup chunk (`cell_01`, `include = FALSE`) from the L6 alt
      exercises. It is not needed: knitr's default for `echo` is already `TRUE` (checked with `Rscript`), and the
      chunk is hidden, so students never see it. Check the same line in `Exercises/Lesson6_Ex2_FinalModel.Rmd` line 20
      and remove it there too. Before deleting, check that no other chunk or text refers to the label `cell_01`.
      Do not remove the `knitr::opts_chunk` lines in the other lessons' files in this todo (out of scope).
- [x] Remove the sentence "Because of the capped target, RMSE values here are not comparable with the ones from Lesson 5."
      from the Data section of `Exercises/Lesson6_Ex1_VariableSelection.Rmd` (lines 77-78). After removing it, check that
      the bullet list above it (target capped, engineered predictors) still reads correctly as the end of the section.
      Documentation only.
- [x] Rewrite the criterion paragraph in the "How do we compare models? Deviance" section of
      `Exercises/Lesson6_Ex1_VariableSelection.Rmd` (lines 91-99). Replace the "for *choosing between close models*"
      reasoning with a plain statement: we tested both criteria (grouped RMSE and deviance) for the forward selection,
      deviance was more stable, so deviance is the primary criterion for the whole variable selection section. Keep the
      grouped RMSE as the final check of the chosen model and as a comparison column, as now.
      - Keep the Lesson 5 reference (grouped RMSE, 5 groups) and the link to the deviance formula below the section.
      - The claim has to match the study item in the "Lesson 6 alt" section (the deviance vs row-level RMSE study,
        "decision pending"). Close that item with the result (which criterion was more stable, over which seeds/folds)
        before this paragraph is published, so the text and the study say the same thing.
      - Documentation only; no change to the code.
- [x] Decide the prediction symbol in the formulas of `Exercises/Lesson6_Ex1_VariableSelection.Rmd` (deviance section,
      line 102 "prediction $\mu$"). Options: keep $\mu$ (the GLM mean, the usual notation for the Tweedie unit deviance),
      or switch to $\hat{y}$ (the usual ML notation). Recommendation to decide on: keep $\mu$ in the Tweedie formula and
      say once that $\mu$ is the model's predicted mean, so the notation matches the distribution; use $\hat{y}$ only if
      the rest of the lesson does. Check every formula in the file (deviance, lasso objective, `$\beta_j$`) and in
      `Support/feature_engineering.Rmd` uses the same choice. Documentation only.
- [x] Move all formulas into `$$ ... $$` display blocks in `Exercises/Lesson6_Ex1_VariableSelection.Rmd` so they render
      as formulas. Currently the unit deviance is a display block, but the total deviance (`D = sum_i w_i d(y_i, mu_i)`,
      line 109), the deviance explained (line 117) and the lasso objective are written inline or as a separate line.
      Put each formula, including the sums, in a single `$$` block. Check that the text around them still reads correctly.
      Also check `Support/feature_engineering.Rmd` and `Exercises/Lesson6_Ex2_FinalModel.Rmd` for the same pattern. Documentation only.
- [x] Justify the deviance criterion in the "How do we compare models? Deviance" section (Ex1, lines 91-99), and record the
      evidence that supports it. Draft reasoning to verify, not yet a finding:
      - RMSE takes the raw gap between actual and predicted, squared, so one large claim (even under the 99.5% cap) can
        dominate the sum; the choice of variable then follows that one claim.
      - The Tweedie unit deviance with power 1.5 is $4(\sqrt{y}-\sqrt{\mu})^2/\sqrt{\mu}$: the gap is taken on the
        square-root scale and weighted by the predicted level, so a large actual value counts less than it does in
        squared error. It is also exposure-weighted, as the model's fit is.
      - Deviance is the loss the GLM is fitted with, so the criterion used to choose variables matches the criterion the
        model optimises. RMSE does not.
      - The intro comment does not need numbers, but it must rest on facts. Before writing it, investigate (in the
        deviance vs row-level RMSE study, "decision pending") why the row-level RMSE choices changed so much:
        - which rows drive the change: is the RMSE swing caused by a few large claims, or by the grouping of rows?
        - does the deviance pick the same variable at each step across seeds or CV folds, and does RMSE not?
        - does the deviance change less across seeds than RMSE for the same training rows, and by how much in
          qualitative terms (e.g. "the same variable in all seeds" versus "a different one in half of them")?
        Record the answers in the study item, then write the comment from those answers.
      - The intro paragraph should state the reason in two or three sentences, in plain language, and point to the study
        item for detail. It should not repeat the full argument. Documentation only.
- [x] Add a "chart ranking" lead-in to `Exercises/Lesson6_Ex1_VariableSelection.Rmd` after the intro paragraph at lines
      215-224 (Method 2), before `rank_by_mismatch()` is called in cell_08. Content, in order:
      1. A quick fit of a model with `Veh_type2_merged` only (the base), as the reference for the charts. This is the
         same model as `base_model` in `Support/feature_engineering.Rmd` cell_08, so say that.
      2. A quick plot of one unfitted variable, the actual vs fitted chart from Lesson 5, using `emb_chart_plotly()`. Use
         a variable other than `BonusMalus_adj` (e.g. `Time_on_book_cap` or `Capacity_band`), so it is not the strongest
         one. Check that the chart renders with the base model's predictions.
      3. A sentence that says: even with well-engineered variables, reviewing every chart at every step is slow, so the
         ranking is there to point you to the charts worth looking at first.
      4. A sentence that says: the model fit is already inside the ranking step, so you do not fit it yourself each time.
      - Naming: the comment at `Support/selection_helpers.R` line 80 and the text at line 221 say `mismatch_rank()`, but the
        function the lesson calls is `rank_by_mismatch()` (selection_helpers.R line 82). `mismatch_rank()` is the lower-level
        function in `Support/mismatch_rank.R` (line 15), called inside `rank_by_mismatch()`. In the lesson, mention only
        `rank_by_mismatch()` for the step students run, and name `mismatch_rank()` once as the function that computes the
        gap. Fix the wording at line 221 and the comment at selection_helpers.R line 80 to match.
      - Also check `Homework/my_homework.R` line 11 (commented-out source of `mismatch_rank.R`) so the homework uses the same
        naming.
      - Documentation and one plot chunk; no change to the helper functions.
- [x] Merge `base` and `start` into one `base` argument in the selection helpers (`Support/selection_helpers.R`), and
      remove `start`. Answer to the question: `base` already accepts a vector. Every use in the helpers is `c(base, ...)` or
      `setdiff(candidates, c(base, start))`, so `base = c("Veh_type2_merged", "BonusMalus_adj")` works today. The two
      arguments differ in only two places:
      - lasso (`lasso_entry_order()`): `base` gets penalty 0, `start` gets 0.001 (selection_helpers.R lines 110, comments at
        98-100). This is the only real behavioural difference.
      - forward selection: the path's first row is labelled `"(start)"` (line 59). This is a label only.
      Proposed rule: all variables in `base` are "in every model" and get the light 0.001 penalty in lasso (instead of 0).
      Veh_type2_merged then gets 0.001 too, which the comment at lines 98-100 already says is practically always in. Check
      that the lasso fit still converges with this for cases with a sparse variable as the homework start (e.g. VEH_brand_grp,
      homework 5, which the comment says can break the fit unpenalised; with 0.001 it should be fine, verify).
      - Steps: (1) change the helpers so `base` is the only argument and lasso uses 0.001 for all base variables; (2) rename
        the path label `"(start)"` to `"(base)"`; (3) update the calls in `Exercises/Lesson6_Ex1_VariableSelection.Rmd` cells
        05, 08, 10, 12, 13 and `Homework/zadanie/hw_zadanie1-8.R` and `Homework/my_homework.R` (they pass `start`), and the
        lesson text that describes "start" (lines 48-50 of the helper header and Ex1 comparison text); (4) re-run the
        empirical test for the helper cases in the "Redesign the three helpers" item, with `base` only.
      - This also answers the open homework question in the stakeholder todo: the stakeholder's variable goes into
        `base` (alongside `Veh_type2_merged` if it stays as a base), so the homework has a base as well.
      - Conflict with a finished item: "Redesign the three helpers so the starting point is passed explicitly" is ticked
        with `base` and `start` as two arguments. This todo changes that design, so re-check that item's cases (a)-(e)
        after the merge.
      - Keep the penalty choice (0.001 vs 0) as a decision to confirm with the user before implementation, because it
        changes the lasso ranking for the base variables.
- [x] Simplify the lasso section of `Exercises/Lesson6_Ex1_VariableSelection.Rmd` (Method 3, roughly lines 281-361).
      - Formulas in `$$ ... $$` blocks: any expression with an operator or more than one symbol goes in its own display
        block, not in prose. That covers the penalised objective, `p_j = 0`, `p_j = 1`, `0.001`, the `|beta_j|` term and
        the `log lambda` axis. Currently these are inline at lines 296-301 and 315-318. A single symbol named in a sentence
        (`$\lambda$`, `$\beta_j$`) can stay inline. Confirm this reading when implementing.
      - Remove the picture: delete the `![L1 and L2 penalty](...img_L1_penalty_geometry.png)` line (line 329) and the
        paragraph "Why exactly zero? The picture shows two coefficients..." (lines 320-327). Then grep the Lesson 6 folder
        and `TODO.md` for `img_L1_penalty_geometry`, and delete `Support/img_L1_penalty_geometry.png` if nothing else uses
        it. The "Lesson 6 alt" L1 penalty item (ticked) asked for an AI image of the geometry; that is superseded by this
        removal, so note it there.
      - Keep the bullet "a coefficient is set to exactly zero, not shrunk gradually" (lines 312-314) only if it still reads
        well without the picture; it is the one-line form of the same point.
      - Simplify the entry-order description (bullets at lines 303-311, sentence at lines 338-339) to: the code loops over
        decreasing penalty values (lambda) and records, at each value, which variables have a non-zero coefficient. The
        order in which they first appear is the entry order. It follows the variables that reduce the GLM loss the most
        as the penalty is relaxed.
      - Soundness check before the wording is final (not yet verified; this is reasoning from how the lasso path works):
        - Sound for the first variable: at the largest lambda where every coefficient is zero, the first coefficient to
          become non-zero is the one whose loss gradient at zero is largest after scaling by its penalty weight. That is
          the variable that reduces the loss most per unit of penalty, which matches "helps decrease the loss most".
        - Less exact for later variables: once earlier variables are in, the next entry is the one that still helps most
          given those already in. The order is a path, not a fixed ranking of each variable's standalone value. The text
          should say "in the order they enter", not "the ranking of variables". (The current bullet at lines 307-309
          already says "the order of entry is a ranking"; soften it.)
        - Caveats to keep: the path is recorded on a finite grid (`nlambda = 60`), so the entry order is discretised; a
          dummy level can enter alone (already at lines 334-336); with `standardize = TRUE` the comparison is on
          standardised columns.
        - Verify with the glmnet documentation (`?glmnet`, `penalty.factor`, `standardize`) and a read-only check of the
          entry order on the training data before the wording says "the most". Do not claim it without this check.
      - Keep the coefficient path plot and its text (lines 346-355). It is a real fit from `glmnet`, not the removed
        picture. Trim its wording to match the simplified description.
      - Keep the practical points (lines 331-336) and the caveat (lines 357-361).
      - Documentation only; no change to `lasso_entry_order()` or any helper.
- [x] Hardcode the variables in the cell_15 model comparison (`Exercises/Lesson6_Ex1_VariableSelection.Rmd`, lines 385-395)
      instead of building formulas with `reformulate()` and indexing into `fwd$added`, `chosen_2`, `step3$ranking` and
      `lasso_order`. The lesson should show the formula students can read, e.g. `Burning_Cost ~ Veh_type2_merged +
      BonusMalus_adj + ...`, and the selections should be reproducible at this point.
      - Steps: (1) run the three selection cells once from a clean session and write down the variables each returns:
        `fwd$added[2:4]`, the first three of the chart ranking (`"BonusMalus_adj"`, `chosen_2`, `step3$ranking$variable[1]`),
        and `lasso_order$variable[1:3]`; (2) write those names directly into the formulas, e.g. `glm_tweedie(Burning_Cost ~
        Veh_type2_merged + VEH_brand_grp + ..., train)`; (3) keep `"Intercept only"` and `"Vehicle type"` as they are.
      - Check that the hardcoded names match the run: the text at lines 401-403 says the chart ranking and lasso picked the
        same three variables and forward selection took the vehicle brand instead of the sum insured. Verify this from the
        run before the text is kept; if the names differ, update the text too.
      - Keep `reformulate()` out of the lesson cells. It may still be used inside the helpers.
      - Caveat for the step 1 run: it depends on the `max_steps` decision and the base/start merge. If those change the
        selections, redo step 1 after those todos, and then hardcode the final names.
      - Documentation/code only in this cell; no change to the helpers.
- [x] Simplify the "Deviance" section of `Exercises/Lesson6_Ex1_VariableSelection.Rmd` (lines 123-155: cell_04, the
      "BonusMalus gets worse on RMSE" paragraph, cell_04b and the deviance-explained paragraph). Two options:
      - Option A: remove cell_04, cell_04b and their prose. Shorter, but the RMSE example is the only in-lesson evidence
        that grouped RMSE is unstable for choosing models, which the justification todo above relies on. If A is
        chosen, that todo needs another source (e.g. the appendix of `Support/feature_engineering.Rmd`, cited with the
        numbers it contains).
      - Option B (proposed): keep one small chunk that calls the `tweedie_deviance()` helper on a few made-up values,
        e.g. actual 0 and 500 against predictions 50 and 500, with exposure 1. It should show that a perfect fit gives 0
        and a bigger gap gives a bigger number, which is what the prose at lines 109-111 says. Then the forward selection
        intro says where the helper lives.
      - For B, the wording must be accurate: `tweedie_deviance()` is defined in `Support/tweedie_deviance.R` (sourced in
        cell_02). `Support/selection_helpers.R` does not define it; it uses it and needs it sourced first (its header,
        line 2). Say "the selection helpers use the same `tweedie_deviance()`", not "included in the selection helpers".
      - Check that the deviance-explained formula (lines 114-121) still has a use after the chunk is removed. If it does
        not, either keep it as a one-line remark or drop it with the chunk.
      - Decision: option B (chosen by the user). It keeps the deviance formula connected to code students run and keeps
        the lesson short. The justification todo above can now cite this section, not the RMSE example.
      - Documentation and one small chunk; no change to the helper or the model code.

Results of the batch above (done with the merged `base`-only helpers):
- Helpers re-tested after the merge: 11 base cases (none; vehicle type; Time_on_book_cap; vehicle type + BonusMalus_adj; each of
  the 8 homework variables), all three methods, 144 checks, no errors or warnings. Forward selection and chart ranking are
  identical to the old design (only the label `(start)` -> `(base)`). The old `start` argument errors now.
- Lasso needed one change beyond the plan: with a base penalty of 0.001, glmnet's automatic lambda grid starts where the base itself
  enters and the path stopped after 15-30 of 60 values (the candidates never entered). The helper now builds the grid itself,
  starting where the first candidate enters (base fitted by a plain GLM and passed as an offset) and going down by a factor of 1000.
  Entry order for the lesson base (vehicle type) is unchanged at the top (BonusMalus_adj, Sum_insured_log, Time_on_book_cap) but
  the later steps shift (the grid is different). A base of Capacity_band made an unpenalised glmnet fit fail ("cannot correct
  step size"), which is why the offset approach is used.
- Deviance vs row-level RMSE study (scope done: forward selection only, 8 random 80/20 splits, first 5 steps, row-level RMSE on
  train; chart ranking and lasso were NOT run with RMSE): the deviance chose BonusMalus_adj, VEH_brand_grp, Time_on_book_cap
  (in the same set, order differed in 1 split) on all 8; the RMSE chose BonusMalus_adj, Sum_insured_log and then a different
  third variable in nearly every split. On the official validation split the 5 largest squared errors are about 43% of the total
  squared error, the 5 largest deviance contributions about 12% of the deviance. The paragraph in Ex1 states exactly this.
  Open: whether this should be extended to the chart-ranking and lasso steps.
- Ex1 backup: `Data/fwd_forward_select.rds` built with the cell_05 call; the cell_15 formulas are now written out.
- `Support/img_L1_penalty_geometry.png` deleted (superseded: the lasso section no longer has the picture).

## L6 Ex2 — FinalModel: reviewed and applied
Scope: `Lessons/Lesson6_alt/Exercises/Lesson6_Ex2_FinalModel.Rmd`. The haiku todos were checked against `Data/dt_engineered.rds`
(base R, hand-built Tweedie 1.5 log-link GLM; dplyr/statmod/glmnet are not installed locally, so the .Rmd was not knitted).
User decisions: drop `Capacity_band`, keep the price check on actual capped losses, no `relativity_table()` helper, log argument
in Ex2 only.
- [x] Final model = Ex1 chart-ranking and lasso set: `Veh_type2_merged + BonusMalus_adj + Time_on_book_cap + Sum_insured_log`
      (1 categorical, 3 numeric). Forward selection took `VEH_brand_grp` instead of `Sum_insured_log`; Ex2 says why we take the sum insured.
      `Capacity_band` was in no Ex1 top 3 (8th in forward selection) and is removed everywhere, with its relevel section, the F-test
      (`drop1`), and the no-op `ordered = FALSE`.
- [x] Simplified: cells 07+08 merged, bar chart and by-vehicle table removed, the BonusMalus band cut sits in the chunk that uses it,
      `plotly` not loaded (not used). Chunks renumbered.
- [x] Rating formula explained: `exp(B * (x_new - x_base))` for a number, `(S_new / S_base)^B` for the log variable (same formula,
      simplified), shown side by side with a check chunk. Added `(exp(B) - 1) * 100 %`, `1.1^B`, and the log-transform argument.
- [x] Fixed claims: "balanced on the total" was wrong for Tweedie 1.5 (model +2.9% on all rows, +1.2% on priced rows); "typical" base
      BonusMalus 10 -> 11 (exposure-weighted median); cap removes 1.24% of the loss (text: about 1.2%); pickup multiplier is 0.85, not 0.73.
- [x] Checked and found fine (haiku doubted them): loss cost 866 -> 13 by BonusMalus band (not a typo); loss ratios 224% -> 4%; overall
      77%; zero-premium rows are 788 rows with 0.25% of the loss, so removing them hides nothing (now printed in the text).
- [x] Added: one-sentence note that the model follows the BonusMalus pattern only roughly (model 1079/515/247/127/68/27 vs actual
      866/531/317/174/55/13 per band); validity notes (no interactions, a tariff needs base level, rounding and bands);
      `adequate_change_pct` described as a gap measure, not a recommendation; the unsupported "likely to leave for a competitor" removed.
- [ ] Not done / open: Ex1 line ~438-444 could point to Ex2 ("Ex2 continues with the chart-ranking/lasso set"); the chart-ranking and
      lasso sets were taken from the Ex1 text, not re-run (selection helpers need glmnet/statmod/dplyr, run once in RStudio Cloud);
      knit Ex2 once in RStudio Cloud to confirm no errors.

## L6 homework: assignment code, setup and template (applied)
- [x] Assignment code from L5 Ex3 (same `set.seed(456)`, Student1..20, `sample(1:8)`) and the homework info block added at the end of
      `Lesson6_Ex1_VariableSelection.Rmd` (cell_16). The names are still placeholders: replace them with the real student list.
- [x] `Homework/my_homework.R`: libraries, `source()` calls, data load and split uncommented; the last 3 lines (`hw_candidates`) removed.
- [x] Candidate list hardcoded as `candidates` (14 variables, vehicle type first) in Ex1 cell_03 and in `my_homework.R`; same name, same
      vector, so the homework calls are the lesson calls. Methods remove the base from the list themselves.
- [x] `Support/selection_helpers.R`: `candidate_vars` and the global `chart_columns` removed. `rank_by_mismatch()` builds the chart
      column mapping from the candidates it gets, with `chart_column_overrides` (`Sum_insured_log`, `D_age_adj`). Results compared
      before/after for 9 cases (rank and lasso for 4 bases, forward selection): identical.
- [x] `hw_zadanie1-8.R` regenerated from the new template. Only `hw_zadanie7.R` (Sum_insured_log) has the extra hint that the
      coefficient is per unit of the log (`2^B` for doubling, `1.1^B` for +10%).
- [x] Tested all 8 start variables end to end (glm, forward selection, chart ranking two rounds, lasso) with the new `my_homework.R`
      setup, and knitted Ex1 with the new chunks: no errors.
- [ ] Open: step 1 hint for the four categorical start variables (reference level) was not added; the template wording was kept.

## Lesson 6 quiz visuals and modelling data stability (new)
- [ ] L6 quiz — generate an illustrative image for each quiz question in L6. The images will probably be shown on
      Slido as the slide background or image while the question is on screen, so keep them illustrative and not
      distracting. Generate them with `tools/image_generation/` (see its README.md) and save the chosen images to the
      L6 Support folder, following the same approach as the Lesson 4 images.
- [ ] L6 quiz — add one dplyr-related question to the Kahoot quiz (`Support/quiz_L6.md`). Keep the same format
      (4 answers, one correct, Slovak text, K/T/U/F key row).
- [ ] L6 quiz Q9 (TRUCK vs CAR, log link) — replace answer B "Priemerná poistná udalosť je o 0,405 dolárov vyššia"
      with "Riziko je o 59,5 % nižšie" as a second confusing answer. It is a plausible distractor: 1 − 0,405 = 0,595,
      so it reads the raw coefficient as a multiplier. Update the K/T/U/F key row to match.
- [ ] L6 quiz Q9 image — generate an image (later, with `tools/image_generation/`) that looks like a raw GLM
      coefficient output (e.g. an R `summary()` / `coef()` table with Estimate column), so it reinforces that the
      number is the raw coefficient on the log scale. It should hint toward exp() without showing it.
      - Categories: use the `Veh_type2_merged` levels from the L6 final dataset (`Data/dt_engineered.rds`), with CAR as
        the baseline in the intercept row and TRUCK showing `0.405` exactly as in the question. Check the level names
        in the RDS before generating.
      - Keep every number in the image aligned with the question text (coefficient 0,405, baseline CAR).
      - Review the output against the prompt (values, labels, layout) before saving it to `Support/quiz_images/`.
- [ ] Investigate the instability of the modelling data in L5 and L6. RMSE and grouped RMSE change a lot between
      runs and small data changes, so model comparisons can be misleading. Scope:
      - measure the variability: repeat the train/valid split over several seeds (and k-fold CV) for the L5 Ex3
        models and the L6 GBM and GLM models, and report the spread of RMSE and grouped RMSE,
      - find the source: which policies or claims drive the variance (large losses, few claims per group, sparse
        levels such as D_ZIP / VEH_brand), and how much of the RMSE comes from the top 1% of policies,
      - check how the data size and structure affect it (number of policies, claims per policy, exposure, number
        of rows per group in the grouped RMSE),
      - propose options to stabilise the data, e.g. a larger or regenerated dataset, a different sample, data
        augmentation, capping or banding (see the "cap the target" item above), grouping rare levels, or a
        fixed-size stratified split, and state the trade-off of each option,
      - list the implications across the lessons (L4 data prep and KPIs, L5 Ex1-Ex3 and homework RMSE references,
        L6 GBM tuning and final fit, the BLOCKING regeneration list) for the preferred option.
      Output: a short written investigation with the numbers, and a proposal to review before any data is changed.

## Class 2027 research — automated homework review on Posit Cloud
- [ ] Research whether we can programmatically interact with the student projects in the Posit Cloud workspace
      (where the homework is done), so we can systematically suggest ratings, write comments, and spot patterns and
      bugs across submissions. Check: what the Posit Cloud API / Posit Cloud Enterprise offers for listing projects,
      reading files and exporting content; whether we have the right permissions in our workspace; and any
      terms or privacy limits on reading student work.
- [ ] Related: write a short skill / rating guide so an automatic AI rater understands the rating criteria for each
      lesson's applicable homework (what a good answer looks like, which errors matter, how to weigh them, and what
      feedback tone to use). Start with L5 homework as the pilot.
- [ ] Class 2027 idea (untested) — compare MAE with RMSE and deviance as a model-selection criterion in Lesson 6. Why: the
      Lesson 6 study (forward selection, 8 random splits) showed row-level RMSE is unstable (a few large claims carry about 43%
      of the squared error on validation), so MAE, which is less dominated by large errors, may be more stable.
      - Caveat to check first: only about 6% of validation rows have a claim (358 of 6085), and MAE is minimised by the median,
        which is 0 for this target. MAE may therefore prefer models that predict near zero and may not rank mean models
        (the GLM predicts the mean) sensibly. It is not the loss the GLM is fitted with, unlike the deviance.
      - Test: repeat the Lesson 6 study with MAE (row-level, exposure-weighted) added: same variable chosen per step across
        seeds, validation-path minimum, and agreement with the deviance. Also try MAE on the grouped (5 groups) averages.
      - Decide whether it is worth mentioning in Ex1 at all; the deviance stays the primary criterion unless MAE clearly
        agrees with it and is simpler to explain.
      - Also extend the study to chart ranking and lasso, which were not run with RMSE in 2026.

## BLOCKING before teaching Lesson 5 — align L5/L6 with corrected Lesson 4 data
Lesson 4 Ex1 now removes claims whose loss date lies outside the policy's period of cover (37 claims,
-2.4% of loss; claim rows 1 967 -> 1 930). dt_pol_w_claims_target.rds in L4/L5/L6 Data is already refreshed,
but the L5/L6 texts and derived RDS files (glm_models, data_gbm, data_part_03, grid_search, oneway_baseline)
still reflect the old data. All "new" values below were recomputed with the L5/L6 code on the new data.
All variable directions are preserved; no conclusion flips.

Regeneration order: L5 Ex3 (saves glm_models.rds) -> copy to Lesson6/Data/glm_models.rds ->
L6 Support/02_data_prep.Rmd (data_gbm.rds) -> L6 01_GBM_Intro_Training -> 02_GBM_Tuning
(grid_search.rds, data_part_03.rds, oneway_baseline.RDS) -> 03_GLM_Improvement_Evaluation -> 04_Final_Model_Fit.

Lesson 5
- [x] L5 Ex1:129-131 (basic_model, Veh_type2 multipliers) — MOTORBIKE 0.540 -> 0.552 ("46% less risky" -> "45% less
      risky"), TRUCK 1.647 -> 1.672 ("64% riskier" -> "67% riskier"). PICKUP 0.973 -> 0.955, intercept 246 -> 241.
- [x] L5 Ex3 model1-model4 (seed 58742, 80/20 split) — valid RMSE old -> new:
      model1 34.5 -> 32.8, model2 76.7 -> 79.0, model3 79.4 -> 71.4, model4 70.5 -> 70.1.
      NOTE: merging Veh_type2 (model2 -> model3) now clearly IMPROVES valid RMSE (before it was slightly worse).
      Text does not comment on the direction, but consider adding a sentence ("merging helped") and check slides.
- [x] L5 Ex3:207-208 — Construct_year is no longer significant at 5% (p 0.045 -> 0.065; multiplier 1.041 -> 1.036
      per year). Text justifies it via A/E chart so still OK; optionally mention it is borderline significant.
      The conclusion after model4 ("not the best variable") is even better supported now.
- [x] L5 Ex3 model1 multipliers (l.~117 "how risky are trucks") — TRUCK 1.32 -> 1.34, MOTORBIKE 0.63 -> 0.65.
- [ ] L5 Ex3 — re-run end to end to regenerate Lesson5/Data/glm_models.rds (and copy to Lesson6/Data/).
- [ ] L5 Homework hw1-hw8 — single-variable directions unchanged (Time_on_book down, D_age weakly up, Capacity up,
      Sum_insured up, BonusMalus down, Nr_of_seats / VEH_brand / D_ZIP noisy as before). homework_hints.md still
      valid. RMSE values change slightly — don't reuse reference RMSE numbers from old data.

Lesson 6
- [ ] L6 04_Final_Model_Fit.Rmd:84-86 — Motorbike 0.91 -> 0.92, Pickup 0.98 -> 0.91, Truck 1.47 -> 1.51.
- [ ] L6 04_Final_Model_Fit.Rmd:91-96 — Sum insured beta 3.64e-5 -> 3.22e-5; text "0.00003" and "1.03" (2000 vs 1000)
      still hold (1.037 -> 1.033).
- [ ] L6 04 BonusMalus multipliers — same decreasing shape, upper classes lower (class 15: 0.30 -> 0.19,
      class 17: 0.03 -> ~0). Check any text quoting specific classes.
- [ ] L6 Support/02_data_prep.Rmd — re-run to regenerate data_gbm.rds. "30 504 observations and 27 variables" and
      "14 observations" dropped: unchanged. 99.5% BC cap 71 933 -> 68 686.
- [ ] L6 Support/02_data_prep.Rmd:242 and Exercises/01_GBM_Intro_Training.Rmd:149 — "just two observations" are
      capped, but the code caps 10 (both old and new data). Pre-existing error — fix text.
- [ ] L6 01/02/03 — after re-running, re-check: GBM variable importance order and the top-3 choice
      (BonusMalus, Sum_insured, Veh_type2) in 03:158-178, best hyperparameters quoted in 02, and model comparison
      conclusions in 03:181+.

## AFTER THE COURSE — rename "Burning Cost" -> "Loss Cost"
Decision: "burning cost" is odd terminology for students (it is a UK/reinsurance term). Use **loss cost** instead and
mention once in Lesson 4 Ex2 that it is usually called *pure premium*, and that we use the synonym "loss cost" so it
is not confused with premium. Do this only after Lessons 5-6 have been taught (it touches saved RDS files).
Steps (in order):
- [ ] 1. Prose only (grep -i "burning" outside renv/): Lesson4 README.md, Support/01_model_motivation.md,
      Support/02_glm_motivation.md (also the "pure premium" wording), Exercises/Lesson4_Ex2_TargetAnalysis*.Rmd
      (student + filled), Lesson5 Ex1/Ex3, Lesson6 Exercises 01-04, Lesson6 Support/01_gbm_motivation.md and
      02_data_prep.Rmd, root README.md, tools/image_generation/image_prompts_lesson5.md, and the three
      Data/data_dictionary.txt (L4/L5/L6 — keep identical). Also check slides and Support/img_*.png for the old name.
- [ ] 2. Column rename `Burning_Cost` -> `Loss_Cost` in code (26 files): the Rmd files above plus
      Lesson5/Support/emb_chart_plotly.R, Lesson6/Support/functions/emb_chart_plotly.R, compare_models.R and
      Lesson5/Homework/zadanie/hw_zadanie1-8.R (and homework_hints.md if it mentions it). Also `BC_avg`/`BC_weighted`
      /`BC_total`/`BC_simple` helper names in Ex2 if you want them consistent (-> `LC_*`).
- [ ] 3. Saved data that contain the column or the old name in a stored formula: Lesson4|5|6/Data/
      dt_pol_w_claims_target.rds, Lesson6/Data/data_gbm.rds, data_part_03.rds, Lesson5|6/Data/glm_models.rds,
      Lesson6/Data/grid_search.rds, oneway_baseline.RDS. Order: rename in L4 Ex2 and re-save the target RDS -> copy
      to L5/L6 -> regenerate with the "Regeneration order" from the BLOCKING section above (L5 Ex3 -> L6
      02_data_prep -> 01 -> 02 -> 03 -> 04). Combine with that open regeneration item so models are refitted once.
- [ ] 4. Final check: case-insensitive grep for "burning" outside renv/ returns nothing; knit all Exercises.

## Rmd chunk labels and folding (tooling notes)
- Every chunk in Lessons/*/Exercises/*.Rmd is labelled `cell_01`, `cell_02`, ... (numbering restarts per file; the
  student and `_filled` versions share numbers). After inserting/removing a chunk re-run `Rscript tools/label_chunks.R`
  from the repo root (it replaces existing labels, keeps chunk options and CRLF/LF line endings).
- Folding pilot: Lesson4_Ex2_TargetAnalysis.Rmd (heading levels normalised, `#### Background...` sub-sections that
  students can fold with the gutter arrow). If it works in RStudio, roll out to the other Rmd files.

## Lesson 6 naming — after most feasible todos (new)
- [ ] Once most of the feasible Lesson 6 alt todos are done, rename the two Lesson 6 versions:
      - `Lessons/Lesson6_alt/` -> Lesson 6 option 1
      - current (prior) `Lessons/Lesson6/` -> Lesson 6 option 2
      - Before renaming, grep the repo (README files, the root README, slides, `TODO.md`, `tools/`, and the
        `/cloud/project/...` paths in the Rmd and R files) for both folder names, and update the references.
      - Check the Lesson 6 folder-name references in the homework and the `Data/` and `Support/` paths.

DONE
- Lesson 5 review: Ex1 rewritten (categorical predictors / banding intuition, CAS monograph), Ex2 images
  (validation methods, grouped RMSE; L2 versions used, L1/L3 kept for comparison), Ex3 lift chart + text fixes; all
  three knit. Still open: regenerate glm_models.rds (needs Ex3 saving step), students versions, slides check.
- In all lessons, update pipe from %>% to |>
- Lesson 1: introduce magrittr %>% first, show comparison with native |>, add pipe history comment
- Lesson 2: update support materials and homework info
- Lesson 3: review pass — fixes, blank exercise versions, content accuracy, fix deprecated group_modify keep arg
- Lesson 4: review pass — join QA (unmatched / out-of-cover claims), incurred vs ultimate, credibility-weighted
  one-way fix, banding, frequency / severity / loss ratio section, GLM motivation (log link, Tweedie, exposure),
  data dictionary fixes, regenerated dt_pol_w_claims_target.rds (L4/L5/L6 copies)
- Lesson 4: claims join fix — claims with loss date outside the period of cover removed in Ex1 (discover -> fix),
  Ex2 exposure story and KPI numbers updated, RDS refreshed in L4/L5/L6 (L5/L6 follow-ups listed as BLOCKING above)
