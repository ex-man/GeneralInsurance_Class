## GLM Motivation

In the last exercise we saw that in our data there are some factors that have a trend in terms of our prediction target. That means it is worth checking them when we try to underwrite some new risk.

Although this approach is a good starting point, it is still not good enough. As you could see, there was more than just a single factor with a trend. It would be extremely difficult to keep an eye on all those factors at once and at the same time exclude the effects of correlations between the factors.

As an example we can take car insurance. Let's say that in a one-way analysis we can see that horse power is a factor with a strong trend. That makes sense - the stronger your car is, the higher is the risk of having a claim that would be more expensive to pay off. On the other hand, age can be an important factor as well. In general, more experienced drivers are more careful and so they are less likely to have a claim.

So what kind of price should we charge an older customer with a sports car? And what difference should we make for a similar customer with a comparable car who lives in a less populated area where the risk of an accident is lower?

And there is a trap: if young drivers tend to drive powerful cars, the one-way analysis of *age* partly shows the effect of *horse power* too (and vice versa). Adding both one-way effects together would count the same risk twice. We need a method which looks at all the factors **at the same time**.

To solve this issue, we can use some other statistical tools that are available to us. One of the most frequently used methods of modelling in insurance pricing is the **generalized linear model (GLM)**.

### Why linear models?

We prefer linear models because they are quite understandable in terms of what is going on "under the hood". That also makes it simpler to explain to underwriters why the prices have changed in the given way. Furthermore, it enables actuaries and underwriters to understand the story behind the trends that are observed in the data. The relative simplicity of the linear model makes it easier to look out for the critical points where things can go wrong. And last but not least, the result can be easily written down as a **rating table** and implemented in the systems that calculate prices for clients.

### Why generalized?

The standard linear model (linear regression) assumes that the target is a sum of the effects of the variables, and that the errors are normally distributed with the same variance everywhere. Insurance data break these assumptions:

- the target cannot be negative,
- most policies have no claim at all (in our data about 94% of the burning costs are zero), while a few have very large ones,
- bigger expected losses usually come with bigger variability.

GLMs generalize the linear model in two ways:

1. **Distribution** - the target can follow other distributions than normal:
   - **Poisson** for counts, e.g. number of claims (*frequency* model),
   - **Gamma** for positive amounts, e.g. cost of a claim (*severity* model),
   - **Tweedie** for amounts with many exact zeros, e.g. burning cost (*pure premium* model) - mathematically it is a Poisson number of Gamma distributed claims.
2. **Link function** - the linear combination of variables is connected to the expected target through a link function. In pricing we almost always use the **log link**:

$$\log(\text{expected Burning Cost}) = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \dots$$

which means that

$$\text{expected Burning Cost} = e^{\beta_0} \cdot e^{\beta_1 x_1} \cdot e^{\beta_2 x_2} \cdots$$

So the effects of variables are **multiplied**, not added. Every variable gives a **multiplier** (relativity) to the base price. For example:

| | multiplier |
|---|---|
| Base price (intercept) | 250 |
| Truck (vs. personal car) | x 1.3 |
| Driver age 18-25 (vs. 40-50) | x 1.5 |
| Bonus-Malus class with no claims | x 0.7 |

A young driver with a truck and a clean history would pay $250 \cdot 1.3 \cdot 1.5 \cdot 0.7 \approx 341$. This is exactly how most motor insurance tariffs look.

### And what about exposure?

A policy insured for half a year should have half of the expected loss of a full year. There are two common ways to tell the GLM about it:

- model the burning cost (loss per year) and use the exposure as a **weight** - policies with longer exposure are more credible. This is what we will do in the next lesson,
- model the loss (or number of claims) directly and use log(exposure) as an **offset** - a variable with the coefficient fixed to 1.

### What's next

In Lesson 5 we will fit a GLM with the Tweedie distribution and log link to the burning cost, with the time exposure as weights:

```r
glm(
  Burning_Cost ~ Veh_type2 + ...,
  family = statmod::tweedie(var.power = 1.5, link.power = 0), # link.power = 0 means log link
  weights = Time_Exposure
)
```

Further reading:

- GLM Short Video - https://youtu.be/ddCO2714W-o?feature=shared
- GLM Short Article - https://towardsdatascience.com/generalized-linear-models-9cbf848bb8ab
- CAS Monograph 5: Generalized Linear Models for Insurance Rating (free) - https://www.casact.org/monograph/cas-monograph-no-5
