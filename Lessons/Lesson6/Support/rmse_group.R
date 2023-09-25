# improved RMSE metric computed on an ordered and grouped data
rmse_group <- function(actual, prediction, weight=NULL, n_groups=5) {
  if(is.null(weight)) {
    weight <- rep(1, length(actual))
  }
  
  if(n_groups>0) {
    # order by increasing prediction
    prediction_order <- order(prediction)
    prediction <- prediction[prediction_order]
    actual <- actual[prediction_order]
    weight <- weight[prediction_order]
    
    # split into 'n_groups'
    prediction_group <- cut(seq_along(prediction), n_groups, labels=FALSE)
    prediction_split <- split(prediction, prediction_group)
    actual_split <- split(actual, prediction_group)
    weight_split <- split(weight, prediction_group)
    
    # compute actual and prediction by group
    prediction <- purrr::map2_dbl(prediction_split, weight_split, weighted.mean)
    actual <- purrr::map2_dbl(actual_split, weight_split, weighted.mean)
  }
  
  se <- (prediction-actual)^2
  mse <- mean(se)
  sqrt(mse)
}