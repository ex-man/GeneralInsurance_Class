```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

In the previous Lesson you learnt about how to create a very simple design for GLM model to improve an insurance portfolio. The model is truly simple but not usable for real life application. We need to improve it to its best using the best data we have available. So we will try to iterate using many combination of features and their mutations to improve the model.

`But how do we know model is performing well?`

There are several methods on how to assess the model performance, but we will focus on a few of them only.
Using these methods you split your data on __modeling__ and __validation__ part to ensure the model is robust and not overfitted on current data, but prepared to work on future data that we have not seen yet.

### Validation Methods
A few methods on how to split data:

1.  Out of sample Validation (randomly split into two parts, e.g. 80% vs. 20% of data)
2.  Out of time Validation (split into two parts, using a time variable, e.g. Years 2012-2016 vs. Year 2017)
3.  Cross Validation (randomly split into k parts and combinations of k-1 parts define one sample vs. remaining part defining the second sample)

Once you split your data into modeling and validation part you start creating GLM model on modeling part and making prediction on validation part.


```{r}
library(dplyr)
# load data, this are data from Lesson 5 where we prepared Claims with Policies into one dataset
dt_pol_w_claims <- readRDS("./Data/lesson6_dt_pol_w_claims.rds")
```


```{r}
# split the dataset into Modeling and Validation part
set.seed(58742) # to fix randomizer
ind <- sample(2, nrow(dt_pol_w_claims), replace=TRUE, prob=c(0.80, 0.20)) # generate random indicator to split by
dt_pol_w_claims <- mutate(dt_pol_w_claims,
                data_status = ifelse(ind == 1, 
                                     "Training",
                                     ifelse(ind == 2, 
                                            "Validation", 
                                            "Unseen")
                )
)
train <- dt_pol_w_claims %>% filter(data_status == "Training")
val <- dt_pol_w_claims %>% filter(data_status == "Validation")
```

```{r}
nrow(train)
nrow(val)
```

### Validation Metric
When you have predictions, you can compare actual values with prediction and assess how the model performs.

And once again there are couple of __metrics__ to use and their usage depends on the type of the model you are trying to create.

A few metrics to evaluate performance of the regression model:

1.  Mean Squared Error
2.  Mean Absolute Error
3.  Median Absolute Error
4.  R2 Score

Btw, for inspiration here is a nice summary of the [metric functions](http://scikit-learn.org/stable/modules/model_evaluation.html) created in python.

All of those methods and metrics can be implemented very easily in R and we will create a simple methodology to do that. 

For the future I would like to mention package `caret`, which automatizes some of the actions we need to do manualy here.

```{r}
# definition of the MSE metric
mse <- function(prediction, actual){
  return(sum((prediction-actual)^2, na.rm = TRUE)/length(prediction))
}
mse(rnorm(100), rnorm(100))
```
