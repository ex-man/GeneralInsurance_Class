# Discounting  losses

It is very unlikely, that we incur the whole loss on the __very first day__. This allows the insurance company to __invest__ the premium received and earn som interest on it. So one way of thinking about our previous example would be to think about __the future value of money__ collected at the time of the claim. In reality we need to know the answers now, so __discounting the losses__ is more practical then earning interest on expenses.

-------------------------------

Think a bit now (Exercise1)
> There are a couple of different types of business in the data from previous lesson. 
What do you think, how long are the average delays in payments? Set up a table, that will 
show your assumptions and commit it to your git repository. What is driving your thinking? 
Take a note about that in your notes file.

Now let’s try to be more exact. What do we need to calculate this? Of course the interest rates, 
but let’s park that for now and use just [risk free rates](https://en.wikipedia.org/wiki/Risk-free_interest_rate). 

So what is the other most important factor?

Usually we would use a formula like this one: `Loss_y = Loss_x * (1 + interest)^(y-x)`

The durations `(y-x)` is the answer. Most likely some information about the claims history 
and the payments will help us derive it. There are a number of approaches we can take. 
We can start at simple averaging through __mean payment term__ (weighted by amount?) 
to proper [reserving development triangles](https://en.wikipedia.org/wiki/Chain-ladder_method) 
and then applying swap rates.

-------------------------------

## Chain ladder and triangles
Do you know what this is? It is the core of Reserving and in many cases also pricing. On the other hand, it is a very simple
approach to get many answers like:

1) How long does it take to fully pay the claims?
2) How fast are they paid?
3) Is the initial estimate of the future conservative or optimistic?

There are far more questions and answers available, and there are many variations of this method. But for now, let's understand
at least the basics.

--- TO  BE  FINISHED ---

-------------------------------

Let’s do a bit of math (Exerise2)
> Use the __Data__ provided in [`data/lesson2_KPI.csv`](../../../data/lesson2_KPI.csv) and try to come up with 
different estimates of the average duration. If you want to be really sophisticated, consider 
using [R package](https://cran.r-project.org/web/packages/ChainLadder/index.html) to implement a chain ladder methodology.

> Does the value calculated correspond to your assumed value for the given business in Exercise 1?
Comment on the findings in your notes...

> Now, assume an interest rate of 5%. How will the [Net Present Value](https://en.wikipedia.org/wiki/Net_present_value) 
of the Underwriting Result (NPV)UWR change for the portfolio identified in lesson 1?

So we have done some basic math...

--------------------------------

Now, let’s have a look at it from a different perspective. 
The following dataset [`data/claims.csv`](../../../data/claims.csv) => *this data set is to be changed* includes the same data you were analyzing in class 1, 
but it is all discounted...

Let’s analyse it a bit (Exercise3)
> What is the average duration in all of these cases assuming a discount rate of XXX?

> Were your assumptions about this correct? 

> What is the worst performing portfolio now?

--------------------------------

# Latest view of the loss development
--- to be finished ---




To make it even more real, we need to take into account another perspective as well. 
This is the amount of money we need to hold to be able to pay the claims right when they appear. 
In here the claims volatility __kicks in__.

# Capital requirements
_Imagine you are starting insuring against flood._

The floods usually happen once every 100 years and when it happens, it destroys your house significantly. 

You have collected some reasonable premium, that is probably less then the value of the loss you can expect 
(no one would pay the same amount of money that the repair will cost to the insurance company, as they would 
 rather save it in a bank). The next year, the flood comes... and so the insurance company must pay... 
 __But do they have enough money?__ How much money would you expect them to have? (reflect in your notes sections)
 
 ## Risk based capital
 Insurance industry is very regulated. One of the main reason is the situation above. No government wants it's people
 to be unprotected or unpaid if a claim happens. That means, an insurance company must have some extra money on top of
 the expected claim payments to allow for the event to happen at different times then just average occurances (once every
 100 year like in example above).
 
 What is driving the capital requirement? (Exercise4)
 > Think about why a portfolio may need more (or less) capital to be allowed to insure business. Write down your ideas
 into your notes.
 
 Obviously, the bigger the size, the more capital is needed. But this still does not meant something is more or less risky.
 It is much better to weight the requirement by size. For this reason we use 
 
 '''''
 Capital Intensity Ratio(CIR) = Required Capital / Net Earned Premium.
'''''
 
 Use the following data [CIR] to try to come up with some examples that support your ideas from your reflection. (Exercise5)
 > Look at the data provided. Identify examples, where 2 portfolios are similar (1 dimension is different), and the CIR is
 bigger or smaller. Be creative and find any dependencies...
 
 ## Cost of capital
 As in the example above, there is no way for a starting insurance company to collect enough money up front. They are borrowed
 from shareholders or banks. These require interest in excess of risk free rate. You can try to find out a reasonable risk
 margin for insurance companies in google (depending on their rating and risk profile). Let's assume, we need to return additiona
 10% on top of the money that we borrow. Let's also assume we have no free capital now and we have to borrow everything.
 
 How does this additional challenge change the porfitabilty of the buiness? (Exercise6)
 > Using the same data we have discounted and calculated latest view of, try to allow for additional 10% (on top of risk free rate)
 of the capital needed for that portfolio. What is the Economic profit before tax (NPV Latest view UWR net of Capital costs) for each
 portfolio? Which one of them is the most profitable? Is the worst one from previous investigation still the worst?
 