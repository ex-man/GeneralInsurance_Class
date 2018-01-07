####### Data preparation for lesson 2 (KPI's, searching for bad looking portfolios) #####

# libraries
library(dplyr)
library(ggplot2)

# load data
dt_KPI_raw <- read.csv("data/lesson2_KPI.csv")

## what type of information we have? (column quick view)
dt_KPI_raw %>% glimpse

## some data dictionary would be helpful, do we have some?

## what the columns contains?
dt_KPI_raw %>% summary()

#### looking for defects in data ####
## are there any missings?
dt_KPI_raw %>% lapply(function(x) {is.na(x) %>% table}) # leave blank

## are there any non sense values? 
# what are not allowed vaules for specific columns? lets look individually
# be prepared to deal with continuous and categorical values as well
dt_KPI_raw$Region %>% table(useNA = "ifany") # leave blank

dt_KPI_raw$Losses %>% summary # leave blank

#### correction of defects ####
## what is the feasible way to repair missing values? 
dt_KPI_raw <- dt_KPI_raw %>% 
  mutate(Business = ifelse(is.na(Business), "Missing", as.character(Business))) # leave blank

## what is the feasibly way to repair non sense values?
dt_KPI_raw <- dt_KPI_raw %>% 
  filter(Premium > 0,
          Losses > 0, 
         Expenses > 0
  )

# viz basics, ak bude cas, tak time dimension na ulohu 
# reflection - ze napisat co si myslia aky je dovod performanceS

# 3 times same thing

#### building KPIs ####
# what is the nice way to look into Loss/Expenses/Premium information?

dt_KPI_raw %>%
  rename(NEP = Premium,
         Loss = Losses,
         Expenses = Expenses,
         Time = Year
  ) %>% 
  mutate(LR = Loss / NEP, # leave blank
         ER = Expenses / NEP, # leave blank
         CoR = (Loss + Expenses) / NEP, # leave blank 
         UWR = NEP - Loss - Expenses, # leave blank
         Time_Y = Time %>% substr(1, 4)
  ) %>% 
  summarize(LR = mean(LR, na.rm =TRUE), # leave blank
            ER = mean(ER, na.rm = TRUE), # leave blank
            CoR = mean(CoR, na.rm = TRUE), # leave blank
            UWR = sum(UWR, na.rm = TRUE), # leave blank
            Premium = sum(NEP, na.rm = TRUE) # leave blank
  ) %>% 
  mutate(Dimension = "Total") %>% 
  select(Dimension, everything()) %>% 
  mutate_at(vars(UWR, Premium), funs(scales::dollar)) %>% 
  mutate_at(vars(LR, ER, CoR), funs(scales::percent))

dt_KPI_raw <- 
  dt_KPI_raw %>%
  rename(NEP = Premium,
         Loss = Losses,
         Expenses = Expenses,
         Time = Year
  ) %>% 
  mutate(LR = Loss / NEP , # leave blank
         ER = Expenses / NEP , # leave blank
         CoR = (Loss + Expenses) / NEP , # leave blank 
         UWR = NEP - Loss - Expenses, # leave blank
         Time_Y = Time %>% substr(1, 4)
  )

#### visualization ####
# What makes sense to visualize/compare at visual sense?

# e.g. Business Unit View using bar charts - ggplot2::geom_col()
dt_KPI_raw %>% 
  group_by(Unit) %>% 
  summarize(LR = mean(LR, na.rm =TRUE), # leave blank
            ER = mean(ER, na.rm = TRUE), # leave blank
            CoR = mean(CoR, na.rm = TRUE), # leave blank
            UWR = sum(UWR, na.rm = TRUE), # leave blank
            Premium = sum(NEP, na.rm = TRUE) # leave blank
  ) %>% 
  ggplot(aes(x = Unit, y = CoR)) + 
  geom_col()

# e.g. Business Unit View (Multi View on LR and ER)
# introducing wide and long format of the table
dt_KPI_raw %>% 
  group_by(Unit) %>% 
  summarize(LR = mean(LR, na.rm =TRUE), # leave blank
            ER = mean(ER, na.rm = TRUE), # leave blank
            CoR = mean(CoR, na.rm = TRUE), # leave blank
            UWR = sum(UWR, na.rm = TRUE), # leave blank
            Premium = sum(NEP, na.rm = TRUE) # leave blank
  ) %>% 
  reshape2::melt(measure.vars = c("ER", "LR"), 
                variable.name = "Ratio", value.name = "Ratio_Value") %>% 
  ggplot(aes(x = Unit, y = Ratio_Value, fill = Ratio)) + 
  geom_col()

# e.g. Business Unit View using bar charts - ggplot2::geom_col() on UWR
dt_KPI_raw %>% 
  group_by(Unit) %>% 
  summarize(LR = mean(LR, na.rm =TRUE), # leave blank
            ER = mean(ER, na.rm = TRUE), # leave blank
            CoR = mean(CoR, na.rm = TRUE), # leave blank
            UWR = sum(UWR, na.rm = TRUE), # leave blank
            Premium = sum(NEP, na.rm = TRUE) # leave blank
  ) %>% 
  ggplot(aes(x = Unit, y = UWR)) + 
  geom_col()

#### shiny ####
# where it makes sense to use dynamic range / create interactivity?