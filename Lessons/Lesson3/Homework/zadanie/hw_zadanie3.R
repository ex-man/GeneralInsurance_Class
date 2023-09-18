# Skus priblizne zreprodukovat graf 'zadanie/hw_zadanie3.png', ktory najdes v priecinku 'Homework'.
# Budes pracovat s datami, ktore sa importuju nizsie. Ponechaj si len riadky so segmentom 'Small' a rokom 2015.
# Na Ypsilonovej osi je premenna Combined ratio, pre ktoru plati: CoR = (Losses + Expenses) / Premium.

# Vysledok skus aj interpretovat (1 - 2 vety).

library(tidyverse)
dt_KPI <- read_csv("./Data/lesson3_KPI.csv")

dt_KPI %>% 

    ...