### Triangles in insurance
Do you know what this is? It is the core of Reserving and in many cases also pricing. This is also how the losses from previous
class were produced. It is a very simple way to get many answers like:

1) How long does it take to fully pay the claims?
2) How fast are they paid?
3) Is the initial estimate of the future losses conservative or optimistic?
4) Once we know the above, how much money can we invest and when? (Because we want to earn interest on premium)

There are far more questions and answers available, and there are many methods that can do the job. But for now, let's understand at least the basics.

### But why should we care?
Insurance company aims to protect customers from risks at *most appropriate* price. This means we cannot waste any resources, and we need to make a machine out of it. We pay claims *just-in-time* (not too early and not too late) and we invest money in financial derivatives with appropriate duration.

On top of this there is also someone else asking us to be fail. It is the *regulator*. Insurance industry is heavily regulated and frequently audited to assure the companies are solvent and ready to pay to customers when needed, rather then to its directors, when premium is collecetsd.

So that is why - customers and regulators. This means it truely is important. So now when we know why, let's look at *how*.

### What is a triangle
As losses take sometimes a number of years to be reported and then some more years to be paid, it is very hard
to say at the end of the year whether we have "saved" enough money. For this reason, it makes sense to keep history of all claims related to 1 period.

Imagine this simple situation that shows a history of a single policy:

1) 1st December 2016 - insurance contract was signed to protect against car crash injury
2) 20th November 2017 - there was an accident. The person goes to hospital and does not care about calling insurance company
3) 1st January 2018 - person is finally home, but he will not be able to work for unknown time
4) 5th January 2018 - claim is reported. Doctors say, the person may require anoteher surgery in 6 months
5) 1st February 2018 - new symptoms are found (they seem to be coming from the accident) ...
6) a few years later - the person finally starts working, but is partially disabled


#### Think about which year each information relates to (Exercise 0)
_Write down into your notes, what you think... In which year(s) of data can we find the above situation. Then let's discuss._

It makes sense to keep a chronological history of how much was paid for each of the items above. If you have many policies and not just the one as above, it makes sense to group them together and form a chronological payment history for every year.
This is then usually displayed as a "triangle", where the rows represent the years of origin (policy, accident, reporting date)
and the columns represent how long it took until the information was recognized.


### What do we do with this?
Well, we want to take the advantage of the history that we have collected and predict what is likely to happen with the latest
year, that we have just got to know about. It is basically a variation of the Linear Regression, where you learn from past
patterns and apply them to predict future. To get what we are talking about, it is worth visualising this a bit. Use the ChainLadder package and explore the visaualize the triangle object from example there.

Load all necessary packages for the lesson 
```{r}
library(dplyr)
library(ggplot2)
library(ChainLadder)
```
Load data about KPIs
```{r}
dt_KPI <- read.csv("./Data/lesson2_KPI.csv")
dt_LatestView <- read.csv("./Data/lesson4_latestView.csv")
dt_PaidCase <- read.csv("./Data/lesson4_PaidCase.csv")
```

#### Exercise 1
_As we will be working with ChainLadder library, explore it a little bit._
To understand what it is doing run the example below (demo from ChainLadder library). But do not just run it! Think about what it is doing!

```{r}
GenIns
plot(GenIns)
plot(GenIns, lattice=TRUE)
```

Before you continue, answer this for yourself:
1) What am I looking at? (What are the axes and the lines?)
2) Why are some lines shorter then others?
3) Why are all lines starting at 0 but ending in different amounts?
4) Which line is the most favourable for the insurer?


_Think about some math, that could project the future for the "unfinished lines" (e.g. liner models?)_
To explore a bit of math, look at the exmaples from help section on "chainladder" function

```{r}
?chainladder
```

The thing that is actually predicting the future is the age-to-age factors.
Can you find them in the chainladder object?

_Now try to predict what happens with the linse using the chain ladder technique (hint: search for predict)_

Your solution
```{r}




```

At the end this is all about age-to-age factors. There are many methods that calculate them, but at the end once you get them you know, how much more the claim will be in x years.


#### Exercise 2
Now let's have a look at a couple of different triangles. The data is provided for 2 different businesses.
It also shows 2 different claim types for each. Can you describe how different they are?
Hint: Consider the length of tail, volatility, average sizes...
Hint2: There are 2 types of data - paid and case. Start using Paid...

_YOUR SOLUTION_
understand the data => run some simple overviews

create a variable => filter data and covert to triangle. then convert to cummulative to use chainladder

_STEP 1: Take paid data for House business and Small claim size_

```{r}
Paid_HH_sml <- dt_PaidCase %>% filter(...) 
```

_STEP 2: Now convert the standard table into a triangle_
Hint: %>% as.triangle(...)

```{r}

```

_STEP 3: Now start plotting things to see more information_

```{r}

```

_STEP 4: And get the aging factors and some other stat's out to see more details_
Hint: ata(...)

```{r}

```

##### HOMEWORK 1
_Now repeat for all types of buiness and sizes of claims. Compare the findings..._

```{r}

```

##### HOMEWORK 2
_If you are now comforatble with what this does, try doing the same, but using additional information: The Case data!_
Hint: Sum Paid and Case together to come up with the final claims estimates (the Incurred claims)

```{r}

```


### Short or Long tail
In insurance this means how fast is the data fully developed. The age-to-age factors help you understand exactly this. What would the age-to-age factors look like to make the business short/long tail? Are the lines of business in the exercise above short or long tailed? Try to come up with the meant payment term (weighted average of the duration until the claim is paid)

So hopefully by this time you know how the losses were calculated for you to use in previous class...


#### Exercise 3
There are a couple of different types of business in the data from previous lesson. 
What do you think, how long are the average delays in payments? Set up a table, that will 
_show your assumptions and save it somewher (either your git repository or your R code)._


### Discounting  losses
It is very unlikely, that we incur the whole loss on the *very first day*. This allows the insurance company to *invest* the premium received and earn som interest on it. So one way of thinking about our previous example would be to think about *the future value of money* collected at the time of the claim. In reality we need to know the answers now, so *discounting the losses* is more practical then earning interest on expenses.

Let's check the data now. Were your expectations above supported by the calculation?
Add comments to your notes if needed...


#### Exercise 4
Use the data provided in exercise 2 and try to come up with an estimates of the average duration. 
How does it work? Well, discounting apart, in what year does the average payment happen? 
HINT: (Here you definitely use *paid* claims, and it is enough to calculate weighted average of incremental payment)

_STEP 1: get the weights of incremental paid triangle => this is what we are intrested in because individual payments matter_

```{r}

```

_STEP 2: average duration (calculate a weighted sum, where the weight is the number of year/total cummulative paid sum)_

```{r}

```

_Does the value calculated correspond to your assumed value for the given business in Exercise 2? Comment on the findings in your notes..._


Now let’s try to be more exact. What do we need to calculate this? Of course the interest rates, 
but let’s park that for now and use just [risk free rates](https://en.wikipedia.org/wiki/Risk-free_interest_rate). 

So what is the other most important factor?

Usually we would use a formula like this one: `Loss_y = Loss_x * (1 + interest)^(y-x)`

The durations until payments `(y-x)` is a generic answer. Information about the claims history 
and the payments will help us derive it.
We can start at simple averaging (as in the previous exercise) and saying that is the duration discounting for the period equal to aveage duration.
But we can be more precise in weighting and use the age-to-age factors more precisely. So let's try that... This detailed approach is usually used with the Swap rates for individual durations. You can try that at home...


#### Exercise 5 
Now, assume an interest rate of 5%. How will the discounting change this?
_Calculate a factor to be applied to the final incurred claims, to make discout it to present value._

Let's start simply: What would the average disocunt factor be? Use the average duration from Exercise 4

```{r}

```

_Now let's be more precise and use the appropriate weights and individual discount factors one by one_
Hint: Discount every term of the sum in Exercise 3 by appropriate discount factor (1+i)^(-year)

```{r}

```

Recall what is UWR from Lesson 2. Assume premium and expenses are calculated on day 1.
_Can you calculate a sigle number, that could be used to discount the claims to arrive to Net present value of UWR?_


#### Exercise 6
Now, let’s have a look at it from the other way around. 
The following dataset includes the same data you were analysing in class 2, but it is all discounted...

```{r}
NPV_data <- read.csv("./Data/lesson4_NPV.csv")
```

_What is the average duration in all of these cases assuming a discount rate of 5%?_

```{r}

```

_What is the worst performing portfolio now?_
(Hint: Create additional shiny graphs, but using the discounted values)
