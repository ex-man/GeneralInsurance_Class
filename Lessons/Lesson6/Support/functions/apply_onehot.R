#' Apply One-Hot Encoding to Selected Columns
#'
#' This function applies one-hot encoding to the specified columns 
#' of a given feature set. The one-hot encoded columns are then combined 
#' with the rest of the dataset.
#'
#' @param feature_set A data frame containing the feature set.
#' @param cols_to_onehot A function or logical vector that specifies 
#'   which columns should be one-hot encoded. 
#'   For example, `is.factor` to select all factor columns.
#'   
#' @return A data frame with the specified columns one-hot encoded and combined 
#'   with the rest of the original columns.
#'   
#' @export

apply_onehot <- function(
    feature_set,
    cols_to_onehot = is.factor
) {

  dummy_model <- dummyVars(
    ~ ., 
    data =  feature_set %>%
      select(where(cols_to_onehot))
  )
  
  factor_onehot <- as.data.frame(
    predict(
      dummy_model, 
      newdata = feature_set %>%
        select(where(cols_to_onehot))
    )
  )
  
  # Get names of columns that are not onehot encoded
  oth_cols <- feature_set %>%
    select(-where(cols_to_onehot)) %>%
    colnames()
  
  # Bind dummy variables with dataset 
  feature_set %>%
    select(all_of(oth_cols)) %>% 
    bind_cols(as.data.frame(factor_onehot))
  
}