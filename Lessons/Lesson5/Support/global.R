source('Binning.R')
source('EMB_Graph.R')

caf_analyse <- read.csv("../../../data/policy_history.csv")
classvars <- colnames(caf_analyse[sapply(caf_analyse, function(x){is.character(x) || is.factor(x)})])
contivars <- colnames(caf_analyse[sapply(caf_analyse, function(x){is.integer(x) || is.numeric(x)})])
predictors <- colnames(caf_analyse)
target <- 'Premium_earned'
modelweight <- 'Sum_insured'
pred_value <- 'Premium_earned'