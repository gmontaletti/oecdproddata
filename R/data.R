#' Dati OECD sui salari medi alla fine del periodo di osservazione.
#'
#' I dati sono generati dal file data-raw/elabora_dati_oecd.R che elabora file scaricati dai sistemi OECD con lo script data-raw/prod_oecd_download.R
#'
#' @format Un data frame con 6 righe e 4 variabili:
#' \describe{
#'   \item{COUNTRY}{il paese osservato}
#'   \item{obsTime}{il tempo dell'osservazione}
#'   \item{salario_medio}{il salario medio}
#'   \item{pil_ora}{il pil per ora lavorata}
#' }
"ends"
#' Data from Experiment 1
#'
#' This is data from the first experiment ever to try XYZ using Mechanical
#' Turk workers.
#'
#' @format A data frame with NNNN rows and NN variables:
#' \describe{
#'   \item{subject}{Anonymized Mechanical Turk Worker ID}
#'   \item{trial}{Trial number, from 1..NNN}
#'   ...
#' }
#'
"maxs"
