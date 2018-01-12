#### Discounting ####
# Libraries
library(dplyr)
library(ggplot2)

# data about KPIs
dt_KPI <- read.csv("data/lesson2_KPI.csv")

########################################
## Exercise 1
# There are a couple of different types of business in the data from previous lesson. 

# What do you think, how long are the average delays in payments? Set up a table, 
# that will show your assumptions and commit it to your git repository. 

# What is driving your thinking? Take a note about that in your notes file.








########################################
## Exercise 2
# Use the __Date__ provided in "dt_KPI" and try to come up with diferent estimates of the average duration. 
# If you want to be really sophisticated, consider using  R package - chainladder to implement a chain ladder methodology.
library(ChainLadder)

# Does the value calculated correspond to your assumed value for the given business in Exercise 1? Comment on the findings in your notes...

# Now, assume an interest rate of 5%.
#How will the Net Present Value of the Underwriting Result (NPV)UWR change for the portfolio identified in lesson 1?







########################################
## Exercise 3
# Now, let’s have a look at it from the other way around. 
# The following dataset includes the same data you were analysing in class 1, but it is all discounted...
claims <- read.csv("data/claims.csv")

# What is the average duration in all of these cases assuming a discount rate of XXX?

# Were your assumptions about this correct? 

# What is the worst performing portfolio now?


