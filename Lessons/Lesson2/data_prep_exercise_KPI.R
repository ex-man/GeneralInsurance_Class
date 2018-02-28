####### Data preparation for lesson 2 (KPI's, searching for bad looking portfolios) #####

# libraries
library(dplyr)
library(ggplot2)

# load data
dt_KPI_raw <- read.csv("data/lesson2_KPI.csv")

## what type of information we have? (column quick view)
# to have a quick overview of data use glimpse() function from dplyr


## its good to know what your data contains and what the columns means,
# usually Data Governance team could help you with this question,
# lets imagine we are aware what our columns means

## what the columns contains?
# the function summary() might help you to answer this


#### looking for defects in data ####
## are there any missings?
# try to find missings for specific column firstly
# can you generalize this process for whole dataset? can you utilize any kind of loop here?


## are there any non sense values? 
# what are not allowed vaules for specific columns? lets look individually
# be prepared to deal with continuous and categorical values as well


#### correction of defects ####
## what is the feasible way to repair missing values? 


## what is the feasible way to repair non sense values?

#### Visualization of Raw Data ####
### What makes sense to visualize/compare at visual sense for KPIs?

## Data Preparation for Vizualization
# Which Unit has collected the most Premium? 
dt_KPI_raw %>% 
  group_by(Unit) %>% 
  summarize(Premium = sum(Premium, na.rm = TRUE)) %>% 
  arrange(desc(Premium))

# Which Unit has spent the least Expenses? 


# Which Business of previous Unit has spent the most Expenses? 


## Basic Viz.
## Vizualize your findings on simple bar charts - ggplot2::geom_col()
# Which Unit has collected the most Premium? 
dt_KPI_raw %>% 
  group_by(Unit) %>% 
  summarize(Premium = sum(Premium, na.rm = TRUE),
            Expenses = sum(Expenses, na.rm = TRUE),
            Losses = sum(Losses, na.rm = TRUE)
  ) %>% 
  ggplot(aes(x = reorder(Unit, -Premium), y = Premium)) + 
  geom_col()

# Which Unit has spent the least Expenses? 


# Which Business of previous Unit has spent the most Expenses? 


# Bonus - Show all Costs Insurance Company has as a stacked bar for 
# Expenses and Losses grouped by Units


### Reflection (5 min) - write a short comment to your notes in repository on what do you think is the best and worst Unit performer.
# Feel free to do more data exploration.



################################################################################

#### Building KPIs ####
# Is there a better way to look into Losses/Expenses/Premium information?









#### Visualization of KPIs ####
### What makes sense to visualize/compare at visual sense for KPIs?

## Try to find answers on next questions using new KPIs terms you learned
# Which Unit looks bad in terms of Losses? 


# Which Unit looks pretty good in terms of Expenses? 


# Which Business of previous Unit looks bad in terms of Expenses? 


# Bonus - Make a stacked bar for Losses and Expenses using new KPIs term you learn. 
# Does it help you to explore something new?


### Reflection again (5 min) - write a short comment to your notes in repository on what do you think is 
# the best and worst Unit performer based on what have you learned recently.
# Feel free to do more data exploration.



################################################################################

#### UWR ####
# Is there even better way on how to look on portfolios? Previously we spoke about Ratios 
# and relative performances. Can you create something similar but as a absolute performance?
# How could be absolute performance defined?



# Which Unit looks pretty good in terms of UWR? 


# Which Business of previous Unit looks bad in terms of UWR? 


### Reflection again (5 min) - write a short comment to your notes in repository on what do you think is 
# the best and worst Unit performer based on what have you learned recently.
# Feel free to do more data exploration.



################################################################################

#### shiny ####
# where it makes sense to use dynamic range / create interactivity?

# Go to the root folder of the repository and type shiny::runApp() for running the Class Shiny app.
# Edit files shiny_tab2_content.R (as ui.R for lesson2) and shiny_tab2_server.R (as server.R for lesson2)