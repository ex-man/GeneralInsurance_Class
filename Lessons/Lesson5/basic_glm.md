---
title: "Very basic GLM"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

We created Target and analysed it with One-Way approach. Now, let's see how it performs with a basic glm.

### Distribution of the Target
Before we jump directly to modelling, we need to decide on which type of GLM model we can actually use.
The first step in decision-making could be to draw a distribution of our Target.

```{r}
library(ggplot2)
ggplot(data = dt_pol_w_claims,
                aes(x = Burning_Cost)) +
geom_histogram()
```
It does not look to be very usefull as there is a lot of clients that don't have any claim. Let's remove them, and we can remove outliers as well.

```{r}
library(ggplot2)
ggplot(data = dt_pol_w_claims %>% filter(Burning_Cost != 0, Burning_Cost < 100),
                aes(x = Burning_Cost)) +
geom_histogram()
```

What type of distribution it reminds you of? It looks like `Gamma` or `Tweedie` (if you have never heard about Tweedie distribution, it is a combination of Poisson and Gamma, check wiki for more info). 

To make a proper decision we would run some statistical test on matching distribution, e.g. Kolmogorov-Smirnov test and similar.


So lets try `Gamma` as a first attempt.
### First Model
```{r}
model1 <- glm(data = dt_pol_w_claims %>% filter(Burning_Cost != 0, Burning_Cost < 100),
              formula = Burning_Cost ~ Veh_type2,
              family = Gamma())
```

```{r}
summary(model1)
```

