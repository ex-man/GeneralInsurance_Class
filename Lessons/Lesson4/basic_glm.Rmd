---
title: "Very basic GLM"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

We created Target and analysed it with One-Way approach. Now, lets have look to how it perfomrs with very basic glm.

### Distribution of the Target
Before we jump directly to modelling, need to decide on which type of GLM model we can actually use.
The first shoot for decision making could be to draw a distribution for our Target.

```{r}
library(ggplot2)
ggplot(data = dt_pol_w_claims,
                aes(x = Burning_Cost)) +
geom_histogram()
```
Not so much of usefull as there is a lot of clients they do not have any claim. Lets remove them and some outliers as well.

```{r}
library(ggplot2)
ggplot(data = dt_pol_w_claims %>% filter(Burning_Cost != 0, Burning_Cost < 100),
                aes(x = Burning_Cost)) +
geom_histogram()
```

What type of distribution it reminds you? It looks like `Gamma` or `Tweedie` (if you have never heard about Tweedie distribution, it is combination of Poisson and Gamma, check wiki for more info). 

To make a proper decision we would rather to run some statistical test on matching distribution, e.g. Kolmogorov-Smirnov test and similar.


So lets try `Gamma` as a first shoot.
### First Model
```{r}
model1 <- glm(data = dt_pol_w_claims %>% filter(Burning_Cost != 0, Burning_Cost < 100),
              formula = Burning_Cost ~ Veh_type2,
              family = Gamma())
```

```{r}
summary(model1)
```

