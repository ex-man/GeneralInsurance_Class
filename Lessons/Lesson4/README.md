# Objective
  To learn how to use past data at the level of individual policies to predict the future, and hence set up a pricing structure that will drive profitability.

  In Lesson 2 we measured performance of whole portfolios, in Lesson 3 we projected losses to their ultimate value. Now we go one level deeper - to individual policies - and prepare the data and the prediction target for the models in Lessons 5 and 6.

# Content
1) [Modeling Motivation](Support/01_model_motivation.md) - why we need a price per policy and what the technical price is
2) [Data Preparation for modeling](Exercises/Lesson4_Ex1_DataPrep.Rmd) - keys and granularity of policy and claims data (with reusable helper functions), left joins, structural and logical quality checks of the join; optional bonus on out-of-cover and unmatched claims
3) [Target analysis](Exercises/Lesson4_Ex2_TargetAnalysis.Rmd) - exposure, burning cost, frequency and severity, loss ratio, one-way analysis
4) [GLM Motivation](Support/02_glm_motivation.md) - why one-way analysis is not enough, distributions, log link and multiplicative tariffs

# Data
- `Data/lesson4_PolicyHistory.csv`, `Data/lesson4_Claims.csv` - input data, described in `Data/data_dictionary.txt`
- `Data/dt_pol_w_claims.rds` - output of Exercise 1 (policies joined with claims)
- `Data/dt_pol_w_claims_target.rds` - output of Exercise 2 (with `Time_Exposure` as a fraction of a year and `Burning_Cost` per year), used in Lessons 5 and 6
