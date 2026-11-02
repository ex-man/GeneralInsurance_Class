# Compare a named list of GLMs on the training and validation data.
# Reports the Tweedie deviance (in thousands, lower is better) and the grouped RMSE from Lesson 5.
# `train` and `valid` are passed explicitly so the function does not rely on global objects.
# Needs rmse_group() and tweedie_deviance() sourced first.
compare_models <- function(named_model_list, train, valid, n_groups = 5) {
  result <- lapply(names(named_model_list), function(nm) {
    m <- named_model_list[[nm]]
    pred_train <- predict(m, train, type = "response")
    pred_valid <- predict(m, valid, type = "response")

    data.frame(
      model = nm,
      train_dev = round(tweedie_deviance(train$Burning_Cost, pred_train, train$Time_Exposure) / 1000, 1),
      valid_dev = round(tweedie_deviance(valid$Burning_Cost, pred_valid, valid$Time_Exposure) / 1000, 1),
      train_rmse = round(rmse_group(train$Burning_Cost, pred_train, train$Time_Exposure, n_groups), 1),
      valid_rmse = round(rmse_group(valid$Burning_Cost, pred_valid, valid$Time_Exposure, n_groups), 1)
    )
  })

  do.call(rbind, result)
}
