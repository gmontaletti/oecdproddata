---
title: "I dati OECD su salari e Pil"
author: "Giampaolo Montaletti"
date: "2/1/2019"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)
```

```{r dati, message=FALSE, warning=FALSE}
library(tidyverse)
library(ggthemes)
devtools::load_all()
```
## I dati OECD sulla produttività

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

## Including Plots

You can also embed plots, for example:

```{r pil_per_occupato, echo=FALSE, message=FALSE, warning=FALSE}
#  plot pil per occupato ####
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
```

```{r ora_lavorata, echo=FALSE, message=FALSE, warning=FALSE}
#  plot ora lavorata #####
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
```

```{r salario_medio, echo=FALSE, message=FALSE, warning=FALSE}
# plot salario medio #####
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
```

```{r produtt_prezzi, echo=FALSE, message=FALSE, warning=FALSE}
# plot produttività - salari ####
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
```

```{r salari_nel_tempo, echo=FALSE, message=FALSE, warning=FALSE}

# andamento salari nel tempo ####
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



```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
