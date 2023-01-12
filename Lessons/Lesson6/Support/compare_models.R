compare_models <- function(named_model_list) {
  model_nm <- names(named_model_list)
  train_rmse <- numeric(length(named_model_list))
  valid_rmse <- numeric(length(named_model_list))
  for(i in seq_along(named_model_list)) {
    this_model <- named_model_list[[i]]
    train_rmse[[i]] <- rmse(predict(this_model, train, type="response"), train$Burning_Cost)
    valid_rmse[[i]] <- rmse(predict(this_model, valid, type="response"), valid$Burning_Cost)
  }
  data.frame(model_nm = model_nm, train_rmse=train_rmse, valid_rmse=valid_rmse)
}