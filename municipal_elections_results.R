# Data Collection of 2020 Municipal Elections 
# Source: data.gouv.fr (https://www.data.gouv.fr/fr/pages/donnees-des-elections/)
library(tidyverse)
library(readxl)
library(httr2)

# 1st round
# Source: https://www.data.gouv.fr/fr/datasets/elections-municipales-2020-resultats-1er-tour/
download <- tempfile(fileext = ".xlsx")

request("https://www.data.gouv.fr/fr/datasets/r/1f67d380-6810-4f93-a952-80ee18c50d78") |>
  req_perform(download)

raw_round1 <-
  read_excel(
    download
  )

# 2nd round
# Source: https://www.data.gouv.fr/fr/datasets/municipales-2020-resultats-2nd-tour/
download2 <- tempfile(fileext = ".xlsx")

request("https://www.data.gouv.fr/fr/datasets/r/a812e7c7-42bb-4120-b747-f4f7260f688d") |>
  req_perform(download2)

raw_round2 <-
  read_excel(
    download2
  )
