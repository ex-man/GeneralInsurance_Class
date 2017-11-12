library(dplyr)

# Generating more data
train <- titanic::titanic_train %>% 
  select(-Name, -Cabin, -Ticket, -PassengerId) %>% 
  mutate(Ship = 0)

test <- titanic::titanic_test %>% 
  select(-Name, -Cabin, -Ticket, -PassengerId)

set.seed(5987125)

train_sample <- train %>% 
  sample_n(9000, replace = TRUE) %>% 
  mutate(Survived = 1, Ship = round(runif(9000, 1, 10))) 
  
train_sample[train_sample$Ship == 7, "Survived"] <-
  sample(train$Survived, nrow(train_sample[train_sample$Ship == 7, ]), replace = TRUE)

train <- rbind(train, train_sample)
rm(train_sample)

names(train) <- names(train) %>% tolower

write.csv(train, "data/data_titanic_adj.csv", row.names = FALSE)
