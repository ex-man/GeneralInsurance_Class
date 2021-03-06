### Capital requirements
To make it even more real, we need to take into account another perspective as well. 
This is the amount of money we need to hold to be able to pay the claims right when they appear. 
In here the *claims volatility* kicks in.

Imagine you are starting insuring against flood.

The floods usually happen once every 100 years and when it happens, it destroys your house significantly. 

You have collected some reasonable premium, that is probably less then the value of the loss you can expect 
(no one would pay the same amount of money that the repair will cost to the insurance company, as they would 
rather save it in a bank). The next year, the flood comes... and so the insurance company must pay... 
*But do they have enough money?* How much money would you expect them to have? (reflect in your notes sections) 
 
 
#### Exercise 7
Imagine there are 100 houses around a river and each is worth 100,000.
A big flood happens once every 100 and destroys everything.
A small one every 5 years and destroys 1 house.
_What is the average loss per year (simple premium)? What is the volatility of the losses?_

```{r}

```

_How much do you think a reasonable premium should be to protect the customers?_


### Risk based capital
Insurance industry is very regulated. One of the main reason is the situation above. No government wants it's people
to be unprotected or unpaid if a claim happens. That means, an insurance company must have some extra money on top of the expected claim payments to allow for the event to happen at different times then just average occurances (once every 100 year like in example above).

What is driving the capital requirement?


#### Exercise 8
_Think about why a portfolio may need more (or less) capital to be allowed to insure business. Write down your ideas into your notes._

Obviously, the bigger the size, the more capital is needed. But this still does not meant something is more or less risky.
It is much better to weight the requirement by size. For this reason we use 
`Capital_Intensity_Ratio(CIR) = Required_Capital / Net_Earned_Premium(NEP)`.


#### Exercise 9
Use the following data [CIR] to try to come up with some examples that support your ideas from your reflection in previous exercise.
_Look at the data provided. Identify examples, where 2 portfolios are similar (1 dimension is different), and the CIR is bigger or smaller. Be creative and find any dependencies..._

```{r}
CIR_data <- read.csv("./Data/lesson4_CIR.csv")
```

What is the total value of capital required to run the whole business from lesson 2?
Use the data provided that refers to the same portfolios, you were looking at in lesson2. 
How has it changed over the years?


### Cost of capital
As in the example above, there is no way for a starting insurance company to collect enough money up front. They are borrowed from shareholders or banks. These require interest in excess of risk free rate. You can try to find out a reasonable risk margin for insurance companies in google (depending on their rating and risk profile). Let's assume, we need to return additiona 10% on top of the money that we borrow. Let's also assume we have no free capital now and we have to borrow everything.
 
How does this additional challenge change the porfitabilty of the buiness?


#### Exercise 10  => USE EVERYTHING YOU LEARNT
_Using the same data we have discounted, try to allow for additional 10% (on top of risk free rate) of the capital needed for that portfolio._
What is the Economic profit before tax (NPV UWR - Capital costs) for each
portfolio? Which one of them is the most profitable? Is the worst one from previous investigation still the worst?

STEPS:
You know what the Mean term is of the data (also part of CIR_data as the last column), as you know what the discount factors are 
and you assumed 5% discount rate (Exercies 6) - chose whichevery you find more reasonable.
You also know what the capital intensity ratios are (Exercise 9).
You also know the Net Earned Premium from earlier lessons (dt_KPI)
How much does it cost to hold the Capital amount in terms of interest paid for that for the average (Mean Term) period?
Now you can combine everything and calculate teh Economic Profit :)
Hint1: Using 'dplyr' package and function left_join requires column names to be the same to join...


### Latest view of the loss development - EXTRA
Ok, so now you should know something about triangles and discounting and capital and how it all links together. 
There is another use of the triangles though and the very last adjustment to our profitability.
As the external capital is usually quite expensive, insurers need to sometimes strengthen the reserves to have more money saved for adverse claims (like the flood in the capital section). There are also claims, that have happened and we are not aware of yet, which is another reason for having extra money saved. Over the years, the reserves are released, as claims are paid and the money is not needed. So can we somehow project what the future losses will be after all reserve releases?
There is an additional dataset provided, that shows historical view of the losses for a given year, and it is updated year on year.


#### BONUS HOMEWORK CANDIDATE - EXTRA BONUS
Use this final triangle to come up with your view on what the ultimate loss for 2016 will look like for every portfolio.
Calculate the extra money, that will be released in a couple of years.
Present the latest view NPV UWR for all portfolios and show that as a diagnostic in your dashboard from lesson 2.
