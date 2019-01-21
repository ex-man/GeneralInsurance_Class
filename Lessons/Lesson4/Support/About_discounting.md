# Triangles in insurance
Do you know what this is? It is the core of Reserving and in many cases also pricing. This is also how the losses from previous
class were produced. It is a very simple way to get many answers like:

1) How long does it take to fully pay the claims?
2) How fast are they paid?
3) Is the initial estimate of the future conservative or optimistic?

There are far more questions and answers available, and there are many methods that can do the job. But for now, let's understand
at least the basics.

## What is a triangle
As losses take sometimes a number of years to be reported and then some more years to be paid, it is very hard
to say at the end of the year whether we have "saved" enough money. For this reason, it makes sense to keep history
of all claims related to 1 period.

Imagine this simple situation that shows a history of a single policy:
1) 1st December 2016 - insurance contract was signed to protect against car crash injury
2) 20th November 2017 - there was an accident. The person goes to hospital and does not care about calling insurance company
3) 1st January 2018 - person is finally home, but he will not be able to work for unknown time
4) 5th January 2018 - claim is reported. Doctors say, the person may require anoteher surgery in 6 months
5) 1st February 2018 - new symptoms are found (they seem to be coming from the accident) ...
6) a few years later - the person finally starts working, but is partially disabled

Think about which year each information relates to (Exercise0)
> Write down into your notes, what you think... In which year(s) of data can we find the above situation. Then let's discuss.

It make sense to keep a chronological history of how much was paid for each of the items above. If you have many policies and
not just the one as above, it makes sense to group them together and form a chronological payment history for every year.
This is then usually displayed as a "triangle", where the rows represent the years of origin (policy, accident, reporting date)
and the columns represent how long it took until the information was recognized.

## What do we do with this?
Well, we want to take the advantage of the history that we have collected and predict what is likely to happen with the latest
year, that we have just got to know about. It is basically a variation of the Linear Regression, where you learn from past
patterns and apply them to predict future. To get what we are talking about, it is worth visualising this a bit.

Use the ChainLadder package and explore the visaualize the triangle object from example there (Exercise1)
> What would you do to "finish-off" the unfinished lines if you were drawing this on a piece of paper?
> Can you think about some basic maths, that would help you with that?

At the end this is all about age-to-age factors. There are many methods that calculate them, but at the end once you get them
you know, how much more the claim will be in x years.

Now try to calculate them (Exercise2)
> Use the data provided [Claims history data for 2 lines and 2 claim types] and try to understand the differences between then.
> What can you say about line 1 and line 2? (Start by doing some summaries)
> What is the difference between loss type 1 a 2?
> How are the differences reflected in age-to-age factors? (worth visualizing and plugging into chainladder method)

## Short or Long tail
In insurance this means how fast is the data fully developed. The age-to-age factors help you understand exactly this. What would
the age-to-age factors look like to make the business short/long tail? Are the lines of business in the exercise above short or 
long tailed? Try to come up with the meant payment term (weighted average of the duration until the claim is paid) (Exercise3)

So hopefully by this time you know how the losses were calculated for you to use in previous class...
-------------------------------

# Discounting  losses

It is very unlikely, that we incur the whole loss on the __very first day__. This allows the insurance company to __invest__ the premium received and earn som interest on it. So one way of thinking about our previous example would be to think about __the future value of money__ collected at the time of the claim. In reality we need to know the answers now, so __discounting the losses__ is more practical then earning interest on expenses.

-------------------------------

Think a bit now (Exercise3)
> There are a couple of different types of business in the data from previous lesson. 
What do you think, how long are the average delays in payments? Set up a table, that will 
show your assumptions and commit it to your git repository. What is driving your thinking? 
Take a note about that in your notes file.

Let's check the data now (Exercise4). Were your expectations above supported by the calculation?
Add comments to your notes if needed...

Now let’s try to be more exact. What do we need to calculate this? Of course the interest rates, 
but let’s park that for now and use just [risk free rates](https://en.wikipedia.org/wiki/Risk-free_interest_rate). 

So what is the other most important factor?

Usually we would use a formula like this one: `Loss_y = Loss_x * (1 + interest)^(y-x)`

The durations until payments `(y-x)` is a generic answer. Information about the claims history 
and the payments will help us derive it.
We can start at simple averaging (as in the previous exercise) and saying that is the duration discounting for the period equal to aveage duration.
But we can be more precise in weighting and use the age-to-age factors more precisely. So let's try that... (Exercise5) This detailed approach is usually used with the Swap rates for individual durations. You can try that at home...
-------------------------------



Now let's get back to the data we were analysing in lesson 2 (Exercise 6)
> Use the additional data that extend what was provided in lesson2 [`data/lesson3_NPV.csv`](../../../data/lesson3_NPV.csv) and try to come up with different estimates of the average duration for different lines of business. Assume, the interest rates are at 2%.

> Does the value calculated correspond to your assumed value for the given business in Exercise 3?
Comment on the findings in your notes...

> Now, apply the discount factors to the data provided in lesson 2 and update your portfolio performance diagnostics. How will the [Net Present Value](https://en.wikipedia.org/wiki/Net_present_value) of the Underwriting Result (NPV)UWR change for the portfolio identified in lesson 1? Will the worst/best performer still be the same?

--------------------------------

# Capital requirements

To make it even more real, we need to take into account another perspective as well. 
This is the amount of money we need to hold to be able to pay the claims right when they appear. 
In here the __claims volatility__ kicks in.

_Imagine you are starting insuring against flood._

The floods usually happen once every 100 years and when it happens, it destroys your house significantly. 

You have collected some reasonable premium, that is probably less then the value of the loss you can expect 
(no one would pay the same amount of money that the repair will cost to the insurance company, as they would 
 rather save it in a bank). The next year, the flood comes... and so the insurance company must pay... 
 __But do they have enough money?__ How much money would you expect them to have? (reflect in your notes sections) (Exercise 7)
 
 ## Risk based capital
 Insurance industry is very regulated. One of the main reason is the situation above. No government wants it's people
 to be unprotected or unpaid if a claim happens. That means, an insurance company must have some extra money on top of
 the expected claim payments to allow for the event to happen at different times then just average occurances (once every 100 year like in example above).
 
 What is driving the capital requirement? (Exercise8)
 > Think about why a portfolio may need more (or less) capital to be allowed to insure business. Write down your ideas into your notes.
 
 Obviously, the bigger the size, the more capital is needed. But this still does not meant something is more or less risky.
 It is much better to weight the requirement by size. For this reason we use `Capital_Intensity_Ratio(CIR) = Required_Capital / Net_Earned_Premium(NEP)`.
 
 Use the following data [CIR] to try to come up with some examples that support your ideas from your reflection in previous exercise. (Exercise9)
 > Look at the data provided. Identify examples, where 2 portfolios are similar (1 dimension is different), and the CIR is
 bigger or smaller. Be creative and find any dependencies...
 
 ## Cost of capital
 As in the example above, there is no way for a starting insurance company to collect enough money up front. They are borrowed
 from shareholders or banks. These require interest in excess of risk free rate. You can try to find out a reasonable risk
 margin for insurance companies in google (depending on their rating and risk profile). Let's assume, we need to return additiona
 10% on top of the money that we borrow. Let's also assume we have no free capital now and we have to borrow everything.
 
 How does this additional challenge change the porfitabilty of the buiness? (Exercise10)
 > Using the same data we have discounted, try to allow for additional 10% (on top of risk free rate)
 of the capital needed for that portfolio. What is the Economic profit before tax (NPV UWR - Capital costs) for each
 portfolio? Which one of them is the most profitable? Is the worst one from previous investigation still the worst?

--------------------------------
# Latest view of the loss development
Ok, so now you should know something about triangles and discounting and capital and how it all links together. 
There is another use of the triangles though and the very last adjustment to our profitability.
As the external capital is usually quite expensive, insurers need to sometimes strengthen the reserves to have more money
saved for adverse claims (like the flood in the capital section). There are also claims, that have happened and we are not aware of yet,
which is another reason for having extra money saved. Over the years, the reserves are released, as claims are paid 
and the money is not needed. So can we somehow project what the future losses will be after all reserve releases?
There is an additional dataset provided, that shows historical view of the losses for a given year, and it is updated year on year.

# HOMEWORK CANDIDATE
> Use this final triangle to come up with your view on what the ultimate loss for 2016 will look like for every portfolio.
> Calculate the extra money, that will be released in a couple of years.
> Present the latest view NPV UWR for all portfolios and show that as a diagnostic in your dashboard from lesson 2.

 

