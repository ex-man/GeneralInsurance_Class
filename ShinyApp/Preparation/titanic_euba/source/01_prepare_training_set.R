# Load necessary libraries
library(dplyr)

# Check where we are
getwd()
# Load training data
train <- read.csv("Preparation/titanic_euba/data/data_titanic_adj.csv", stringsAsFactors = FALSE)

# `%>%` works as a pipe and forward object on the left side to function on the right side 
# e.g. x %>% f(y) is same as f(x, y)
# Why is it useful and more info about piping here:
# https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html

# glimpse is short description of table
train %>% glimpse

#### Training vs. Validation ####
set.seed(58742) # to fix randomizer
ind <- sample(3, nrow(train), replace=TRUE, prob=c(0.70, 0.20, 0.10)) # generate random indicator to split

train <- mutate(train,
                data_status = ifelse(ind == 1, 
                                     "Training",
                                     ifelse(ind == 2, 
                                            "Validation", 
                                            "Unseen")
                )
)

# Check if correctly created data_status
train$data_status %>% table
