####### Data preparation for lesson 2 (KPI's, searching for bad looking portfolios) #####

# libraries
library(dplyr)
library(ggplot2)

# load data
dt_KPI_raw <- read.csv("data/lesson2_KPI.csv")

## What type of information do we have?
# Hint: To have a quick overview of data use glimpse() function from dplyr


## It is good to know what your data contains and what the column names mean,
# usually Data Governance team could help you with this question.
# For now let's assume we know what our columns mean

## What do the columns contain?
# Hint: The function summary() might help you to answer this question


#### Looking for defects in data ####
## Are there any missing values?
# As a first task, try to find missings for a specific column only
# Can you generalize this process for the whole dataset? 
# Hint: Can you use any kind of loop here?


## Are there any values that don't make any sense in the context of the data? 
# Which vaules are not allowed for specific columns? Let's have a look at individual columns
# Be prepared to deal with continuous and categorical values as well


#### Correction of defects ####
## What is the feasible way to repair missing values? 

## What is the feasible way to repair values that don't make sense?

#### Visualization of Raw Data ####
### What makes sense to visualize (or compare using some visualization) in terms of KPIs?

## Data preparation for visualization
# Which Unit has collected the most Premium? 
dt_KPI_raw %>% 
  group_by(Unit) %>% 
  summarize(Premium = sum(Premium, na.rm = TRUE)) %>% 
  arrange(desc(Premium))

# Which Unit has the lowest Expenses? 


# Which Business from Unit found in the previous task had the highest Expenses? 


## Basic Visualization
## Visualize your findings on simple bar charts - ggplot2::geom_col()
# Which Unit has collected the most Premium? 
dt_KPI_raw %>% 
  group_by(Unit) %>% 
  summarize(Premium = sum(Premium, na.rm = TRUE),
            Expenses = sum(Expenses, na.rm = TRUE),
            Losses = sum(Losses, na.rm = TRUE)
  ) %>% 
  ggplot(aes(x = reorder(Unit, -Premium), y = Premium)) + 
  geom_col()

# Which Unit has the lowest Expenses? 


# Which Business from Unit found in the previous task had the highest Expenses? 


# Bonus - Show all Costs Insurance Company has as a stacked bar for 
# Expenses and Losses grouped by Units


### Reflection - write a short comment to your notes in repository on what you think is the best and the worst Unit performer.
# Feel free to do more data exploration.



################################################################################

#### Building KPIs ####
# Is there a better way to look into Losses/Expenses/Premium information?









#### Visualization of KPIs ####
### What makes sense to visualize/compare at visual level in terms of KPIs?

## Try to find answers for the next questions using the KPIs you learned about
# Which Unit looks bad in terms of Losses? 


# Which Unit looks pretty good in terms of Expenses? 


# Which Business from previous Unit looks bad in terms of Expenses? 


# Bonus - Make a stacked bar for Losses and Expenses using the KPIs you learned about
# Does it help you to find something new?


### Reflection again - write a short comment to your notes in repository on what you think is 
# the best and the worst Unit performer based on what you have learned recently.
# Feel free to do more data exploration.



################################################################################

#### UWR ####
# Is there even better way how to look at portfolios? Previously we spoke about Ratios 
# and relative performance. Can you create something similar but as a performance in absolute numbers?
# How could be absolute performance defined?



# Which Unit looks pretty good in terms of UWR? 


# Which Business of previous Unit looks bad in terms of UWR? 


### Reflection again - write a short comment to your notes in repository on what you think is 
# the best and the worst Unit performer based on what you have learned recently.
# Feel free to do more data exploration.



################################################################################

#### shiny ####
# Where does it make sense to use dynamic range / create interactivity?

# Go to the root folder of the repository and type shiny::runApp() for running the Class Shiny app.
# Edit files shiny_tab2_content.R (as ui.R for lesson2) and shiny_tab2_server.R (as server.R for lesson2)
