# File elabora_dati_oecd.R ###############################################
# Elaborazione dei dati OECD sulla produttività
#
# elabora i dati e li rende disponibili per l'elaborazione dei grafici
# scritto per l'articolo su "professionalità" del gennaio 2019
###

library(tidyverse)
library(ggthemes)
library(reshape)


load("data-raw/produttivity.RData")
load("data-raw/salari_medi.RData")
load("data-raw/unit_labour_cost.RData")

# pil per occupato ####
ulc_gdp_s <- unit_labour_cost %>%  filter(
  SUBJECT == "ULQELP01",
  MEASURE =="IXOBSA",
  LOCATION %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA"),
  obsTime >= "1991-Q1") %>%
  mutate(pil_nr_indice = obsValue) %>%
  select(LOCATION, obsTime, pil_nr_indice)

usethis::use_data(ulc_gdp_s, overwrite = TRUE)

# pil per ora lavorata ####
ora_lavorata <- productivity %>%
  filter(SUBJECT == "T_GDPHRS", MEASURE == "VPVOB" ,
         LOCATION %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA")) %>%
  mutate(obsTime = as.numeric(obsTime)) %>%
  mutate(pil_ora = obsValue) %>%
  select(LOCATION, obsTime, pil_ora) %>%
  filter(obsTime >= 1992)

usethis::use_data(ora_lavorata, overwrite = TRUE)

# elabora salario medio ####
salario_medio <- salari_medi %>%
  filter(SERIES == "USDPPP",
         COUNTRY %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA")) %>%
  mutate(obsTime = as.numeric(obsTime)) %>%
  mutate(salario_medio = round(obsValue/1000, 2)) %>%
  select(COUNTRY, obsTime, salario_medio) %>%
  filter(obsTime >= 1992)

usethis::use_data(salario_medio, overwrite = TRUE)

# salario medi e produttività ####
prod_sal <- salario_medio %>%
  left_join(ora_lavorata, by = c("COUNTRY" = "LOCATION", "obsTime" = "obsTime")) %>%
  filter(obsTime >= 1992)

usethis::use_data(prod_sal, overwrite = TRUE)

# salari minimi, massimi e quartili ####
mins <- prod_sal %>% group_by(COUNTRY) %>% slice(which.min(salario_medio))
maxs <- prod_sal %>% group_by(COUNTRY) %>% slice(which.max(salario_medio))
ends <- prod_sal %>% group_by(COUNTRY) %>% filter(obsTime == max(obsTime))
quarts <- prod_sal %>% group_by(COUNTRY) %>%
  summarize(quart1 = quantile(salario_medio, 0.25),
            quart2 = quantile(salario_medio, 0.75)) %>%
  right_join(prod_sal)

usethis::use_data(mins, overwrite = TRUE)
usethis::use_data(maxs, overwrite = TRUE)
usethis::use_data(ends, overwrite = TRUE)
usethis::use_data(quarts, overwrite = TRUE)

