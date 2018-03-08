# Objective
  To learn about predicting future based on past data and hence setting up pricing structure that will drive to profitability.
  
# Content
  1. Intro to models
      - Data Preparation for Modelling
      - Target purpose
  2. Intro to GLM


## Intro to Models

So far we have looked at how our insurance business is doing based on the data from the past. We were able to check which portfolios performed better compared to others and which portfolios brought us the most profit.

We are now also able to predict in some limited way, what will be the final costs of our claims once they are fully developed.

This is all very useful, however all these analyses can be done only when the financial year is already closed. That's when we know how much our portfolios earned and how much the claim costs were. But what we still don't know is how our portfolios will look in the future.  We don't have any prediction on how much we will earn next year.

Basically it means we don't quite know what price we should charge to make our portfolios profitable. And to make the portfolio profitable, we need to know how much we should charge for a single policy.

Until now we relied on underwriter's (the one who that underwrites an insurance risk) **feeling** about a particular risk. But now we would like to take the expert judgment we gained from our **past experience** and put it into a statistical model which could **help us predict** how policies in our portfolios will perform.

Let's go to data again. Open [`pre_model_data_prep.Rmd`](pre_model_data_prep.Rmd)

## Intro to GLM
urobili sme one way ale to nam nestaci, lebo chceme pouzit viacero faktorov naraz.
priklad: auto je rizikovejsie ked ma silny motor (lebo je drahsie) ale nemusi byt az tak rizikove, ked je to starsi vodic (lebo jazdi opatrnejsie) noa ted si porad!

Preco prave linearny model?
hmmm no lebo je to lahko vyzvetlitelny aj nasim busines partnerom. CCa presne, nie je to black box, vieme co to robi a co sa moze pokazit. je to jednoduchy model ktory ma linearne zavislosti a pre jedno=duchost tejto hodiny sa budeme zaoberat nim.

 preco Generalized LM? lebo target ktory sme si zvolili a chceme predikovat sa podoba gamma rozdeleniu a tento predpoklad musime zahrnut priamo do modelu.
 
 napis formulku s vysvetlenim, co je co (features, target, sum)
 
 