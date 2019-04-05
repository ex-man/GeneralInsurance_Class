< [Back](pre_model_data_prep.md)  [Next]() > [Up](README.md) ^ 

Great, now you wrote about your ideas about the target, lets think about it together.

- _What is the event, object or idea you would like to predict?_

    We definitely want to find out the risk of the specific client and predict it for potential clients.
   
- _Is it measurable?_

    How can we measure risk? Which information identify risky client? 
   
    This is something we need to discuss more and have whole section about it. Example of good indicator for risk can be Ultimate Losses, Ultimate Loss Ratio, Ultimate Frequency and depend pretty much on which kind of risk you are interested in. 
   
     Lets take an example. If you are really interested in risk described in dollar values, you will probably end up using Ultimate Loss as good measurable variable indicating risk of the client.
   
    But, some of the insurance coverages pay only fixed amount of dollars when claims occurs. In such case there is not so much importance on dollar value paid, but much more important thing is how much claims such client had. We usually choose Ultimate Frequency as a good target or combination of Loss amount and Frequency unit.
   
    So the answer here depends pretty much on the definition of the insurance product and it's specific risk you are trying to predict.


So once again...

> What is a good measure of risky client?

Hmm. `Paid` losses might be a good start.

```{r}
dt_pol_w_claims %>% 
  filter(!is.na(Paid)) %>% 
  select(Paid) %>% 
  arrange(desc(Paid)) %>% 
  head()
```

### Exposure
> Is it enough? Can we say, those first three client have similar risk?

Well...it might be not enough. Lets look to the same example, but we will add some more information. 
Specifically, we will show when the policy started and when it was ended.

```{r}
dt_pol_w_claims %>% 
  filter(!is.na(Paid)) %>% 
  select(Paid, Dt_Exp_Start, Dt_Exp_End) %>% 
  arrange(desc(Paid)) %>% 
  head()
```


> What's different on those first three clients?

The third client asked for insurance cover only for three months! And during those three months they have similar loss amount as other clients have during one year. This leads to redefining the risk of the third client to be 4-times(!) riskier than first two clients from the table above.

What we described here is term `exposure`. The exposure can be different for portfolio we are analysing. e.g. it can be square root for property business or mileage for trucks insurance. We often talks about exposure as unit of for insurance cover. There is many definitions. 

So let's create our exposure based on time, client was covered.
```{r}
# tip: there is a great package for date manipulation called lubridate
library(lubridate)
dt_pol_w_claims <- 
  dt_pol_w_claims %>% mutate(Time_Exposure = lubridate::dmy(Dt_Exp_End) - lubridate::dmy(Dt_Exp_Start))

# same example as above with Time Exposure
dt_pol_w_claims %>% 
  filter(!is.na(Paid)) %>% 
  select(Paid, Dt_Exp_Start, Dt_Exp_End, Time_Exposure)  %>% 
  arrange(desc(Paid)) %>% head()
```

Did you realize for some years there is 365 and for some 366 days? Cool, right? `lubridate` does know which year is a leap year.

#### Ultimate Losses and Burning Cost
Ultimate Losses is something we end up paying overall for the individual claim. It can include various parts of the claim e.g. (Losses, Reserver, Inflation, Expenses to arrange the claim, ...).

Burning Cost we call overall cost per some metric of exposure, in our case we are talking about _dollar loss per day insured_.

```{r}
dt_pol_w_claims <- 
  dt_pol_w_claims %>% 
  mutate(Ult_Loss = Paid + Reserves,
         Burning_Cost = ifelse(is.na(Ult_Loss), 0,  Ult_Loss / as.integer(Time_Exposure))
  )

dt_pol_w_claims %>% 
  filter(!is.na(Paid)) %>% 
  select(Paid, Reserves, Ult_Loss, Burning_Cost) %>% head()
```

Let's continue with the questions which help us to identify a good target.

- _Let's say you finished your model, how did the prediction help you to solve your insurance issue?_

    When we will have a good model, which could predict Ultimate Time weighted Loss accuratelly, it will help us to build suitable price we should offer to potential client. The price should ensure it is not too high for less risky client, so we are competitive on the market, but also high enough to cover for potential claims. Btw we might call such a price as _Technical Price_.

- _Are there any potential independent variables, they might have relationship to your target you propose?_

    This is something we can solve using _One-Way Analysis_

## One-Way Analysis
Perfect! It looks like we have found a good target, which might be a good measure for risky clients.

Now, lets finally try to think about the __reasons__ of client being more risky than others.

#### Exercise
Do you have any idea which type of client is definitelly riskier than other? 
Write a few sentences to your notes and commit.


--------------------------------------------------------------------------------

One-Way analysis means we always look for one explanatory variable and one which we try to explain, in our case it's our target we identified. So first of all it make sense to look into them as basic _scatterplot_.

For the first one-way analysis we will try to explore feature about vehicle type of client: `Veh_type2`

```{r}
library(ggplot2)
dt_pol_w_claims %>% 
  ggplot(aes(y = Burning_Cost, x = Veh_type2)) + 
  geom_jitter()
```


Does it helps you to identify any trend? Hmm...looks like outliers screwing it up. Lets go for numbers then.

```{r}
dt_pol_w_claims %>% 
  group_by(Veh_type2) %>% 
  summarise(BC_avg = mean(Burning_Cost, na.rm  = TRUE),
            BC_median = median(Burning_Cost, na.rm = TRUE),
            cnt = n()) %>% 
  arrange(desc(BC_avg))
```

Why we choose those three metrics? And do you see the story behind them?

```{r}
dt_pol_w_claims %>% 
  ggplot(aes(y = Burning_Cost, x = Veh_type2)) + 
  geom_boxplot() +
  ylim(0, 100)
```


Two things happend here:

    - outliers screw it up so much, that this feature is definitelly not good predictor alone, we are not able to explain those outliers using only one feature describing vehicle type.
    - but...there is definitelly some trend, which might be usefull in next stages of modelling. (saying that there is definitelly some trend might be too strong and we should use also other methods to confirm this. e.g. ANOVA)

#### Exercise
Choose another feature and try to find out the story behind data, using similar approach as above.
