#### Discounting ####
# Libraries
library(dplyr)
library(ggplot2)
library(ChainLadder)

# data about KPIs
dt_KPI <- read.csv("data/lesson2_KPI.csv")
dt_LatestView <- read.csv("data/lesson3_latestView.csv")
dt_PaidCase <- read.csv("data/lesson3_PaidCase.csv")

########################################
## Exercise 1
#  As we will be working with ChainLadder library, explore it a little bit.
#  To understand what it is doing run the example below (demo from ChainLadder library)

GenIns
plot(GenIns)
plot(GenIns, lattice=TRUE)

# think about some math, that could project the furure for the "unfinished lines" (e.g. liner models?)

# to explore a bit of math, look at the exmaples from help section on "chainladder" function
?chainladder

# the thing that is actually predicting the future is the age-to-age factors.
# Can you find them in the chainladder object?

# now try to predict what happens with the linse using the chain ladder technique (hint: search for predict)

#SOLUTION
#--------
GenIns_d <- predict(chainladder(GenIns))
plot(GenIns_d)
#--------


########################################
## Exercise 2
#  Now let's have a look at a couple of different triangles. The data is provided for 2 different businesses.
#  It also shows 2 different claim types for each. Can you describe how different they are?
#  Hint: Consider the length of tail, volatility, average sizes...
#  Hint2: There are 2 types of data - paid and case. Start using Paid...

#SOLUTION
# understand the data

# create a variable => filter data and covert to triangle. then convert to cummulative to use chainladder

## Take paid data for House business and Small claim size
# Paid_HH_sml <- dt_PaidCase %>% filter(...) 

## Now convert the standard table into a triangle
# %>% as.triangle(...)

## Now start plotting things to see more information
## SOLUTION:


## And get the aging factors and some other stat's out to see more details
# ata(...)

## SOLUTION:


## Now repeat for all types of buiness and sizes of claims. Compare the findings...


## If you are now comforatble with what this does, try doing the same, but using additional information: Case!
## Hint: Sum Paid and Case together to come up with the final claims estimates (the Incurred claims)

## SOLUTION:

#--------

########################################
## Exercise 3
## There are a couple of different types of business in the data from previous lesson. 
## What do you think, how long are the average delays in payments? Set up a table, that will 
## show your assumptions and commit it to your git repository.

########################################
## Exercise 4
# Use the data provided in exercise 2 and try to come up with an estimates of the average duration. 
# How does it work? Well, discounting apart, in what year does the average payment happen? 
# HINT: (Here you definitely use paid claims, and it is enough to calculate weighted average of incremental payment)

##  get the weights of incremental paid triangle => this is what we are intrested in because individual payments matter

## SOLUTION:

## average duration (calculate a weighted sum, where the weight is the number of year/total cummulative paid sum)

## SOLUTION:

# Does the value calculated correspond to your assumed value for the given business in Exercise 2? Comment on the findings in your notes...


########################################
## Exercise 5 
# Now, assume an interest rate of 5%. How will the discounting change this?
# Calculate a factor to be applied to the final incurred claims, to make discout it to present value.

# Let's start simply: What would the average idsocunt factor be? Use the average duration from Exercise 4
## SOLUTION:


# Now let's be more precise and use the appropriate weights and individual discount factors one by one
# Hint: Discount every term of the sum in Exercise 3 by appropriate discount factor (1+i)^(-year)
## SOLUTION:


# Recall what is UWR from Lesson 2. Assume premium and expenses are calculated on day 1.
# Can you calculate a sigle number, that could be used to discount the claims to arrive to Net present value of UWR?

########################################
## Exercise 6
# Now, let’s have a look at it from the other way around. 
# The following dataset includes the same data you were analysing in class 2, but it is all discounted...
NPV_data <- read.csv("data/NPV.csv")

# What is the average duration in all of these cases assuming a discount rate of XXX?

# What is the worst performing portfolio now?

########################################
## Exercise 7
# Imagine there are 100 houses around a river and each is worth 100,000.
# A big flood happens once every 100 and destroys everything.
# A small one every 5 years and destroys 1 house.
# What is the average loss per year (simple premium)? What is the volatility of the losses?

# How much do you think a reasonable premium should be to protect the customers?


########################################
## Exercise 8 - reflect in notes


########################################
## Exercise 9

# Look at the data provided. Identify examples, where 2 portfolios are similar (1 dimension is different), and the CIR is bigger or smaller. Be creative and find any dependencies...

CIR_data <- read.csv("data/lesson3_CIR.csv")

# What is the total value of capital required to run the whole business from lesson 2? How has it changed over the years?

