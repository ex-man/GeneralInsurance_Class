# Skus priblizne zreprodukovat graf 'zadanie/hw_hlubinova.png', ktory najdes v priecinku 'Homework'.
# Budes pracovat s datami, ktore sa importuju nizsie.

# Rada: pouzi dva krat 'geom_line', raz pre "Losses" a raz pre "Premium"

# Vysledok skus aj interpretovat (1 - 2 vety).

library(tidyverse)
dt_KPI <- read_csv("./Data/lesson3_KPI.csv")

dt_KPI %>% 

  ...
  
  labs(y = "Premium, Losses") # pouzi v ramci ggplot (na predchadzajucom riadku musi byt '+')