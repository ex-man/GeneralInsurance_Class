# Find out, which __year__ was the __most terrific__ for portfolio you have identified as __most profitable__ during the lesson and 
# show it on the chart using `ggplot2` package. Write an explanation about your findings into the code as comment.
# __Commit__ it to your repository into `Lessons/Lesson2/Homework`.

## Code
library(dplyr)
library(ggplot2)  
#dt_KPI_raw  <- read.csv ( "./Data/lesson2_KPI.csv" ) # namiesto bodky sa napiše cesta k priečinku Data
dt_KPI_raw  <- read.csv ("C:/Users/Lucia_Sebestova/Documents/Matfyz(4)/VTvAktuarstve/GeneralInsurance_Class/Data/lesson2_KPI.csv")
dt_KPI_raw %>% 
  mutate(Premium = ifelse(Premium < 0, 0, Premium))
dt_KPI_raw %>% mutate(UWR = Premium - Losses - Expenses) %>%
  group_by(Year) %>%  
  summarize(UWR = sum(UWR, na.rm = TRUE)) %>% 
  arrange(UWR) 
dt_KPI_raw %>% mutate(UWR = Premium - Losses - Expenses) %>%
  group_by(Year) %>%  
  summarize(UWR = sum(UWR, na.rm = TRUE)) %>%
  ggplot(aes(x = reorder(Year, UWR), y = UWR)) + geom_col()
# 
# Your Explanation about analysis:
# 1.vytvorila som premennú UWR (Underwriting Result)
# 2.zoskupila som podľa roku a porovnala som ich podľa UWR
# 3.vyšlo mi, ze najhorší rok portfolia je rok 2015 pri ktorom bola UWR najmenšia
