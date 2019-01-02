################################################
# Elaborazione dei dati OECD sulla produttività
# File prod_oecd_download.R
#
# scarica i dati li salva per la successiva elaborazione
# e produce alcuni grafici sulla produttività comparata in 6 paesi frai quali l'Italia.
# scritto per l'articolo sul "professionalità" del gennaio 2019
################################################

# richiede la libreria "OECD"
# install.packages("OECD")
library(OECD)
library(tidyverse)

#  legge da OECD i datasets disponibili ######
# genera un dataframe con id e titolo di dataset
oecd_dati <- get_datasets()

# cerca nella lista dei dataset quelli che contengono la parola "productivity"
search_dataset("productivity", data = oecd_dati, ignore.case = T)

# cerca nella lista dei dataset quelli che contengono la parola "wage"
search_dataset("wage", data = oecd_dati, ignore.case = T)

#  acquisisce i dati sulla produttività
# PDB_LV  "Level of GDP per capita and productivity"
# productivity <- get_dataset("PDB_LV")
# save(productivity, file = "produttivita.RData")
load(file = "data/produttivita.RData")
prod_stru <- get_data_structure("PDB_LV")

prod_stru[["SUBJECT"]]
prod_stru[["VAR_DESC"]]
prod_stru[["MEASURE"]]

#  acquisisce i dati sui salari

# salari_medi <- get_dataset("AV_AN_WAGE")
# save(salari_medi, file = "salari.RData")
load("data/salari.RData")
# salari_medi_str <- get_data_structure("AV_AN_WAGE")
# salari_medi_str[["VAR_DESC"]]
# salari_medi_str[["SERIES"]]

#  dati sulla produttività multi fattore
# mfp <- get_dataset("MFP")
# save(mfp, file = "mfp.RData")
load("data/mfp.RData")
mfp_str <- get_data_structure("MFP")
mfp_str[["VAR"]]

# ULC_EEQ Unit labour costs and labour productivity (employment based), Total economy
# ulc <- get_dataset("ULC_EEQ")
# save(ulc, file = "ulc.RData")
load("data/ulc.RData")
# ulc_str <- get_data_structure("ULC_EEQ")
# ulc_str[["MEASURE"]]
# ulc_str[["SUBJECT"]]
ulc_paesi <- ulc %>%  filter(FREQUENCY == "A",
               SUBJECT == "ULQEUL01",
               MEASURE =="IXOBSA",
               LOCATION %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA"))
ulc_paesixocc <- ulc %>%  filter(
                             SUBJECT == "ULQECU01",
                             MEASURE =="IXOBSA",
                             LOCATION %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA"))
ulc_gdp <- ulc %>%  filter(
                                 SUBJECT == "ULQELP01",
                                 MEASURE =="IXOBSA",
                                 LOCATION %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA"))



# elaborazioni #####

#  pil per occupato

ulc_gdp_s <- ulc_gdp %>%
  mutate(pil_nr_indice = obsValue) %>%
  filter(obsTime >= "1991-Q1") %>%
  select(LOCATION, obsTime, pil_nr_indice)


ggplot(ulc_gdp_s, aes(x = obsTime, y = pil_nr_indice , group = LOCATION, color = LOCATION)) +
  geom_point(size = 0.5, show.legend = FALSE) +
  geom_smooth(se = F, show.legend = FALSE) +
  theme_minimal() +
  scale_y_continuous("Pil per occupato") +
  scale_x_discrete(" ", breaks = as.character(seq(from = 1992, to = 2017, by = 5))) +
  labs(title = "PIL per occupato",
       subtitle = "numero indice 2015 = 100",
       caption = "elaborazione su dati OECD") +
  scale_color_brewer(palette = "Dark2", name=" ") +
  facet_wrap(~ LOCATION, nrow = 2, ncol = 3)

#  pil per ora lavorata
ora_lavorata <- productivity %>%
  filter(SUBJECT == "T_GDPHRS", MEASURE == "VPVOB" ,
                                LOCATION %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA")) %>%
  mutate(obsTime = as.numeric(obsTime)) %>%
  mutate(pil_ora = obsValue) %>%
  select(LOCATION, obsTime, pil_ora) %>%
  filter(obsTime >= 1992)

brea <- seq(from = 1992, to = 2017, by = 5)
brea <- (as.character(brea))
class(brea)
is.vector(brea)
brea

ggplot(ora_lavorata, aes(x = obsTime, y = pil_ora, group = LOCATION, color = LOCATION)) +
  geom_point(size = 0.5, show.legend = FALSE) +
  geom_smooth(se = F, show.legend = FALSE) +
  theme_minimal() +
scale_y_continuous("Pil per ora lavorata") +
scale_x_continuous("anno") +
   labs(title = "PIL per ora lavorata",
        subtitle = "intera economia, PPPs 2010, in dollari, a prezzi costanti",
        caption = "elaborazione su dati OECD") +
   scale_color_brewer(palette = "Dark2", name=" ") +
facet_wrap(~ LOCATION, nrow = 2, ncol = 3)

#  elabora salari #####

salario_medio <- salari_medi %>%
  filter(SERIES == "USDPPP",
         COUNTRY %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA")) %>%
  mutate(obsTime = as.numeric(obsTime)) %>%
  mutate(salario_medio = round(obsValue/1000, 2)) %>%
  select(COUNTRY, obsTime, salario_medio) %>%
  filter(obsTime >= 1992)


ggplot(salario_medio, aes(x = obsTime, y = salario_medio, group = COUNTRY, color = COUNTRY)) +
  geom_line(size = 0.5, show.legend = FALSE) +
  geom_smooth(se = F, show.legend = FALSE) +
  theme_minimal() +
  scale_y_continuous("Salario medio annuo") +
  scale_x_continuous(" ", breaks = seq(from = 1992, to = 2017, by = 5)) +
  labs(title = "Salario medio",
       subtitle = "intera economia, PPPs 2017, in migliaia di dollari, a prezzi costanti",
       caption = "elaborazione su dati OECD") +
  scale_color_brewer(palette = "Dark2", name=" ") +
  facet_wrap(~ COUNTRY, nrow = 2, ncol = 3)

#  assieme

prod_sal <- salario_medio %>%
  left_join(ora_lavorata, by = c("COUNTRY" = "LOCATION", "obsTime" = "obsTime")) %>%
  filter(obsTime >= 1992)

maxs <- group_by(prod_sal, COUNTRY) %>% slice(which.max(salario_medio))
mins <- group_by(prod_sal, COUNTRY) %>% slice(which.min(salario_medio))

ggplot(prod_sal, aes(x = pil_ora, y = salario_medio, group = COUNTRY, color = COUNTRY)) +
  geom_point(size = 0.9, show.legend = T) +
  geom_smooth(se = F, show.legend = FALSE, method  = "lm") +
  geom_point(data = maxs, col = 'black', size = 2) +
  geom_text(data = maxs, aes(label = obsTime), vjust = -0.39, show.legend = FALSE) +
  # geom_text(data = mins, aes(label = obsTime), vjust = -0.39, show.legend = FALSE) +
  theme_minimal() +
  scale_y_continuous("Salario medio annuo") +
  scale_x_continuous("Pil per ora lavorata") +
  labs(title = "Crescita del Pil per ora lavorata e salario medio annuo",
       subtitle = "intera economia, PPPs 2017, in dollari, a prezzi costanti",
       caption = "elaborazione su dati OECD") +
  scale_color_brewer(palette = "Dark2", name=" ")


# tuftee

library(ggplot2)
library(ggthemes)
library(dplyr)
library(reshape)
library(RCurl)


mins <- prod_sal %>% group_by(COUNTRY) %>% slice(which.min(salario_medio))
maxs <- prod_sal %>% group_by(COUNTRY) %>% slice(which.max(salario_medio))
ends <- prod_sal %>% group_by(COUNTRY) %>% filter(obsTime == max(obsTime))
quarts <- prod_sal %>% group_by(COUNTRY) %>%
  summarize(quart1 = quantile(salario_medio, 0.25),
            quart2 = quantile(salario_medio, 0.75)) %>%
  right_join(prod_sal)
# pdf("sparklines_ggplot.pdf", height=10, width=8)
ggplot(prod_sal, aes(x=obsTime, y=salario_medio)) +
  facet_grid(COUNTRY ~ ., scales = "free_y") +
  geom_ribbon(data = quarts, aes(ymin = quart1, max = quart2), fill = 'grey90') +
  geom_line(size=0.3) +
  geom_point(data = mins, col = 'red') +
  geom_point(data = maxs, col = 'blue') +
  geom_text(data = mins, aes(label = salario_medio), vjust = -1) +
  geom_text(data = maxs, aes(label = salario_medio), vjust = 2.5) +
  geom_text(data = ends, aes(label = salario_medio), hjust = 0, nudge_x = 1) +
  geom_text(data = ends, aes(label = COUNTRY), hjust = 0, nudge_x = 5) +
  expand_limits(x = max(prod_sal$obsTime) + (0.25 * (max(prod_sal$obsTime) - min(prod_sal$obsTime)))) +
  scale_x_continuous(breaks = seq(1992, 2017, 5)) +
  scale_y_continuous(expand = c(0.1, 0)) +
  theme_tufte(base_size = 15, base_family = "Helvetica") +
  theme(axis.title=element_blank(), axis.text.y = element_blank(),
        axis.ticks = element_blank(), strip.text = element_blank()) +
  labs(title = "Salario medio annuo",
       subtitle = "intera economia, PPPs 2017, 000 dollari, a prezzi costanti",
       caption = "elaborazione su dati OECD")
# dev.off()


