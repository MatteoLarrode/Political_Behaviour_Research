# 2020 Municipal Elections (1000+ inhabitants)
library(tidyverse)
library(readxl)
library(httr2)
library(data.table)

# Collection ----
# Source: data.gouv.fr (https://www.data.gouv.fr/fr/pages/donnees-des-elections/)

# 1st round
# Source: https://www.data.gouv.fr/fr/datasets/elections-municipales-2020-resultats-1er-tour/
download <- tempfile(fileext = ".xlsx")

request("https://www.data.gouv.fr/fr/datasets/r/8016ae91-bc47-4997-a3b5-d3515392a75b") |>
  req_perform(download)

raw_round1 <-
  read_excel(
    download
  )

# 2nd round
# Source: https://www.data.gouv.fr/fr/datasets/municipales-2020-resultats-2nd-tour/
# Less rows because no round 2 in case of absolute majority
download2 <- tempfile(fileext = ".xlsx")

request("https://www.data.gouv.fr/fr/datasets/r/aa5766de-f869-4f44-a4cf-49649ed5389e") |>
  req_perform(download2)

raw_round2 <-
  read_excel(
    download2
  )

# Wrangling ----
# Round 1
num_candidates <-
  (length(grep("^...\\d+$", names(raw_round1), value = TRUE)) / 12) + 1

base_column_names <- c(
  "num", "nuance_code", "sex", "name", "firstname", "list",
  "Sièges / Elu", "Sièges Secteur", "Sièges CC", "votes",
  "perc_registered_voters", "perc_valid_votes"
)

new_column_names <- paste0(
  rep(paste0("Candidate", 1:num_candidates), each = length(base_column_names)), "_",
  rep(base_column_names, times = num_candidates)
)

results_round1 <- raw_round1 |>
  setnames(19:length(colnames(raw_round1)), new_column_names) |>
  select(
    -Abstentions, -Votants, 
    -`% Abs/Ins`, -Blancs, 
    -`% Blancs/Ins`, -Nuls, 
    -`% Nuls/Ins`, -Exprimés,
    -`% Exp/Ins`, -`% Exp/Vot`
  ) |>
  rename(
    dpt_code = `Code du département`,
    dpt_name = `Libellé du département`,
    city_code = `Code de la commune`,
    city_name = `Libellé de la commune`,
    registered_total = Inscrits,
    voted_perc = `% Vot/Ins`,
    blank_vote_perc = `% Blancs/Vot`,
    invalid_vote_perc = `% Nuls/Vot`
  )
