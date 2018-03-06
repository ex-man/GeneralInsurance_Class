#### Loss analysis ####
# Libraries
library(dplyr)
library(ggplot2)

# data about KPIs
dt_Policy <- read.csv("data/policy_history.csv")
dt_Claims <- read.csv("data/claims.csv")

########################################
## Exercise 1
#  Make sense of data. They should be coming from the same source, but it is worth checking...
#  Let's start by understanding the data. Answer the following questions:
#  1) How many year of data do we have?
#  2) Are all the policies annual?
#  3) Is this a short-tailed or a long-tailed business? Hint: calculate average claim duration
#  4) Are there any unreasonable data in claims or policies?

#  Try to join the data together and comment on the data quality (unmerged, missing)...

########################################
## Exercise 2
#  Before providing a sensible results, it is worth deciding on what we are going to be modelling.
#  As models should predict something (future in our case), we take historical data and trend them. 
#  Think about at least 3 different things you could model 
#  (number of ..., average of ..., sum of ..., size of ..., ...)


########################################
## Exercise 3
#  As we have already talked about the losses, we will be trying to model time weighted average loss.
#  What do you need to calculate this?
#  HINT: Think about what triangles we were using in lesson 3 + earned portion of the policy in the year


########################################
## Exercise 4
#  Projecting simply like in Exercise 2 is not enough for us. We must be able to understand the drivers!
#  Spent some time about the factors in the policy data. What trends would you expect? Comment in your notes.
dt_Policy %>% colnames %>% data.frame()

#  ... Use Shiny to display the dependencies ...

#  Were you right? Commit the answers again, so that you can easily show git diff of before and after.
