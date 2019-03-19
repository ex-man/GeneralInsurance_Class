# Policy and Claims data exploration
As mentioned in previous lessons, we identified good and bad performers in term of portfolios. To identify, which group of people/companies are guilty for that performance we need **more granular data**. And so we received *Claims* and *Policy* data from out IT department.

Let's look at them.

#### Exercise 1
Please make a few data checks (fields info, some summary stats, quality checks about missings, ...) as you learned in previous lessons.

You can follow up auxiliary questions in `loss_analysis.R` at Exercise 1.

Write a few sentences about what have you found and commit your notes.



### Join Claims with Policy info
It is obvious we need to join both dataset together as __claims data__ contains info about __how much__ is the individual client risky. __Policy data__ contains info about individual's feature and other identifiers, which might help us to find reasons for __why__ client __is riskier__.

So let's find out the way how to join them together.

Policy data are at *policy + object* level.
```{r}
library(dplyr)
dt_Policy <- read.csv("./Data/lesson5_PolicyHistory.csv") %>% distinct(NrPolicy, NrObject, .keep_all = TRUE) 
dt_Policy %>% nrow()
dt_Policy %>% distinct(NrPolicy, NrObject) %>% nrow() 
```

Claims data are at *claims* level. 
```{r}
dt_Claims <- read.csv("./Data/lesson5_Claims.csv") %>% distinct(NrClaim, .keep_all = TRUE)
dt_Claims %>% nrow()
dt_Claims %>% distinct(NrClaim) %>% nrow()
```

To properly bring the claims info on `policy + object` level we need to ensure claims data are also on that level. Lets check it and if they are not, roll them up to that level. 

```{r}
dt_Claims %>% distinct(NrPolicy, NrObject) %>% nrow()
## they are on required level as no. of unique rows at level equals to no. of rows for raw dataset, 
## if they wouldn't this is how you would roll it up
# dt_Claims %>% 
#   mutate(clm_yr = lubridate::year(Date_of_loss)) %>% 
#   group_by(NrPolicy, NrObject, clm_yr) %>% 
#   summarise_at(vars(Paid, Reserves), funs(sum), na.rm = TRUE)
```

Cool! Lets finally join them together.
```{r}
dt_pol_w_claims <- left_join(dt_Policy, 
                             dt_Claims, 
                             by = c("NrPolicy", "NrObject")
                    )
head(dt_pol_w_claims)
```

Perfect! So what's now? Hmm...

Let's look how succesfull we have been to find out about our client losses.

### Quality Assurance of Join
```{r}
# how much claims we joined?
dt_pol_w_claims %>% group_by(is.na(Paid)) %>% summarise(cnt = n())
```

Does it look good or bad? Two questions should arise in your head:

  - Is there any better way to join those information together? Am I missing anything? Does the IT provide good data pull?
  - Lets suppose everything looks good in your Join. Does it make sense to you to have such amount of claims for portfolio you analysing? If you are not sure, you should ask your business or claims department.

# Looking for good Target

#### ...and what is the Target?
Target is a __dependent__ variable in a model, you designed for the purpose of being helpful in predicting the insurance event. Good design of the model can answer questions about relationship between any __independent__ variable and target. When we spoke about _variable_ it can be anything which is __measurable__ (event, object, facts, idea, ...).

Questions, which might help you identify good target and design good model:

- What is the event, object or idea you would like to predict?
- Is it measurable?
- Let's say you finished your model, how did the prediction help you to solve your insurance issue?
- Are there any potential independent variables, they might have relationship to your target you propose?

> Now the crucial questions: What are you gonna model and what data will you need for that purpose?



Write a few sentences about what do you think and commit your notes.



#### Exercise 2
Go to Exercise 2 and try to think about what could be a good 'target'/ event you are trying to predict from data you have.



[Next](target_and_one_way.md) > [Up](README.md) ^
