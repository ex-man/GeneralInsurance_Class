TODO
- Lessons 5-6: code and support material review (see detailed follow-ups from the Lesson 4 review below)
- Lessons 4-6: prepare partial blank versions for students (if applicable)

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

## Optional (decide before class) — year-aware claims join in Lesson 4
Lesson 4 Ex1 currently joins claims on NrPolicy + NrObject only, so 37 claims with a loss date outside the
period of cover are attached to the policy (~2.4% of loss). Ex1 now shows this in the QA section but keeps the
simple join. Joining also on `Year = ClmYr` was tested: all variable directions in L5/L6 models stay the same
and hw1-hw8 interpretations are unchanged. If adopted, update:
- [ ] L4 Ex1 join + text of the QA section, L4 Ex2 "third client" paragraph (policy 3907913 would lose its claim).
- [ ] L5 Ex1:129-131 — MOTORBIKE "46% less" -> "45% less", TRUCK "64%" -> "67%".
- [ ] L6 04_Final_Model_Fit.Rmd:84-86 — Motorbike 0.91 (same), Pickup 0.98 -> 0.91, Truck 1.47 -> 1.51;
      l.95-96 Sum insured beta 0.00003 (still ~3e-5).
- [ ] L5 Ex3 — Construct_year p-value 0.045 -> 0.065 (text relies on the A/E chart, still OK).
- [ ] Regenerate L5 glm_models.rds and L6 data_gbm.rds / glm_models.rds / data_part_03.rds.

DONE
- In all lessons, update pipe from %>% to |>
- Lesson 1: introduce magrittr %>% first, show comparison with native |>, add pipe history comment
- Lesson 2: update support materials and homework info
- Lesson 3: review pass — fixes, blank exercise versions, content accuracy, fix deprecated group_modify keep arg
- Lesson 4: review pass — join QA (unmatched / out-of-cover claims), incurred vs ultimate, credibility-weighted
  one-way fix, banding, frequency / severity / loss ratio section, GLM motivation (log link, Tweedie, exposure),
  data dictionary fixes, regenerated dt_pol_w_claims_target.rds (L4/L5/L6 copies, matches Class 2025 data)
