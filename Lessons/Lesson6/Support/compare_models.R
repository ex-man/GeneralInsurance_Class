compare_models <- function(named_model_list) {
  model_nm <- names(named_model_list)
  train_rmse <- numeric(length(named_model_list))
  valid_rmse <- numeric(length(named_model_list))
  for(i in seq_along(named_model_list)) {
    this_model <- named_model_list[[i]]
    train_rmse[[i]] <- rmse_group(train_actual, predict(this_model, train, type="response"), train_weight)
    valid_rmse[[i]] <- rmse_group(valid$Burning_Cost, predict(this_model, valid, type="response"), valid$Time_Exposure)
  }
  data.frame(model_nm = model_nm, train_rmse=train_rmse, valid_rmse=valid_rmse)
}