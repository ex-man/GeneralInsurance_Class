#' Predicting labels with a Boosting model
#' 
#' Library-agnostic function that generates predictions on a set of input 
#' features with a trained Gradient Boosting model 
#' (XGBoost, LightGBM, CatBoost).
#'
#' @param object A model object.
#'  "xgboost", "lightgbm", "catboost".
#' @param X A data frame of input (modeled) features.
#' @param is_apply_onehot A logical value (TRUE/FALSE) indicating, whether 
#'  nested onehot encoding should be applied on the X at the point of 
#'  prediction. Default value is FALSE. Use `is_apply_onehot = TRUE` only if 
#'  this encoding method was used during model training. If you are predicting 
#'  with a CatBoost model, cat_encoding is not taken into account and a default 
#'  (catboost ordered target) encoder is used.
#'  
#' @return A vector of predicted values of the target variable (labels).
#' 
#' @export

calculate_predictions <- function(
    object,
    X,
    is_apply_onehot = FALSE,
    ...
) {
  
  if (is_apply_onehot) {
    # If the model was trained using one-hot encoded data, 
    # apply one-hot encoding to the dataset
    X <- apply_onehot(
      X,
      ...
    ) %>% as.matrix()
    
  } 
  
  predict(object, X)
}