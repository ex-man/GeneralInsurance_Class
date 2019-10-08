# Introduction to loss and expense ratios, underwriting result

## Loss ratio
In the previous lesson we looked at the absolute amounts of expenses and claim costs in our data. That helps us to understand how much were our total expenses that are directly or indirectly linked to our insurance business.
Now the next step is the performance. It is obvious that it can happen that there are two portfolios with different size but with the same amount of losses. Which one performed better? And so here comes the term of loss ratio. Loss ratio is comparison of the volume of claim costs and the volume of net earned premium per specified segment.
In the previously mentioned case, the portfolio that is performing better when compared from the perspective of losses is the one that has lower loss ratio.

## Expense ratio
Just like in the previous case, there are situations we want to know which of two differently sized portfolios performs better in terms of expenses. And again, that’s the place where the expense ratio is introduced. It is a ratio of total expenses and total net earned premium per specific segment.

## Underwriting result
So in terms of different portfolios we are now finally able to compare which portfolio is doing better compared to the others. But this is only a relative number. What will really interest our shareholders, that is the owners of the insurance company, together with the board are **profits**.

Now you can imagine that it is nice to have a portfolio that has loss ratio only 10 % but if its net earned premium is only 10 000 USD, there will be little profit to share between the shareholders.

In the end we will have to return back to see, how our portfolios are doing in total. And that is what we call **underwriting result**. We can calculate this number as total net earned premium less the total losses and expenses.

```
UWR = NEP – sum of losses – sum of expenses
```
Since both loss and expense ratios are calculated as a proportion of some kind of cost to net earned premium, to get to the underwriting result we can also use the ratios that were defined earlier in this section. The equation is following
```
UWR = NEP * (1 – sum of losses/NEP – sum of expenses/NEP) = NEP(1 – LR – ER)
```

This is usually simplified by defining a **combined ratio** which is the proportion of both losses and expenses to the net earned premium. So now we have

```
UWR = NEP * (1 –(Sum of losses + sum of expenses)/NEP) = NEP * (1 – COR)
```

Now we can return to the data we have already explored when we were looking at different portfolios and various KPIs. [So let's go to the exercise.](Support/L3_working_w_data.md)
