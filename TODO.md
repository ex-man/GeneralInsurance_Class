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
  - [ ] rebuild the student version Lesson4_Ex1_DataPrep.Rmd (partially blanked) from the new _filled.Rmd

## Lesson 5 — follow-ups from Lesson 4 review
- [ ] L5 Ex3: port the Lift Chart section from the Class 2025 Posit Cloud export
      (Lesson5_Ex3_InsuranceModeling.Rmd l.378-424 in the 2025 version, placed after the model4 RMSE chunk).
      Also add "plotly", "ggplot2" to `libs` (l.17), as in 2025.
      Keep the repo's homework info block, Student1..N names and
      `dt_pol_w_claims[complete.cases(dt_pol_w_claims[all_vars]), ]` - the 2025 version
      `filter(complete.cases(.[all_vars]))` does not work with the native pipe |>.
- [ ] L5 Ex2:31, Ex3:29 — text says "data from Lesson 5", should be "data from Lesson 4".
- [ ] L5 Ex1 / Ex2 / Ex3 — state the units once (e.g. in Ex1 intro): Time_Exposure = fraction of a year in (0, 1],
      Burning_Cost = loss per policy-year, Ult_Loss = Paid + Reserves (incurred, no IBNR). All prepared in Lesson 4 Ex2.
- [ ] L5 Data/data_dictionary.txt — already synced with Lesson 4 (Capacity cm3, Nr_payments, Settlement_date,
      Time_Exposure / Ult_Loss / Burning_Cost definitions). Keep the two files identical going forward.
- [ ] L5 Data/glm_models.rds — optional: regenerate by re-running Ex3 on the refreshed dt_pol_w_claims_target.rds.
      Verified the change has no material effect (coefficients identical to 3 dp; Ex1 MOTORBIKE -46% / TRUCK +64% unchanged).
- [ ] L5 Homework — hw5 (VEH_brand) and hw8 (BonusMalus) predictors are swapped compared to Class 2025.
      Repo version is consistent (high-cardinality HINT sits on the VEH_brand task) — keep it, just be aware
      when comparing with 2025 materials / submissions.

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
- [ ] L5 Ex1:129-131 (basic_model, Veh_type2 multipliers) — MOTORBIKE 0.540 -> 0.552 ("46% less risky" -> "45% less
      risky"), TRUCK 1.647 -> 1.672 ("64% riskier" -> "67% riskier"). PICKUP 0.973 -> 0.955, intercept 246 -> 241.
- [ ] L5 Ex3 model1-model4 (seed 58742, 80/20 split) — valid RMSE old -> new:
      model1 34.5 -> 32.8, model2 76.7 -> 79.0, model3 79.4 -> 71.4, model4 70.5 -> 70.1.
      NOTE: merging Veh_type2 (model2 -> model3) now clearly IMPROVES valid RMSE (before it was slightly worse).
      Text does not comment on the direction, but consider adding a sentence ("merging helped") and check slides.
- [ ] L5 Ex3:207-208 — Construct_year is no longer significant at 5% (p 0.045 -> 0.065; multiplier 1.041 -> 1.036
      per year). Text justifies it via A/E chart so still OK; optionally mention it is borderline significant.
      The conclusion after model4 ("not the best variable") is even better supported now.
- [ ] L5 Ex3 model1 multipliers (l.~117 "how risky are trucks") — TRUCK 1.32 -> 1.34, MOTORBIKE 0.63 -> 0.65.
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

DONE
- In all lessons, update pipe from %>% to |>
- Lesson 1: introduce magrittr %>% first, show comparison with native |>, add pipe history comment
- Lesson 2: update support materials and homework info
- Lesson 3: review pass — fixes, blank exercise versions, content accuracy, fix deprecated group_modify keep arg
- Lesson 4: review pass — join QA (unmatched / out-of-cover claims), incurred vs ultimate, credibility-weighted
  one-way fix, banding, frequency / severity / loss ratio section, GLM motivation (log link, Tweedie, exposure),
  data dictionary fixes, regenerated dt_pol_w_claims_target.rds (L4/L5/L6 copies)
- Lesson 4: claims join fix — claims with loss date outside the period of cover removed in Ex1 (discover -> fix),
  Ex2 exposure story and KPI numbers updated, RDS refreshed in L4/L5/L6 (L5/L6 follow-ups listed as BLOCKING above)
