# Pozri si, ktore zadanie ti bolo priradene, najdi si ho vo foldri 'zadanie'
# Skopiruj si instrukcie sem a vypracuj ulohu
#
# Na zaciatok si nacitaj data a funkcie (rovnako ako na hodine):

library(dplyr); library(ggplot2); library(plotly); library(statmod); library(glmnet)
source("/cloud/project/Support/rmse_group.R")
source("/cloud/project/Support/tweedie_deviance.R")
source("/cloud/project/Support/emb_chart_plotly.R")
source("/cloud/project/Support/compare_models.R")
source("/cloud/project/Support/mismatch_rank.R")
source("/cloud/project/Support/selection_helpers.R")

dt <- readRDS("/cloud/project/Data/dt_engineered.rds")
train <- dt[dt$Dataset == "train", ]
valid <- dt[dt$Dataset == "valid", ]

# Premenne, z ktorych vyberove metody vyberaju (rovnaky zoznam ako na hodine). Tvoja startovacia premenna
# je v nom tiez; metoda si ju sama odstrani, ked ju das do argumentu 'base'.
candidates <- c(
  "Veh_type2_merged", "BonusMalus_adj", "Time_on_book_cap", "Sum_insured_log", "Capacity_band",
  "Construct_year_band", "Nr_of_seats_grp", "D_age_adj", "VEH_brand_grp", "D_ZIP_1", "Year",
  "Customer_Type", "Veh_type1_grp", "VEH_type_grp"
)
