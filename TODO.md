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
- [ ] (study done, decision pending - see reply) Deviance vs row-level RMSE for the selections — test whether row-level RMSE (no 5-group aggregation) would make the
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
      - keep `candidate_vars` and `chart_columns` in `Support/selection_helpers.R` (they are not part of the loading),
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

## Lesson 6 quiz visuals and modelling data stability (new)
- [ ] L6 quiz — generate an illustrative image for each quiz question in L6. The images will probably be shown on
      Slido as the slide background or image while the question is on screen, so keep them illustrative and not
      distracting. Generate them with `tools/image_generation/` (see its README.md) and save the chosen images to the
      L6 Support folder, following the same approach as the Lesson 4 images.
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
