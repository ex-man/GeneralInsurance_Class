# Helpers for the variable selection methods in Lesson 6.
# Needs: dplyr, statmod, glmnet and the functions rmse_group(), tweedie_deviance() and mismatch_rank() sourced first.

# The candidate predictors (engineered columns, see Support/feature_engineering.Rmd) and the column
# that is used to draw their "actual vs fitted" chart. A number with many values (the log of the
# sum insured, the age) is drawn by a banded copy, because a chart by value would be just noise.
candidate_vars <- c(
  "BonusMalus_adj", "Time_on_book_cap", "Sum_insured_log", "Capacity_band", "Construct_year_band",
  "Nr_of_seats_grp", "D_age_adj", "VEH_brand_grp", "D_ZIP_1", "Year", "Customer_Type",
  "Veh_type1_grp", "VEH_type_grp"
)

chart_columns <- setNames(candidate_vars, candidate_vars)
chart_columns[["Sum_insured_log"]] <- "Sum_insured_band"
chart_columns[["D_age_adj"]] <- "D_age_chart"

# Burning_Cost ~ the given terms. No terms means the intercept-only model (one price for everybody).
model_formula <- function(terms) {
  reformulate(if (length(terms)) terms else "1", response = "Burning_Cost")
}

glm_tweedie <- function(formula, data) {
  glm(
    formula = formula,
    data = data,
    family = statmod::tweedie(var.power = 1.5, link.power = 0),
    weights = Time_Exposure
  )
}

# Score one model on train and validation data (deviance in thousands, lower is better).
score_model <- function(model, train, valid) {
  data.frame(
    train_dev = tweedie_deviance(train$Burning_Cost, predict(model, train, type = "response"), train$Time_Exposure) / 1000,
    valid_dev = tweedie_deviance(valid$Burning_Cost, predict(model, valid, type = "response"), valid$Time_Exposure) / 1000,
    valid_rmse = rmse_group(valid$Burning_Cost, predict(model, valid, type = "response"), valid$Time_Exposure, 5)
  )
}

# The three methods below share the same arguments:
#   candidates - the variables to choose from (we remove `base` and `start` from them ourselves)
#   base       - variables that are always in the model, e.g. "Veh_type2_merged" (character(0) = none)
#   start      - the variable(s) we start from on top of the base, e.g. the homework variable (character(0) = none)
# Nothing is assumed: with base = character(0) and start = character(0) we begin from the
# intercept-only model.

# Method 1: forward selection.
# We start from the `base` and `start` variables. In every step we try each remaining
# candidate, fit the model on the TRAINING data and keep the candidate that gives the lowest
# training deviance. After each step the model is also scored on the validation data, so we
# can look at the whole path afterwards and decide where to stop.
forward_select <- function(train, valid, candidates, base = character(0), start = character(0),
                           max_steps = length(candidates)) {
  selected <- start
  remaining <- setdiff(candidates, c(base, start))
  path <- list()

  model <- glm_tweedie(model_formula(c(base, selected)), train)
  path[[1]] <- cbind(step = 0, added = "(start)", score_model(model, train, valid))

  for (step in seq_len(min(max_steps, length(remaining)))) {
    train_dev <- sapply(remaining, function(v) {
      m <- glm_tweedie(model_formula(c(base, selected, v)), train)
      tweedie_deviance(train$Burning_Cost, predict(m, train, type = "response"), train$Time_Exposure)
    })

    best <- names(which.min(train_dev))
    selected <- c(selected, best)
    remaining <- setdiff(remaining, best)

    model <- glm_tweedie(model_formula(c(base, selected)), train)
    path[[step + 1]] <- cbind(step = step, added = best, score_model(model, train, valid))
  }

  do.call(rbind, path)
}

# Method 2: ranking the charts.
# Fits the model with the `base` and `start` variables and ranks the remaining candidates by how much
# the model misses on them (see mismatch_rank()). Returns the model, the training data with its
# prediction in the column `pred` (this is what the actual vs fitted charts need) and the ranking.
rank_by_mismatch <- function(train, candidates, base = character(0), start = character(0)) {
  model <- glm_tweedie(model_formula(c(base, start)), train)
  ranked_data <- train
  ranked_data$pred <- predict(model, train, type = "response")

  not_in_model <- setdiff(candidates, c(base, start))
  list(
    model = model,
    data = ranked_data,
    ranking = mismatch_rank(ranked_data, "pred", chart_columns[not_in_model])
  )
}

# Method 3: lasso (L1 penalty).
# The penalty shrinks coefficients towards zero. With a strong penalty all coefficients are zero,
# as we relax it, the variables enter the model one after another - the most useful first.
# The `base` variables are not penalised (always in). A `start` variable (the homework starting
# variable) is penalised only very lightly: it is practically always in, but the fit stays stable
# (a fully unpenalised variable with many sparse levels, e.g. the brand, can break the fitting).
# Returns for every candidate the step of the penalty path at which its first coefficient became
# non-zero (lower = more important). Candidates that never enter get NA and are ranked last.
lasso_entry_order <- function(train, candidates, base = character(0), start = character(0)) {
  candidates <- setdiff(candidates, c(base, start))
  all_terms <- c(base, start, candidates)
  design <- model.matrix(reformulate(all_terms), train)
  term_of_column <- all_terms[attr(design, "assign")[-1]]
  design <- design[, -1, drop = FALSE]

  penalty <- ifelse(term_of_column %in% base, 0, ifelse(term_of_column %in% start, 0.001, 1))

  fit <- glmnet::glmnet(
    x = design,
    y = train$Burning_Cost,
    family = statmod::tweedie(var.power = 1.5, link.power = 0),
    weights = train$Time_Exposure,
    penalty.factor = penalty,
    nlambda = 60
  )

  entry_step <- sapply(candidates, function(v) {
    nonzero_at <- which(colSums(as.matrix(fit$beta[term_of_column == v, , drop = FALSE]) != 0) > 0)
    if (length(nonzero_at)) min(nonzero_at) else NA_integer_
  })

  result <- data.frame(
    variable = candidates,
    entry_step = unname(entry_step),
    entry_penalty = round(fit$lambda[entry_step], 2)
  ) |>
    dplyr::arrange(entry_step) |>
    dplyr::mutate(rank = rank(entry_step, ties.method = "min", na.last = "keep"))

  # the fitted glmnet object, for plotting the coefficient paths: attr(result, "fit")
  attr(result, "fit") <- fit
  result
}

