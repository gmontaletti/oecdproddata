# File prod_oecd_download.R ###############################################
# Elaborazione dei dati OECD sulla produttività
#
# scarica i dati li salva per la successiva elaborazione
# scritto per l'articolo su "professionalità" del gennaio 2019
###

# richiede la libreria "OECD"
# install.packages("OECD")
library(OECD)

#  acquisisce i dati sulla produttività
# PDB_LV  "Level of GDP per capita and productivity"
productivity <- get_dataset("PDB_LV")
save(productivity, file = "data-raw/produttivity.RData")

#  acquisisce i dati sui salari
salari_medi <- get_dataset("AV_AN_WAGE")
save(salari_medi, file = "data-raw/salari_medi.RData")

# ULC_EEQ Unit labour costs and labour productivity (employment based), Total economy
unit_labour_cost <- get_dataset("ULC_EEQ")
save(unit_labour_cost, file = "data-raw/unit_labour_cost.RData")


