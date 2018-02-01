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
Paid_HH_sml <- dt_PaidCase %>% 
                filter(Business == "House" & ClaimSize == "Small" & dataset_type == "PAID") %>% 
                select(ay:SumOfamount) %>% as.triangle(origin="ay", dev="dy", value="SumOfamount") ## %>% incr2cum(na.rm = TRUE)

Incur_HH_sml <- dt_PaidCase %>% 
  filter(Business == "House" & ClaimSize == "Small") %>%
  group_by(Business,ClaimSize,ay,dy) %>%
  summarise(SumOfamount=sum(SumOfamount)) %>%
  select(ay:SumOfamount) %>% as.triangle(origin="ay", dev="dy", value="SumOfamount") ## %>% incr2cum(na.rm = TRUE)


## Now start plotting things to see more information

plot(Paid_HH_sml)
plot(predict(chainladder(Paid_HH_sml)))

plot(Incur_HH_sml)
plot(predict(chainladder(Incur_HH_sml)))

## And get the aging factors and some other stat's out to see more details
ata(Paid_HH_sml)
ata(Incur_HH_sml)

#--------





########################################
## Exercise 3
# Use the data provided in exercise 2 and try to come up with an estimates of the average duration. 
# How does it work? Well, discounting apart, in what year does the average payment happen? 
# HINT: (Here you definitely use paid claims, and it is enough to calculate weighted average of incremental payment)

##  get the weights
Incr_Paid_HH_sml <- Paid_HH_sml %>% cum2incr() %>% ata() %>% attr("vwtd")

## average duration
sum(Incr_Paid_HH_sml / cumsum(Incr_Paid_HH_sml)[9] *c(1:9))

# Does the value calculated correspond to your assumed value for the given business in Exercise 1? Comment on the findings in your notes...

# Now, assume an interest rate of 5%. How will the discounting change this?
sum(Incr_Paid_HH_sml / cumsum(Incr_Paid_HH_sml)[9] * (1/1.05^c(1:9)) * c(1:9)) ##this is a simplification. CL should happen on discounted data

# Recall what is UWR from Lesson 2. Assume premium and expenses are calculated on day 1.
# Can you calculate a sigle number, that could be used to discount the claims to arrive to Net present value of UWR?

########################################
## Exercise 4
# Now, let’s have a look at it from the other way around. 
# The following dataset includes the same data you were analysing in class 1, but it is all discounted...
claims <- read.csv("data/claims.csv")

# What is the average duration in all of these cases assuming a discount rate of XXX?

# Were your assumptions about this correct? 

# What is the worst performing portfolio now?


