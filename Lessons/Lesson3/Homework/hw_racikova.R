# Skus zreprodukovat graf 'hw_racikova.png', ktory najdes v priecinku 'Homework'.
# Budes pracovat s datami, ktore sa importuju nizsie. Ponechaj si len riadky s rokom vacsim ako 2015.
# Na Ypsilonovej osi je premenna 'Underwriting result' (rozdiel poistneho, skod a nakladov).

# Rada 1: v ramci aes() pouzi 'fill'
# Rada 2: pri 'geom_col' existuje argument 'position'

# Vysledok skus aj interpretovat (1 - 2 vety).

library(tidyverse)
dt_KPI <- read_csv("./Data/lesson3_KPI.csv")

dt_KPI %>% 

  ...
