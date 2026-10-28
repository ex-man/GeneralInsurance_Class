<!-- NOTE: this file exists in two places - Lessons/Lesson4/Support/ and Lessons/Lesson5/Support/ (the GLM intro is taught at the end of L4 or at the start of L5, depending on pacing). Keep both copies identical. -->

## GLM Motivation

In the last exercise we saw that in our data there are some factors that have a trend in terms of our prediction target. That means it is worth checking them when we try to underwrite some new risk.

Although this approach is a good starting point, it is still not good enough. As you could see, there was more than just a single factor with a trend. It would be extremely difficult to keep an eye on all those factors at once and at the same time exclude the effects of correlations between the factors.

As an example we can take car insurance. Let's say that in a one-way analysis we can see that horse power is a factor with a strong trend. That makes sense - the stronger your car is, the higher is the risk of having a claim that would be more expensive to pay off. On the other hand, age can be an important factor as well. In general, more experienced drivers are more careful and so they are less likely to have a claim.

So what kind of price should we charge an older customer with a sports car? And what difference should we make for a similar customer with a comparable car who lives in a less populated area where the risk of an accident is lower?

And there is a trap: if young drivers tend to drive powerful cars, the one-way analysis of *age* partly shows the effect of *horse power* too (and vice versa). Adding both one-way effects together would count the same risk twice. We need a method which looks at all the factors **at the same time**.

To solve this issue, we can use some other statistical tools that are available to us. One of the most frequently used methods of modelling in insurance pricing is the **generalized linear model (GLM)**.

### Why linear models?

We prefer linear models because they are quite understandable in terms of what is going on "under the hood". That also makes it simpler to explain to underwriters why the prices have changed in the given way. Furthermore, it enables actuaries and underwriters to understand the story behind the trends that are observed in the data. The relative simplicity of the linear model makes it easier to look out for the critical points where things can go wrong. And last but not least, the result can be easily written down as a **rating table** and implemented in the systems that calculate prices for clients.

### Why GLM instead of linear regression?

The linear model (linear regression) is a good starting point, but insurance data break three of its assumptions:

1. **Constant variance.** Linear regression assumes that policies with the same characteristics have the same spread of residuals. In insurance, policies with higher expected losses also have higher variability: a high-risk policy can produce a very large claim, while a low-risk policy almost never does.
2. **Impossible predictions.** Observed burning costs are zero or positive, and linear regression can handle such values. But its predictions can be negative, which makes no sense for a price. A GLM with a log link turns the linear predictor back into a value with e (exp), which is always positive.
3. **Additive effects.** Linear regression adds effects to the target. Pricing systems work with multipliers: base price times a relativity for each factor. With the log link the coefficients are additive on the log scale, and after exp they become multipliers.

GLMs generalize the linear model in two ways:

1. **Distribution** - the target can follow other distributions than normal:
   - **Poisson** for counts, e.g. number of claims (*frequency* model),
   - **Gamma** for positive amounts, e.g. cost of a claim (*severity* model),
   - **Tweedie** for amounts with many exact zeros, e.g. burning cost (*pure premium* model). It is a compound Poisson-Gamma distribution: a random number of claims, each with a Gamma-distributed size. The power parameter p (between 1 and 2) sets the balance between the two parts; p = 1.5 is a common default.
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

- model the burning cost (loss per year) and use the exposure as a **weight** - policies with longer exposure are more credible. Weights also work in linear regression, but there the variance is constant divided by the weight. In a GLM the weights act together with the variance that depends on the mean. This is what we will do in the next lesson,
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
- CAS Monograph 5: Generalized Linear Models for Insurance Rating (free) - https://www.casact.org/monograph/cas-monograph-no-5

## Appendix: GLM vs linear regression in detail

**Formal definitions**

- Linear regression: Y | X ~ Normal(μ, σ²), with μ = Xβ.
- GLM: Y | X comes from an exponential-family distribution with mean μ, a link g(μ) = Xβ, and variance Var(Y | X) = φ·V(μ) / w, where w is the weight (for example exposure).

An exponential-family density has the form

$$f(y; \theta, \phi) = \exp\left\{ \frac{y\theta - b(\theta)}{a(\phi)} + c(y, \phi) \right\}$$

with E[Y] = μ = b′(θ) and the variance function V(μ) = b″(θ). Examples:

- Normal: V(μ) = 1, φ = σ²
- Poisson: V(μ) = μ, φ = 1
- Gamma: V(μ) = μ²
- Tweedie (1 < p < 2): V(μ) = μ^p

The dispersion φ is a constant scale factor on the variance. It sets how spread out the data are beyond what the mean implies.

**Comparison of components**

| | Linear regression | GLM |
|---|---|---|
| Target distribution | Normal | Exponential family: Normal, Poisson, Gamma, Tweedie, ... |
| Randomness | Additive error: Y = Xβ + ε | The draw from the distribution itself |
| Variance | Constant, σ² | φ·V(μ), varies with the mean |
| Link | Identity | Log (or other) |
| Effect of a variable | Additive | Multiplicative |
| Zero and negative values | Observed zeros allowed; predictions can be negative | Observed zeros allowed; predictions stay positive with log link |
| Weights | Constant variance / weight | Weight enters with the mean-dependent variance |
| Estimation | Least squares, closed form | Maximum likelihood, iterative (IRLS) |
| Dispersion | σ², estimated | φ: fixed at 1 for Poisson; estimated for Gamma and Tweedie |

**Assumptions**

| Assumption | Linear regression | GLM |
|---|---|---|
| Correct mean structure | Yes | Yes, through the link |
| Independent observations | Yes | Yes |
| Distribution | Normal residuals (needed for exact inference) | Chosen family, with the right variance function |
| Variance | Constant residual variance | Follows V(μ); residuals heteroscedastic by design |
| Dispersion | Constant σ² | Constant φ |
| Inference | Exact t and F tests under normality; approximate otherwise | Approximate Wald and likelihood-ratio tests, valid for large samples |

Least squares coefficients stay unbiased if the mean is right, even with heteroscedastic residuals, but the standard errors and tests are then wrong. GLM inference depends on the variance function and dispersion being right, which is why the family choice matters.
