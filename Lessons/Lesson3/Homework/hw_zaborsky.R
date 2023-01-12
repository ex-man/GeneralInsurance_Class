# Skus zreprodukovat graf 'hw_zaborsky.png', ktory najdes v priecinku 'Homework'.
# Budes pracovat s datami, ktore sa importuju nizsie.
# Vytvor premennu 'BigExpenses', ktora ma hodnotu "Yes", ak je v riadku pomer nakladov a poistneho vacsi ako 0.35,
# inak ma hodnotu "No". Podla tejto premennej vyfarbi body v grafe. 

# Rada: pri vytvarani novej premennej pouzi funkciu "ifelse".
# Rada2: na vytvorenie 'vysmoothovanej' krivky mozes pouzit funkciu `geom_smooth`

# Vysledok skus aj interpretovat (1 - 2 vety).

library(tidyverse)
dt_KPI <- read_csv("./Data/lesson3_KPI.csv")

dt_KPI %>% 

  ...