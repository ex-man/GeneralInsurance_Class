```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r, include=FALSE}
library(dplyr)
# load data, this are data from Lesson 5 where we prepared Claims with Policies into one dataset
dt_pol_w_claims <- readRDS("./Data/lesson6_dt_pol_w_claims.rds")
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

mse <- function(prediction, actual){
  return(sum((prediction-actual)^2, na.rm = TRUE)/length(prediction))
}
```

Great! Now we have set up the methodology for checking the performance of the model so we are completely ready to start improving it.

This was the very basic glm model we fit in the last lesson.
```{r}
model1 <- glm(data = dt_pol_w_claims,
              formula = Burning_Cost ~ Veh_type2,
              family = Gamma())
```

We trained it on full dataset, which does not go with our methodology. Let's fit it on __training__ part of data.

```{r}
# fitting model only on training dataset
model1a <- glm(data = train,
              formula = Burning_Cost ~ Veh_type2,
              family = Gamma())
```

```{r}
# lets make prediciton on validation dataset and evaluate model
prediction <- predict(model1a, val, type = "response")
```

```{r}
mse(prediction, val$Burning_Cost)
```

Okay, we know, that by metric we are using to improve model it means decreasing MSE metric. Now we will try different approaches to achieve it.

List of a few feature engineering approaches:

1.  Add a new variable
    - If you bring more information in a model, it is becoming much more accurate as it is able to catch many more various situations
2. Remove some variable
    - Althought adding a new variable brings new information to the model, it brings also the noise. You need to find a balance between this. Model should be robust and not overfitted.
3.  Grouping of Categorical variable
4.  Interaction
5.  [Normalization](https://en.wikipedia.org/wiki/Normalization_(statistics))
6.  Credibility Weighting
7.  Outlier resolution
8.  Capping strategy to keep only trending part of the variable
9.  Transformation of variable (polynomial, log, exp, ...)


#### Add a new variable
```{r}
model2 <- glm(data = train,
              formula = Burning_Cost ~ Veh_type2 + Construct_year,
              family = Gamma())
summary(model2)
```

```{r}
mse(predict(model2, train, type = "response"), train$Burning_Cost)
mse(predict(model2, val, type = "response"), val$Burning_Cost)
```

#### Remove some variable
Let's add some more variables, so you can see how overfitting looks like.

```{r}
model3 <- glm(data = train,
              formula = Burning_Cost ~ Customer_Type +Time_on_book + D_age  + Construct_year + Capacity + Nr_of_seats + BonusMalus + D_ZIP + Nr_payments + Sum_insured,
              family = Gamma())
summary(model3)
```

```{r}
mse(predict(model3, train, type = "response"), train$Burning_Cost)
mse(predict(model3, val, type = "response"), val$Burning_Cost)
```

You can see that the metric for modeling part decreased pretty well, but when we try to bring this new model to new data, meaning for validation dataset, then it is even worse than `model2`, where there are only two variables.

#### Capping Strategy and Trend Exploration
Let's go back to `model2` and see how the trend of our prediction looks like for individual variables.
It is similar type of analysis as One-Way Analysis we performed on previous Lesson. The only thing we add here is the trend for prediciton vs. variable we are trying to explore.


I created a function where you can define model, exploratory variable, target and our current prediction.
```{r}
source("Support/emb_chart.R")
emblem_graph(
  dt.frm = train %>% cbind(data.frame(pred = predict(model2, train, type = "response"))),
  x_var =  "Veh_type2",
  target = "Burning_Cost",
  prediction =  "pred"
  )
```
Very nice fit. However it might be caused by the fact that we have only two variables in the model. Remember, althought you can observe a very nice trend in this type of chart, it might be caused also by other variable, as prediction always contains the trend from all variables included in the model.


Let's look at another variable fitted in the model.
```{r}
emblem_graph(
  dt.frm = train %>% cbind(data.frame(pred = predict(model2, train, type = "response"))),
  x_var =  "Construct_year",
  target = "Burning_Cost",
  prediction =  "pred"
  )
```

There is quite a lot of noise in early `Construction Years` due to the small number of observations. You can see that this is negatively influencing the trend.

To correct this behaviour we can __cap__ variable in its start left, let's say in `Construction Year` 2007 to create bigger bin in term of no. of observations.

```{r}
train <- train %>% 
  mutate(Construct_year = ifelse(Construct_year <= 2007, 2007, Construct_year))
         
model4 <- glm(data = train,
              formula = Burning_Cost ~ Veh_type2 + Construct_year,
              family = Gamma())
summary(model4)
```
```{r}
mse(predict(model4, train, type = "response"), train$Burning_Cost)
mse(predict(model4, val, type = "response"), val$Burning_Cost)
```


Let's check the trend again after we fitted a new model.
```{r}
emblem_graph(
  dt.frm = train %>% cbind(data.frame(pred = predict(model4, train, type = "response"))),
  x_var =  "Construct_year",
  target = "Burning_Cost",
  prediction =  "pred"
  )
```

#### Category Grouping
Have you observed that the variable `Veh_type2` and its categories `CAR` and `PICKUP` have their actual mean similar?

```{r}
train <- train %>% mutate(Veh_type2 = ifelse(as.character(Veh_type2) == 'PICKUP' | as.character(Veh_type2) == 'CAR', 'CAR & PICKUP', as.character(Veh_type2)))
model5 <- glm(data = train,
              formula = Burning_Cost ~ Veh_type2 + Construct_year , 
              family = Gamma())
summary(model5)
```
```{r}
mse(predict(model5, train, type = "response"), train$Burning_Cost)
mse(predict(model5, val %>% mutate(
Veh_type2 = ifelse(
as.character(Veh_type2) == 'PICKUP' | as.character(Veh_type2) == 'CAR',
'CAR & PICKUP',
as.character(Veh_type2)
)
), type = "response"),
val$Burning_Cost)
```
```{r}
emblem_graph(
  dt.frm = train %>% cbind(data.frame(pred = predict(model5, train, type = "response"))),
  x_var =  "Veh_type2",
  target = "Burning_Cost",
  prediction =  "pred"
  )
```
