# Pozri si, ktore zadanie ti bolo priradene, najdi si ho vo foldri 'zadanie'
# Skopiruj si instrukcie sem a vypracuj ulohu
#
# Na zaciatok si nacitaj data a funkcie (rovnako ako na hodine):
#
# library(dplyr); library(ggplot2); library(plotly); library(statmod); library(glmnet)
# source("/cloud/project/Support/rmse_group.R")
# source("/cloud/project/Support/tweedie_deviance.R")
# source("/cloud/project/Support/emb_chart_plotly.R")
# source("/cloud/project/Support/compare_models.R")
# source("/cloud/project/Support/mismatch_rank.R")
# source("/cloud/project/Support/selection_helpers.R")
#
# dt <- readRDS("/cloud/project/Data/dt_engineered.rds")
# train <- dt[dt$Dataset == "train", ]
# valid <- dt[dt$Dataset == "valid", ]
#
# Kandidati pre vyberove metody: premenne z hodiny a navyse typ vozidla. Typ vozidla ('Veh_type2_merged') bol
# v hodine zakladom, v zadani je to obycajny kandidat. Tvoja startovacia premenna ide do argumentu 'base'.
# hw_candidates <- c("Veh_type2_merged", candidate_vars)
