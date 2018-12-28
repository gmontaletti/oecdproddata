# 02_elabora_dati_oecd.R ##########
#
# Elaborazione dei dati OECD sulla produttività
# File 02_elabora_dati_oecd.R
#
# carica i dati salvati e produce i grafici sulla produttività
# in 6 paesi fa i quali l'Italia
###

# librerie richieste #####
library(tidyverse)
library(ggthemes)

# carica i dati ######
# carica i dati salvati in precedenza

# produttività
load(file = "data/produttivita.RData")

# salari
load(file = "data/salari.RData")

#  prduttività multifattore (non usato)
load(file = "data/mfp.RData")

# ULC_EEQ Unit labour costs and labour productivity (employment based), Total economy
load(file = "data/ulc.RData")

# elaborazioni ####
# fig. pil per occupato #####

# selezione numero indice trimestrale destagionalizzato del pil per occupato
ulc_gdp <- ulc %>%  filter(SUBJECT == "ULQELP01",
                           MEASURE =="IXOBSA",
                           LOCATION %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA"))

# limita la serie dal primo trimestre 1991
ulc_gdp_s <- ulc_gdp %>%
  mutate(pil_nr_indice = obsValue) %>%
  filter(obsTime >= "1991-Q1") %>%
  select(LOCATION, obsTime, pil_nr_indice)

# genera grafico del pil per occupato
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

# fig. pil per ora lavorata ####
# seleziona i dati del Pil per ora lavorata
ora_lavorata <- productivity %>%
  filter(SUBJECT == "T_GDPHRS", MEASURE == "VPVOB" ,
                                LOCATION %in% c("ITA", "FRA", "DEU", "GBR", "JPN", "USA")) %>%
  mutate(obsTime = as.numeric(obsTime)) %>%
  mutate(pil_ora = obsValue) %>%
  select(LOCATION, obsTime, pil_ora) %>%
  filter(obsTime >= 1992)

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

# fig. salari #####
# seleziona salario medio annuo in ppps in miglia di dollari a prezzi costanti
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

#  fig. prod-salario ####
# unisce salario medio e pil per ora lavorata
# limita la serie dal 1992
prod_sal <- salario_medio %>%
  left_join(ora_lavorata, by = c("COUNTRY" = "LOCATION", "obsTime" = "obsTime")) %>%
  filter(obsTime >= 1992)

# trova il valore massimo del salario medio nella serie storica
maxs <- group_by(prod_sal, COUNTRY) %>% slice(which.max(salario_medio))
mins <- group_by(prod_sal, COUNTRY) %>% slice(which.min(salario_medio))

ggplot(prod_sal, aes(x = pil_ora, y = salario_medio, group = COUNTRY, color = COUNTRY)) +
  geom_point(size = 0.9, show.legend = T) +
  geom_smooth(se = F, show.legend = FALSE, method  = "lm") +
  geom_point(data = maxs, col = 'black', size = 2) +
  geom_text(data = maxs, aes(label = obsTime), vjust = -0.39, show.legend = FALSE) +
  theme_minimal() +
  scale_y_continuous("Salario medio annuo") +
  scale_x_continuous("Pil per ora lavorata") +
  labs(title = "Crescita del Pil per ora lavorata e salario medio annuo",
       subtitle = "intera economia, PPPs 2017, in dollari, a prezzi costanti",
       caption = "elaborazione su dati OECD") +
  scale_color_brewer(palette = "Dark2", name=" ")


# fig. salari serie storica ####
# grafico serie storiche impilate

mins <- prod_sal %>% group_by(COUNTRY) %>% slice(which.min(salario_medio))
maxs <- prod_sal %>% group_by(COUNTRY) %>% slice(which.max(salario_medio))
ends <- prod_sal %>% group_by(COUNTRY) %>% filter(obsTime == max(obsTime))
quarts <- prod_sal %>% group_by(COUNTRY) %>%
  summarize(quart1 = quantile(salario_medio, 0.25),
            quart2 = quantile(salario_medio, 0.75)) %>%
  right_join(prod_sal)

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


