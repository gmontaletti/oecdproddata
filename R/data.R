#' Dati OECD sui salari medi annui alla fine del periodo di osservazione 1992-2017.
#'
#' I dati sono generati dal file data-raw/elabora_dati_oecd.R che elabora file scaricati dai sistemi OECD con lo script data-raw/prod_oecd_download.R
#' I dati si riferiscono a Italia (ITA), Francia (FRA), Giappone (JPN), Germania (DEU), Gran Bretagna (GBR) e Stati Uniti.
#' Il dato è annuale ed è stato elaborato per il periodo 1992-2017.
#'
#' @format Un data frame con 6 righe e 4 variabili:
#' \describe{
#'   \item{COUNTRY}{il paese osservato}
#'   \item{obsTime}{il tempo dell'osservazione}
#'   \item{salario_medio}{il salario medio}
#'   \item{pil_ora}{il pil per ora lavorata}
#' }
"ends"
#' Dati OECD sull'anno in cui si è rilevato il massimo del salario durante il periodo di osservazione 1992-2017.
#'
#' I dati sono generati dal file data-raw/elabora_dati_oecd.R che elabora file scaricati dai sistemi OECD con lo script data-raw/prod_oecd_download.R
#' I dati si riferiscono a Italia (ITA), Francia (FRA), Giappone (JPN), Germania (DEU), Gran Bretagna (GBR) e Stati Uniti.
#' Il dato è annuale ed è stato elaborato per il periodo 1992-2017.
#'
#' @format Un data frame con 6 righe e 4 variabili:
#' \describe{
#'   \item{COUNTRY}{il paese osservato}
#'   \item{obsTime}{l'anno in cui il salario medio ha toccato il massimo in qual paese}
#'   \item{salario_medio}{il salario medio}
#'   \item{pil_ora}{il pil per ora lavorata}
#' }
"maxs"
#' Dati OECD sull'anno in cui si è rilevato il minimo del salario medio annuo durante il periodo di osservazione 1992-2017.
#'
#' I dati sono generati dal file data-raw/elabora_dati_oecd.R che elabora file scaricati dai sistemi OECD con lo script data-raw/prod_oecd_download.R
#' I dati si riferiscono a Italia (ITA), Francia (FRA), Giappone (JPN), Germania (DEU), Gran Bretagna (GBR) e Stati Uniti.
#' Il dato è annuale ed è stato elaborato per il periodo 1992-2017.
#'
#' @format Un data frame con 6 righe e 4 variabili:
#' \describe{
#'   \item{COUNTRY}{il paese osservato}
#'   \item{obsTime}{l'anno in cui il salario medio ha toccato il minimo in quel paese}
#'   \item{salario_medio}{il salario medio}
#'   \item{pil_ora}{il pil per ora lavorata}
#' }
"mins"
#' Dati OECD sui quartili temporali del salario durante il periodo di osservazione 1992-2017.
#'
#' I dati sono generati dal file data-raw/elabora_dati_oecd.R che elabora file scaricati dai sistemi OECD con lo script data-raw/prod_oecd_download.R
#' I dati si riferiscono a Italia (ITA), Francia (FRA), Giappone (JPN), Germania (DEU), Gran Bretagna (GBR) e Stati Uniti.
#' Il dato è annuale ed è stato elaborato per il periodo 1992-2017.
#'
#' @format Un data frame con 156 righe e 6 variabili:
#' \describe{
#'   \item{COUNTRY}{il paese osservato}
#'   \item{quart1}{il primo quartile della distribuzione temporale}
#'   \item{quart2}{il terzo quartile della distribuzione temporale}
#'   \item{obsTime}{il tempo dell'osservazione}
#'   \item{salario_medio}{l'anno in cui il salario medio ha toccato il minimo in quel paese}
#'   \item{pil_ora}{il pil per ora lavorata}
#' }
"quarts"
#' Dati OECD sui salari medi annui durante il periodo di osservazione 1992-2017.
#'
#' I dati sono generati dal file data-raw/elabora_dati_oecd.R che elabora file scaricati dai sistemi OECD con lo script data-raw/prod_oecd_download.R
#' I dati si riferiscono a Italia (ITA), Francia (FRA), Giappone (JPN), Germania (DEU), Gran Bretagna (GBR) e Stati Uniti.
#' Il dato è annuale ed è stato elaborato per il periodo 1992-2017.
#'
#' @format Un data frame con 156 righe e 3 variabili:
#' \describe{
#'   \item{COUNTRY}{il paese osservato}
#'   \item{obsTime}{il tempo dell'osservazione}
#'   \item{salario_medio}{il salario medio per quel paese e quel periodo, in dollari a prezzi costanti e PPPs 2017}
#' }
"salario_medio"
#' Dati OECD sul PIL per ora lavorata durante il periodo di osservazione 1992-2017.
#'
#' Si tratta di una misura lorda di produttività del lavoro. I dati sono generati dal file data-raw/elabora_dati_oecd.R che elabora file scaricati dai sistemi OECD con lo script data-raw/prod_oecd_download.R
#' I dati si riferiscono a Italia (ITA), Francia (FRA), Giappone (JPN), Germania (DEU), Gran Bretagna (GBR) e Stati Uniti.
#' Il dato è annuale ed è stato elaborato per il periodo 1992-2017.
#' Per questa variabile non sono disponibili i dati 2017 per Giappone e USA.
#'
#'
#' @format Un data frame con 154 righe e 3 variabili:
#' \describe{
#'   \item{LOCATION}{il paese osservato}
#'   \item{obsTime}{il tempo dell'osservazione}
#'   \item{pil_ora}{il PIL prodotto per ora di lavoro, in dollari a prezzi costanti e PPPs 2010}
#' }
"ora_lavorata"
#' Dati OECD sul PIL per ora lavorata e salario medio durante il periodo di osservazione 1992-2017.
#'
#' Tabella che pone a confronto le due quantità. I dati sono generati dal file data-raw/elabora_dati_oecd.R che elabora file scaricati dai sistemi OECD con lo script data-raw/prod_oecd_download.R
#' I dati si riferiscono a Italia (ITA), Francia (FRA), Giappone (JPN), Germania (DEU), Gran Bretagna (GBR) e Stati Uniti.
#' Il dato è annuale ed è stato elaborato per il periodo 1992-2017.
#'
#'
#' @format Un data frame con 155 righe e 4 variabili:
#' \describe{
#'   \item{COUNTRY}{il paese osservato}
#'   \item{obsTime}{il tempo dell'osservazione}
#'   \item{salario_medio}{il salario medio per quel paese e quel periodo, in dollari a prezzi costanti e PPPs 2017}
#'   \item{pil_ora}{il PIL prodotto per ora di lavoro, in dollari a prezzi costanti e PPPs 2010}
#' }
"prod_sal"
#' Dati OECD sul PIL per occupato durante il periodo di osservazione 1992-2018.
#'
#' Si tratta di una misura lorda di produttività del lavoro. I dati sono trimestrali e generati dal file data-raw/elabora_dati_oecd.R che elabora file scaricati dai sistemi OECD con lo script data-raw/prod_oecd_download.R
#' I dati si riferiscono a Italia (ITA), Francia (FRA), Giappone (JPN), Germania (DEU), Gran Bretagna (GBR) e Stati Uniti.
#' il dato è trimestrale ed è stato elaborato per il periodo dal 1991-Q1 al 2018-Q3.
#'
#' @format Un data frame con 666 righe e 3 variabili:
#' \describe{
#'   \item{LOCATION}{il paese osservato}
#'   \item{obsTime}{il tempo dell'osservazione, in questo caso trimestrale}
#'   \item{pil_nr_indice}{numero indice del PIL prodotto occupato, numero indice, media 2015 = 100}
#' }
"ulc_gdp_s"
