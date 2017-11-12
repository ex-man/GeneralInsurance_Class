library(ggplot2)
library(dplyr)

# VARIABLE DESCRIPTIONS:
#   survival        Claim Status
# (0 = Having a Claim; 1 = Not Having a Claim)
# pclass          Passenger Class
# (1 = 1st; 2 = 2nd; 3 = 3rd)
# sex             Sex
# age             Age
# sibsp           Number of Siblings/Spouses Aboard
# parch           Number of Parents/Children Aboard
# fare            Passenger Fare
# embarked        Port of Embarkation
# ship            Company ship number
# (C = Cherbourg; Q = Queenstown; S = Southampton)
# 
# SPECIAL NOTES:
#   Pclass is a proxy for socio-economic status (SES)
# 1st ~ Upper; 2nd ~ Middle; 3rd ~ Lower
# 
# Age is in Years; Fractional if Age less than One (1)
# If the Age is Estimated, it is in the form xx.5
# 
# With respect to the family relation variables (i.e. sibsp and parch)
# some relations were ignored.  The following are the definitions used
# for sibsp and parch.
# 
# Sibling:  Brother, Sister, Stepbrother, or Stepsister of Passenger Aboard Titanic
# Spouse:   Husband or Wife of Passenger Aboard Titanic (Mistresses and Fiances Ignored)
# Parent:   Mother or Father of Passenger Aboard Titanic
# Child:    Son, Daughter, Stepson, or Stepdaughter of Passenger Aboard Titanic
# 
# Other family relatives excluded from this study include cousins,
# nephews/nieces, aunts/uncles, and in-laws.  Some children travelled
# only with a nanny, therefore parch=0 for them.  As well, some
# travelled with very close friends or neighbors in a village, however,
# the definitions do not support such relations.

train_70 <- train %>% filter(data_status == "Training")
# Here we go, lets look at the variables in the table!

train_70 %>% glimpse

# See map of missings
Amelia::missmap(train_70, main = "Missing values vs observed")

# Scatterplot Matrix
GGally::ggpairs(train_70)

##### Target ########
## Advice: What is the structure of the variable? or
# How many people died?
train_70$survived %>% table

# Whats survival ratio?
train_70$survived %>% mean

# Which ship crashed?
table(train_70$ship, train_70$survived)

####### Embarked ####

# Again, What is the structure of the variable?
train_70$embarked %>% table # is equal to table(train_70$embarked)
table(train_70$embarked, train_70$survived)

# look there are som blank values, changing them to most common 
# Have you noticed we changed it also for our whole dataset? Can you guess why?
train_70$embarked[train_70$embarked == ""] <- "S"
train$embarked[train$embarked == ""] <- "S"

# Frequency analysis
table(train_70$embarked, train_70$survived)
# chi-sq test of independence or 
# Does it matter where the people embarked for their survival depends on it? 
table(train_70$embarked, train_70$survived) %>% summary()
# rejecting null hypothesis of independence between embarked and survived so 
# it looks like it does not depends on embarked place if people survived

# OK, it looks like this variable is not so useful, lets visualize little bit

# Graph

# look at so differences between groups!
train_70 %>% 
  group_by(embarked) %>% 
  summarise(m = mean(survived), n_people = n()) %>% 
  ggplot(. , aes(y = m, x = factor(embarked))) +
  geom_point(aes(size = n_people), color = c("#00BFFF"), alpha = 0.5)

# or no? don't forget to think about the scale!
## Advice: Scale
# It is really important on how you are showing data and to whom and 
# which type of analysis you are showing.
# For our case it make sense to use fixed scale of (0, 1) as we are talking 
# about probability of surviving
train_70 %>% 
  group_by(embarked) %>% 
  summarise(m = mean(survived), n_people = n()) %>% 
  ggplot(. , aes(y = m, x = factor(embarked))) +
  geom_point(aes(size = n_people), color = c("#00BFFF"), alpha = 0.5) +
  ylim(0, 1)

########## Fare #####
# What is the structure of the fare? DO you have some hyphothesis?
train_70$fare %>% hist
train_70$fare %>% density %>% plot

# What is the structure of the fare for those who survived vs. not survived?
train_70[train_70$survived == 1, ]$fare %>% density %>% plot
train_70[train_70$survived == 0, ]$fare %>% density %>% plot

# Maybe better in one graph
train_70 %>% 
  ggplot(aes(x = fare,  color = factor(survived))) +
  geom_density() 

# Lets try to create simple model
train_70 %>% 
  ggplot(aes(x = fare, y = survived)) + 
  geom_point(shape=1) +
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)

## Advice: Capping
# It seems we have no observations between ticket price of 300 and maximum 500.
# What do you think how many people paid 500? Probably not so much.
# Don't you think it could be only coincidence that those people survived or not?
# We are using statisical methods and they are based on law of big numbers, 
# so we should not rely on small group observations. We will make assumptions 
# that those people paid 300 instead of maximum of 500. Second assumptions could be 
# we will exclude those people from our dataset. You as a modeler need to decide.
#
# How to identify if making assumptions only about maximum value is right?
# Usuallu taking down the maximum is not enough, we will take down whole 1 or 5% of highest data
#
# Same could apply to minimum values. We will not focus on them for now.
train_70$fare[train_70$fare >= quantile(train_70$fare, 0.99)] <- quantile(train_70$fare, 0.99)

# Lets see what have changed...looks like trend is less stronger
train_70 %>% 
  ggplot(aes(x = fare, y = survived)) + 
  geom_point(shape=1) +
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)

######### PClass - socioeconomic status ##########

# What is the structure of the socioeconomic status?
train_70$pclass %>% table(useNA = 'ifany')

# people with lower status died, look only 3th class is significant
table(train_70$pclass, train_70$survived)
# rejecting null hypothesis, factors are not independent, very strong rejection!
table(train_70$pclass, train_70$survived) %>% summary

# Hey! Btw what exactly does it mean to be in specific economic class? 
# Do you think it might be similarity with the price people paid for the ticket?
cor(train_70$pclass, train_70$fare) # not perfect, but quite good correlation
cor(train_70$pclass, train_70$fare, method = "kendall")

# What do you remember about assumptions of using GLM model?

# pclass vs. fares
# people from 1th class if they paid much more for the ticket, looks they survived
train_70 %>% 
  ggplot(aes(x = fare, color = factor(survived))) +
  geom_density() +
  facet_wrap(~ pclass) +
  coord_flip()


######### Age ##############
# What is the structure of the age?
train_70$age %>% summary

train_70$age %>% density() %>% plot
# hops! we have missings in age! THis is not good for modelling, need to solve somehow 
train_70$age %>% density(na.rm = TRUE) %>% plot
# see trends, how old people usually survived?
train_70 %>% 
  ggplot(aes(x = age,  color = factor(survived))) +
  geom_density()

# age seems to be stong predictor we could create model for estimating age, 
# for now we will only imputate it using mean value
train_70$age[is.na(train_70$age)] <- mean(train_70$age, na.rm = TRUE)
train$age[is.na(train$age)] <- mean(train$age, na.rm = TRUE)

# See how it changed our density graph
train_70 %>% 
  ggplot(aes(x = age,  color = factor(survived))) +
  geom_density()
# Ou, thats huge change! Keep it in your mind when you are modelling 
# if you possibbly didn't bring some trend you woudn't want to

######### Sex ###########
train_70$sex %>% table(useNA = 'ifany')
table(train_70$sex, train_70$survived)

# rejecting null hypothesis, factors are not independent, very strong rejection!
table(train_70$sex, train_70$survived) %>% summary

train_70 %>% 
  ggplot(aes(x = sex,  y = factor(survived))) +
  geom_jitter() +
  geom_density(alpha = 0.3) 

# Lets try to think differently , sex alone is not strong predictive variable, 
# but with combination with age could be.
## age + sex
# counts
train_70 %>% 
  ggplot(aes(x = age,  fill = factor(survived))) +
  geom_histogram() +
  facet_grid( ~ sex)

# density, nice trends, possible interaction?
train_70 %>% 
  ggplot(aes(x = age,  fill = factor(survived))) +
  geom_density(alpha = 0.3) +
  facet_grid( ~ sex) +
  theme_classic()

# simple model
train_70 %>% 
  ggplot(aes(x = age, y = survived)) + 
  geom_point(shape=1) +
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE) +
  facet_grid( ~ sex)

train_70 <- train_70 %>% 
  mutate(age_cat = case_when(is.na(.$age) ~ "Missing",
                             .$age <= 15 ~ "1 - babies",
                             .$age > 15 & .$age <= 22 ~ "2 - youngsters",
                             .$age > 22 & .$age <= 35 ~ "3 - adults - 1",
                             .$age > 35 & .$age <= 50 ~ "4 - adults - 2",
                             .$age > 50 ~ "5 - olders"),
         age_mutualize = ifelse(is.na(age), mean(age, na.rm = TRUE), age)
  )


val_20 <- val_20 %>% 
  mutate(age_cat = case_when(is.na(.$age) ~ "Missing",
                             .$age <= 15 ~ "1 - babies",
                             .$age > 15 & .$age <= 22 ~ "2 - youngsters",
                             .$age > 22 & .$age <= 35 ~ "3 - adults - 1",
                             .$age > 35 & .$age <= 50 ~ "4 - adults - 2",
                             .$age > 50 ~ "5 - olders"),
         age_mutualize = ifelse(is.na(age), mean(age, na.rm = TRUE), age)
  )

train_70_adj$age_cat %>% table(train_70_adj$survived)
train_70_adj$age_cat %>% table(train_70_adj$survived) %>% summary




#### BOnus - you can play with it, maybe you will find out something
########### Parch/Sibsp - parents/siblings aboard #############
train_70$parch %>% table(useNA = 'ifany')
train_70$sibsp %>% table(useNA = 'ifany')

train_70$parch %>% table(train_70$survived)
train_70$parch %>% table(train_70$survived) %>% summary

train_70 %>% filter(parch<3) %>% select(parch, survived) %>% table %>% summary



