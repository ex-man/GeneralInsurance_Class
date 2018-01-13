# Discounting  losses

It is very unlikely, that we incur the whole loss on the __very first day__. This allows the insurance company to __invest__ the premium received and earn som interest on it. So one way of thinking about our previous example would be to think about __the future value of money__ collected at the time of the claim. In reality we need to know the answers now, so __discounting the losses__ is more practical then earning interest on expenses.

-------------------------------

Think a bit now (Exercise1)
> There are a couple of different types of business in the data from previous lesson. What do you think, how long are the average delays in payments? Set up a table, that will show your assumptions and commit it to your git repository. What is driving your thinking? Take a note about that in your notes file.

Now let’s try to be more exact. What do we need to calculate this? Of course the interest rates, but let’s park that for now and use just [risk free rates](https://en.wikipedia.org/wiki/Risk-free_interest_rate). 

So what is the other most important factor?

Usually we would use a formula like this one: `Loss_y = Loss_x * (1 + interest)^(y-x)`

The durations `(y-x)` is the answer. Most likely some information about the claims history and the payments will help us derive it. There are a number of approaches we can take. We can start at simple averaging through __mean payment term__ (weighted by amount?) to proper [reserving development triangles](https://en.wikipedia.org/wiki/Chain-ladder_method) and then applying swap rates.

-------------------------------

Let’s do a bit of math (Exerise2)
> Use the __Date__ provided in [`data/lesson2_KPI.csv`](../../../data/lesson2_KPI.csv) and try to come up with diferent estimates of the average duration. If you want to be really sophisticated, consider using [R package](https://cran.r-project.org/web/packages/ChainLadder/index.html) to implement a chain ladder methodology.

> Does the value calculated correspond to your assumed value for the given business in Exercise 1? Comment on the findings in your notes...

> Now, assume an interest rate of 5%. How will the [Net Present Value](https://en.wikipedia.org/wiki/Net_present_value) of the Underwriting Result (NPV)UWR change for the portfolio identified in lesson 1?

So we have done some basic math...

--------------------------------

Now, let’s have a look at it from the other way around. 
The following dataset [`data/claims.csv`](../../../data/claims.csv) includes the same data you were analysing in class 1, but it is all discounted...

Let’s analyse it a bit (Exercise3)
> What is the average duration in all of these cases assuming a discount rate of XXX?

> Were your assumptions about this correct? 

> What is the worst performing portfolio now?

--------------------------------

To make it even more real, we need to take into account another perspective as well. 
This is the amount of money we need to hold to be able to pay the claims right when they appear. In here the claims volatility __kicks in__.

_Imagine you are starting insuring against flood._

The floods usually happen once every 100 years and when it happens, it destroys your house signifficantly. 

You have collected some reasonable premium, that is probably less then the value of the loss you can expect (no one would pay the same amout of money that the repair will cost to the insurance company, as thay would rather save it in a bank). The next year, the flood comes... and so the insurance company must pay... __But do they have enough money?__