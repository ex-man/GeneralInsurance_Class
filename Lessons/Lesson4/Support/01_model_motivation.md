## Modeling Motivation

So far we have looked at how our insurance business is doing based on the data from the past. In Lesson 2 we checked which portfolios performed better compared to others (loss ratio, combined ratio) and which portfolios brought us the most profit.

In Lesson 3 we learned how to predict, in some limited way, what the final costs of our claims will be once they are fully developed.

This is all very useful, however all these analyses look **backwards** and at the level of **whole portfolios**. They tell us that, for example, the motor portfolio in some region has a combined ratio above 100%, but not **which clients** cause it, nor what we should do about it for next year.

To make a portfolio profitable, we need to charge each client a price that matches **their own risk**. A careful driver with a small car should pay less than a young driver with a powerful sports car. If we charged everybody the same average price, the good risks would leave for a cheaper competitor and we would be left with the bad ones (this is called *adverse selection*).

So the question becomes: **how much should we charge for a single policy?**

The price is built from the expected cost of the policy:

- the **expected loss** of the client for one year of insurance (we will call it *burning cost*),
- plus the **expenses** (commissions, administration, claims handling),
- plus some **profit** margin.

The result is called the **technical price**. The expenses and profit are usually a percentage set by the business. The hard part is the first one: the expected loss of a particular client.

Until now we relied on the underwriter's (the person who evaluates and accepts an insurance risk) **feeling** about a particular risk. But now we would like to take the expert judgment we gained from our **past experience** and put it into a statistical model which could **help us predict** how policies in our portfolios will perform.

In this lesson we will:

1. join policy and claims data to get one row per insured car and year (Exercise 1),
2. define our prediction target - the burning cost - and look for variables that explain it (Exercise 2),
3. see why looking at one variable at a time is not enough and why we need a model (GLM Motivation).
