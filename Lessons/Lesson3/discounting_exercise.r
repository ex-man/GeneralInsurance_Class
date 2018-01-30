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

# now try to predict what happens with the linse using the chain ladder technique (hint: search for predict)

#SOLUTION
#--------
GenIns_d <- predict(chainladder(GenIns))
plot(GenIns_d)
#--------


########################################
## Exercise 2
#  Now let's have a look at a couple of different triangles. The data is provided for 2 different businesses.
#  It also shows 3 different claim types for each. Can you describe how different they are?
#  Hint: Consider the length of tail, volatility, average sizes...

#SOLUTION
#--------
# understand the data
summary(dt_PaidCase)
# create a variable => filter data and covert to triangle. then convert to cummulative to use chainladder
Case_06_att <- dt_PaidCase %>% 
                filter(level_2 == "N06K1" & level_5 == "ATT" & dataset_type == "CASE") %>% 
                select(ay:Expr1) %>% as.triangle(origin="ay", dev="dev", value="Expr1") %>% incr2cum(na.rm = TRUE)

### DATA TO BE SORTED OUT FIRST (remove NAs)
### --------------------------

plot(Case_06_att)
plot(predict(chainladder(Case_06_att)))


#--------





########################################
## Exercise 3
# Use the __Date__ provided in "dt_KPI" and try to come up with diferent estimates of the average duration. 
# If you want to be really sophisticated, consider using  R package - chainladder to implement a chain ladder methodology.

# Does the value calculated correspond to your assumed value for the given business in Exercise 1? Comment on the findings in your notes...

# Now, assume an interest rate of 5%.
#How will the Net Present Value of the Underwriting Result (NPV)UWR change for the portfolio identified in lesson 1?







########################################
## Exercise 4
# Now, let’s have a look at it from the other way around. 
# The following dataset includes the same data you were analysing in class 1, but it is all discounted...
claims <- read.csv("data/claims.csv")

# What is the average duration in all of these cases assuming a discount rate of XXX?

# Were your assumptions about this correct? 

# What is the worst performing portfolio now?


