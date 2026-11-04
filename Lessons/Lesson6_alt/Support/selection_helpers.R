# Helpers for the variable selection methods in Lesson 6.
# Needs: dplyr, statmod, glmnet and the functions rmse_group(), tweedie_deviance() and mismatch_rank() sourced first.

# The column that draws the "actual vs fitted" chart of a variable: the variable itself, except for these. A number
# with many values (the log of the sum insured, the age) is drawn by a banded copy, because a chart by value
# would be just noise. The candidate list is not defined here: the lesson and the homework pass their own.
chart_column_overrides <- c(Sum_insured_log = "Sum_insured_band", D_age_adj = "D_age_chart")

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
#   candidates - the variables to choose from (we remove `base` from them ourselves)
#   base       - variables that are in the model from the start, e.g. "Veh_type2_merged" (character(0) = none).
#                Several variables are allowed, e.g. c("Veh_type2_merged", "BonusMalus_adj").
# Nothing is assumed: with base = character(0) we begin from the intercept-only model.

# Method 1: forward selection.
# We start from the `base` variables. In every step we try each remaining candidate, fit the
# model on the TRAINING data and keep the candidate that gives the lowest training deviance.
# After each step the model is also scored on the validation data, so we can look at the whole
# path afterwards and decide where to stop.
forward_select <- function(train, valid, candidates, base = character(0), max_steps = length(candidates)) {
  selected <- character(0)
  remaining <- setdiff(candidates, base)
  path <- list()

  model <- glm_tweedie(model_formula(base), train)
  path[[1]] <- cbind(step = 0, added = "(base)", score_model(model, train, valid))

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
# Fits the model with the `base` variables and ranks the remaining candidates by how much the model
# misses on them. rank_by_mismatch() is the step you run; the gap itself is computed by mismatch_rank().
# Returns the model, the training data with its prediction in the column `pred` (this is what the
# actual vs fitted charts need) and the ranking.
rank_by_mismatch <- function(train, candidates, base = character(0)) {
  model <- glm_tweedie(model_formula(base), train)
  ranked_data <- train
  ranked_data$pred <- predict(model, train, type = "response")

  not_in_model <- setdiff(candidates, base)
  chart_columns <- setNames(not_in_model, not_in_model)
  overridden <- intersect(not_in_model, names(chart_column_overrides))
  chart_columns[overridden] <- chart_column_overrides[overridden]

  list(
    model = model,
    data = ranked_data,
    ranking = mismatch_rank(ranked_data, "pred", chart_columns)
  )
}

# Method 3: lasso (L1 penalty).
# The penalty shrinks coefficients towards zero. With a strong penalty all coefficients are zero,
# as we relax it, the variables enter the model one after another - the most useful first.
# The `base` variables are penalised only very lightly (weight 0.001 against 1 for the candidates):
# they are practically always in, but the fit stays stable (a fully unpenalised variable with many
# sparse levels, e.g. the brand, can break the fitting).
# Returns for every candidate the step of the penalty path at which its first coefficient became
# non-zero (lower = more important). Candidates that never enter get NA and are ranked last.
#
# Implementation notes (more exact than the lesson text):
# - The entry order is a path, not a fixed score per variable. The first variable to enter is the one
#   with the largest loss gradient at zero, divided by its penalty weight; later entries are judged
#   given the variables that are already in the model.
# - The path is recorded on a finite grid (60 values), so the order is discretised: variables that
#   enter between two grid values get the same entry_step (ties in `rank`).
# - glmnet standardises the numeric columns (standardize = TRUE), so the comparison is on
#   standardised columns. A category is split into one column per level and a variable counts as
#   entered when its first level does, so a single level can bring it in alone.
# - Not checked: the exact scaling of lambda for the Tweedie family and of the "largest gradient"
#   rule above (an earlier check found a constant-factor gap, see the optional lasso scaling todo in TODO.md).
#   The lesson therefore does not quote exact lambda values.
lasso_entry_order <- function(train, candidates, base = character(0)) {
  candidates <- setdiff(candidates, base)
  all_terms <- c(base, candidates)
  design <- model.matrix(reformulate(all_terms), train)
  term_of_column <- all_terms[attr(design, "assign")[-1]]
  design <- design[, -1, drop = FALSE]

  penalty <- ifelse(term_of_column %in% base, 0.001, 1)

  # glmnet starts its automatic penalty grid where the first variable enters. With a tiny weight on
  # the base that is far above the point where the candidates enter, and the path stops too early.
  # So the grid starts where the first CANDIDATE enters (the base model is fitted by a plain GLM and
  # goes in as an offset) and goes down by a factor of 1000.
  base_model <- glm_tweedie(model_formula(base), train)
  lambda_start <- glmnet::glmnet(
    x = design[, !(term_of_column %in% base), drop = FALSE],
    y = train$Burning_Cost,
    family = statmod::tweedie(var.power = 1.5, link.power = 0),
    weights = train$Time_Exposure,
    offset = predict(base_model, train, type = "link"),
    nlambda = 2
  )$lambda[1]
  lambda_grid <- exp(seq(log(lambda_start), log(lambda_start * 1e-3), length.out = 60))

  fit <- glmnet::glmnet(
    x = design,
    y = train$Burning_Cost,
    family = statmod::tweedie(var.power = 1.5, link.power = 0),
    weights = train$Time_Exposure,
    penalty.factor = penalty,
    lambda = lambda_grid
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

