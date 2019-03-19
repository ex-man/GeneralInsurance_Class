# Objective
  To learn about predicting future based on past data and hence setting up pricing structure that will drive to profitability.
  
# Content
  1. Intro to models
      - [Data Preparation for Modelling](pre_model_data_prep.md)
      - [Target purpose](target_and_one_way.md)
  2. Intro to GLM


## Intro to Models

So far we have looked at how our insurance business is doing based on the data from the past. We were able to check which portfolios performed better compared to others and which portfolios brought us the most profit.

We are now also able to predict in some limited way, what will be the final costs of our claims once they are fully developed.

This is all very useful, however all these analyses can be done only when the financial year is already closed. That's when we know how much our portfolios earned and how much the claim costs were. But what we still don't know is how our portfolios will look in the future.  We don't have any prediction on how much we will earn next year.

Basically it means we don't quite know what price we should charge to make our portfolios profitable. And to make the portfolio profitable, we need to know how much we should charge for a single policy.

Until now we relied on underwriter's (the one who that underwrites an insurance risk) **feeling** about a particular risk. But now we would like to take the expert judgment we gained from our **past experience** and put it into a statistical model which could **help us predict** how policies in our portfolios will perform.

Let's go to data again. Open [`pre_model_data_prep.md`](pre_model_data_prep.md)

## Intro to GLM

In the last exercise we saw that in our data there are some factors that have some trend in terms of our prediction target. That means it is worth checking them when we try to underwrite some new risk.

Although this approach is a good starting point, it is still not good enough in this case. As you could see, there was more than just a single one that had some trend. It would be extremely difficult to keep an eye on all those factors at once and at the same time exclude the effects and correlations between the factors.

As an example we can take a car insurance. Let's say that in a one-way analysis we can see that the horse power is a factor with a strong trend. That makes sense - the stronger your car is, the higher is the risk of having a claim that would be more expensive to pay off. On the other hand, the age can be an important factor as well. In general, the more experienced drivers are more careful and so they are less likely to have a claim.

So what kind of price should we charge an older customer with a sports car? And what difference should we make between a similar customer with a comparable car that lives in less populated area where the risk of an accident is lower?

To solve this issue, we can use some other statistical tools that are available to us.

Currently one of the frequently used statistical methods of modelling in insurance is the use of generalized linear models.

We prefer to use linear models because they are quite understandable in terms of what is going on "under the hood". That also makes it simpler to explain to underwriters why the prices have changed in the given way. Furthermore, it enables actuaries and underwriters understand the story behind the trends that are observed in the data. The relative simplicity of the linear model makes it easier to look out for the critical points where things can go wrong.

Why generalized model?

The standard linear model requires the response variable to have a normal distribution. However, in insurance data this is not the case. The response variables in insurance mostly have Poisson distribution (for discrete variable, e.g model for the no. of claims) and the Gamma distribution (e.g. modeling amount of the losses).

 Let's make a simple model. Open [`basic_glm.md`](basic_glm.md)

 
#### Feedback (3 min)  
Please fill in [survey](https://forms.office.com/Pages/ResponsePage.aspx?id=unI2RwfNcUOirniLTGGEDmMCeqOOjBtIuObM18vXqrtUMFAyOE5UM1FUSlVXSFQ3NzJMWldERktTRC4u) about this lesson to help us to improve the course.

#### Homework (~30 min) [2b / 4b]

1. Use One-way analysis to find out 2 more features like `Veh_type2`, which can be usefull in the GLM model and might have potiantial influence on our target.

2. Create simple GLM model with features you have found in previous exercise. 
Is the model predictive? Are you satisfied with your model? 
Use your knowledge about GLM theory to __evaluate model__, __make a suggestion__ what could be improved and what __would be your next steps__. 
We will focus on your comments rather than code here.

