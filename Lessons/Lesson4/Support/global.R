source('Binning.R')
source('EMB_Graph.R')

caf_analyse <- diamonds
classvars <- colnames(caf_analyse[sapply(caf_analyse, function(x){is.character(x) || is.factor(x)})])
contivars <- colnames(caf_analyse[sapply(caf_analyse, function(x){is.integer(x) || is.numeric(x)})])
predictors <- colnames(caf_analyse)
target <- 'table'
modelweight <- 'carat'
pred_value <- 'depth'