# Find out, which __year__ was the __most terrific__ for portfolio you have identified as __most profitable__ during the lesson and 
# show it on the chart using `ggplot2` package. Write an explanation about your findings into the code as comment.
# __Commit__ it to your repository into `Lessons/Lesson2/Homework`.

## Code


install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)

dt_KPI_raw <- read.csv("C:/GeneralInsurance_Class/Data/lesson2_KPI.csv") 

dt_KPI_raw %>% mutate(Premium = ifelse(Premium < 0, 0, Premium)) %>% head

dt_KPI_raw %>% mutate(UWR = Premium - Expenses - Losses) %>% 
  group_by(Year) %>% summarize(UWR = sum(UWR, na.rm = TRUE)) %>%
  arrange(UWR) 

dt_KPI_raw %>% mutate(UWR = Premium - Expenses - Losses) %>% 
  group_by(Year) %>% summarize(UWR = sum(UWR, na.rm = TRUE)) %>% 
  ggplot(aes(x = reorder(Year, UWR), y = UWR)) + geom_col()


# Your Explanation about analysis:
#
# Instalacia a otvorenie balikov
# Nacitanie dat 
# Zoskupenie dat podla rokov
# Porovnanie podla UWR
# Graficke znazornenie 
#
# Najmenej ziskovy bol rok 2015, lebo ma najnizsie UWR
