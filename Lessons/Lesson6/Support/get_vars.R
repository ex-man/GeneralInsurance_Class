get_vars <- function(model) {
  strsplit(as.character(model$formula)[-c(1,2)], " \\+ ")[[1]]  
}