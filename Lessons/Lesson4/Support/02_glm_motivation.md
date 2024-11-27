## GLM Motivation

In the last exercise we saw that in our data there are some factors that have some trend in terms of our prediction target. That means it is worth checking them when we try to underwrite some new risk.

Although this approach is a good starting point, it is still not good enough in this case. As you could see, there was more than just a single one that had some trend. It would be extremely difficult to keep an eye on all those factors at once and at the same time exclude the effects and correlations between the factors.

As an example we can take a car insurance. Let's say that in a one-way analysis we can see that the horse power is a factor with a strong trend. That makes sense - the stronger your car is, the higher is the risk of having a claim that would be more expensive to pay off. On the other hand, the age can be an important factor as well. In general, the more experienced drivers are more careful and so they are less likely to have a claim.

So what kind of price should we charge an older customer with a sports car? And what difference should we make between a similar customer with a comparable car that lives in less populated area where the risk of an accident is lower?

To solve this issue, we can use some other statistical tools that are available to us.

Currently one of the frequently used statistical methods of modelling in insurance is the use of generalized linear models.

We prefer to use linear models because they are quite understandable in terms of what is going on "under the hood". That also makes it simpler to explain to underwriters why the prices have changed in the given way. Furthermore, it enables actuaries and underwriters understand the story behind the trends that are observed in the data. The relative simplicity of the linear model makes it easier to look out for the critical points where things can go wrong.

Why generalized model?

The standard linear model requires the response variable to have a normal distribution. However, in insurance data this is not the case. The response variables in insurance mostly have Poisson distribution (for discrete variable, e.g model for the no. of claims) and the Gamma distribution (e.g. modeling amount of the losses).

GLM Short Video - https://youtu.be/ddCO2714W-o?feature=shared
GLM Short Article - https://towardsdatascience.com/generalized-linear-models-9cbf848bb8ab