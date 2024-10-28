enforce_data_types <- function(df, var_types) {
  all_vars <- names(var_types)
  
  for(i in seq_along(var_types)) {
    var_nm <- names(var_types)[[i]]
    var_type <- var_types[[i]]
    conversion_fun <- switch(var_type, category=as.character, number=as.numeric)
    
    df <- df %>% 
      mutate_at(var_nm, conversion_fun)
  }
  
  df
}