# Compare a named list of GLMs by the grouped RMSE on the training and validation data.
# `train` and `valid` are passed explicitly so the function does not rely on global objects.
compare_models <- function(named_model_list, train, valid, n_groups = 5) {
  model_nm <- names(named_model_list)
  train_rmse <- numeric(length(named_model_list))
  valid_rmse <- numeric(length(named_model_list))

  for (i in seq_along(named_model_list)) {
    this_model <- named_model_list[[i]]
    train_rmse[[i]] <- rmse_group(
      train$Burning_Cost,
      predict(this_model, train, type = "response"),
      train$Time_Exposure,
      n_groups
    )
    valid_rmse[[i]] <- rmse_group(
      valid$Burning_Cost,
      predict(this_model, valid, type = "response"),
      valid$Time_Exposure,
      n_groups
    )
  }

  data.frame(
    model = model_nm,
    train_rmse = round(train_rmse, 1),
    valid_rmse = round(valid_rmse, 1)
  )
}
