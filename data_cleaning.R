# ---- Setup ----
library(tidyverse)
library(purrr)

# Load data
folder_path <- "data/"
csv_files <- list.files(path = folder_path, pattern = "\\.csv$", full.names = TRUE)

for (file in csv_files) {
  file_name <- tools::file_path_sans_ext(basename(file))
  file_df <- read_csv(file)
  assign(file_name, file_df)
  rm(file_df)
}

# ---- Aggregation of waves ----
# Wave 1 - Variables of interest
# ID: UID_fes1
# Personal duty to fight climate change: fes1_EE22_Q13B
# Redistribution: fes1_EE22_Q14_1
# Immigration as cultural enriching: fes1_EE22_Q14_2
# Reducing public sector: fes1_EE22_Q14_3
# Islam as threat for French identity: fes1_EE22_Q14_5
# Age (decade): cal_AGE
# Diploma: cal_DIPL
# Sex: cal_SEXE
# Interest in politics: eayy_i1

w1 <-
  wave1 |>
  select(
    id = UID_fes1,
    personal_duty_climate_change = fes1_EE22_Q13B,
    redistribution = fes1_EE22_Q14_1,
    immigration_as_cultural_enriching = fes1_EE22_Q14_2,
    reduce_public_sector = fes1_EE22_Q14_3,
    islam_as_threat_for_french_identity = fes1_EE22_Q14_5,
    age_decade = cal_AGE,
    diploma = cal_DIPL,
    sex = cal_SEXE,
    interest_in_politics1 = eayy_i1
  ) |> 
  mutate(
    W1 = TRUE
  )

# Wave 3 - Variables of interest
# ID: UID_fes3
# Group sentiment - France Insoumise: fes3_QA07_A
# Group sentiment - Europe Écologie Les Verts: fes3_QA07_B
# Group sentiment - Parti socialiste: fes3_QA07_C
# Group sentiment - La République en marche: fes3_QA07_D
# Group sentiment - les Républicains: fes3_QA07_E
# Group sentiment - Rassemblement national: fes3_QA07_F
# Group sentiment - Reconquête: fes3_QA07_G
# Group sentiment - For people who do not vote: fes3_QA07_H
# EU power: fes3_QA08_A
# EU integration: fes3_QA08_B
# Age (decade): cal_AGE
# Diploma: cal_DIPL
# Sex: cal_SEXE

w3 <-
  wave3 |>
  select(
    id = UID_fes3,
    group_sentiment_LFI = fes3_QA07_A,
    group_sentiment_EELV = fes3_QA07_B,
    group_sentiment_PS = fes3_QA07_C,
    group_sentiment_LREM = fes3_QA07_D,
    group_sentiment_LR = fes3_QA07_E,
    group_sentiment_RN = fes3_QA07_F,
    group_sentiment_Reconquete = fes3_QA07_G,
    group_sentiment_NoVote = fes3_QA07_H,
    eu_power = fes3_QA08_A,
    eu_integration = fes3_QA08_B,
    age_decade = cal_AGE,
    diploma = cal_DIPL,
    sex = cal_SEXE,
    interest_in_politics3 = eayy_i1
  ) |> 
  mutate(
    W3 = TRUE
  )

# Wave 4 - Variables of interest
# ID: UID_fes4
# Interest in politics: fes4_Q01
# Left-right - France Insoumise: fes4_Q18b
# Left-right - Europe Écologie Les Verts: fes4_Q18a
# Left-right - Parti socialiste: fes4_Q18f
# Left-right - La République en marche: fes4_Q18c
# Left-right - les Républicains: fes4_Q18d
# Left-right - Rassemblement national: fes4_Q18g
# Left-right - Reconquête: fes4_Q18h
# Left-right - MoDem: fes4_Q18e
# Left-right - Self: fes4_Q19
# Party sympathy - France Insoumise: fes4_Q16b
# Party sympathy - Europe Écologie Les Verts: fes4_Q16a
# Party sympathy - Parti socialiste: fes4_Q16f
# Party sympathy - La République en marche: fes4_Q16c
# Party sympathy - les Républicains: fes4_Q16d
# Party sympathy - Rassemblement national: fes4_Q16g
# Party sympathy - Reconquête: fes4_Q16h
# Party sympathy - MoDem: fes4_Q16e
# Party identification - Close to party (binary): fes4_Q23a
# Party identification - Less far from party (binary): fes4_Q23b
# Party identification - Which party, if any: fes4_Q23c
# Party identification - Strength: fes4_Q23d
# Age (decade): cal_AGE
# Diploma: cal_DIPL
# Sex: cal_SEXE
w4 <- wave4 |> 
  select(
    id = UID_fes4,
    left_right_LFI = fes4_Q18b,
    left_right_EELV = fes4_Q18a,
    left_right_PS = fes4_Q18f,
    left_right_LREM = fes4_Q18c,
    left_right_LR = fes4_Q18d,
    left_right_RN = fes4_Q18g,
    left_right_Reconquete = fes4_Q18h,
    left_right_MoDem = fes4_Q18e,
    left_right_self = fes4_Q19,
    party_sympathy_LFI = fes4_Q16b,
    party_sympathy_EELV = fes4_Q16a,
    party_sympathy_PS = fes4_Q16f,
    party_sympathy_LREM = fes4_Q16c,
    party_sympathy_LR = fes4_Q16d,
    party_sympathy_RN = fes4_Q16g,
    party_sympathy_Reconquete = fes4_Q16h,
    party_sympathy_MoDem = fes4_Q16e,
    party_identification_1 = fes4_Q23a,
    party_identification_2 = fes4_Q23b,
    party_identification_which = fes4_Q23c,
    party_identification_strength = fes4_Q23d,
    age_decade = cal_AGE,
    diploma = cal_DIPL,
    sex = cal_SEXE,
    interest_in_politics4 = fes4_Q01,
  ) |> 
  mutate(
    W4 = TRUE
  )

# Left join: keep respondents who have responded to issue position q's (w1 & w2)
aggreg_waves <-
  w1 |>
  full_join(w3) |>
  full_join(w4) |>
  mutate_all(~ ifelse(. %in% c(6666, 9999, 9996), NA, .)) |>
  # interest in politics varies: by default use wave 4 b/c in questionnaire
  # otherwise, use latest wave available
  mutate(
    interest_politics = case_when(
      between(interest_in_politics4, 1, 4) ~ interest_in_politics4,
      between(interest_in_politics3, 1, 4) ~ interest_in_politics3,
      between(interest_in_politics1, 1, 4) ~ interest_in_politics1,
      TRUE ~ NA
    )
  ) |>
  select(
    -interest_in_politics1, -interest_in_politics3, -interest_in_politics4
  )

rm(wave1, wave2, wave3, wave4)

# ---- Recode variables ----
# Rescaling of Likert scales: 0-10 to 1-4
rescale_0_10to1_4 <- function(x) {
  x / 10 * 3 + 1
}

aggreg_waves_recoded <-
  aggreg_waves |>
  mutate_all(~ ifelse(. %in% c(6666, 9999, 9996, 96), NA, .)) |>
  relocate(age_decade, diploma, sex, .after = id) |>
  
  # demographic controls
  mutate(
    diploma = (5 - diploma), # higher = higher education
    sex = factor(case_match(
      sex,
      1 ~ "Male",
      2 ~ "Female",
      .default = NA
    ))
  ) |>
  
  # ideological indicators
  mutate(
    # very skewed so binary (neutral/negative vs. positive)
    environment = factor(ifelse(between(personal_duty_climate_change, 0, 6), 0, 1)),
    # 1-4 Likert scales (higher = more ideologically right)
    socioeco = (redistribution + (5 - reduce_public_sector)) / 2,
    immigration = (immigration_as_cultural_enriching + (5 - islam_as_threat_for_french_identity)) / 2,
    EU = 5 - ((rescale_0_10to1_4(eu_power) + rescale_0_10to1_4(eu_integration)) / 2)
  ) |>
  select(
    -personal_duty_climate_change, -redistribution,
    -reduce_public_sector, -immigration_as_cultural_enriching,
    -islam_as_threat_for_french_identity, -eu_power,
    -eu_integration
  ) |>
  
  # party identification
  mutate(
    PID = relevel(
      factor(case_when(
        party_identification_2 == 5 ~ "None",
        party_identification_which == 1 ~ "LO",
        party_identification_which == 2 ~ "NPA",
        party_identification_which == 3 ~ "PCF",
        party_identification_which == 4 ~ "LFI",
        party_identification_which == 5 ~ "PS",
        party_identification_which == 6 ~ "EELV",
        party_identification_which == 7 ~ "LREM",
        party_identification_which == 8 ~ "MoDem",
        party_identification_which == 9 ~ "LR",
        party_identification_which == 10 ~ "DLF",
        party_identification_which == 11 ~ "RN",
        party_identification_which == 12 ~ "Reconquete",
        party_identification_which == 13 ~ "Other",
        TRUE ~ NA)
        ),
      ref = "None"
    ),
    # 0-4: higher = higher PID strength 
    PID_strength = ifelse(PID == "None", 0, 5 - party_identification_strength)
  ) |>
  select(
    -party_identification_1, -party_identification_2, 
    -party_identification_which, -party_identification_strength
  ) |> 
  
  # in-group & in-party sympathy
  mutate(
    in_group_sympathy = case_when(
      PID == "LFI" ~ group_sentiment_LFI,
      PID == "EELV" ~ group_sentiment_EELV,
      PID == "PS" ~ group_sentiment_PS,
      PID == "LREM" ~ group_sentiment_LREM,
      PID == "LR" ~ group_sentiment_LR,
      PID == "RN" ~ group_sentiment_RN,
      PID == "Reconquete" ~ group_sentiment_Reconquete,
      TRUE ~ NA),
    in_party_sympathy = case_when(
      PID == "LFI" ~ party_sympathy_LFI,
      PID == "EELV" ~ party_sympathy_EELV,
      PID == "PS" ~ party_sympathy_PS,
      PID == "LREM" ~ party_sympathy_LREM,
      PID == "LR" ~ party_sympathy_LR,
      PID == "RN" ~ party_sympathy_RN,
      PID == "Reconquete" ~ party_sympathy_Reconquete,
      PID == "MoDem" ~ party_sympathy_MoDem,
      TRUE ~ NA),
    ) |> 
  
  # interest in politics: 0-3: higher = higher interest
  mutate(
    interest_politics = 4 - interest_politics
  )

save(aggreg_waves_recoded, file = "data/recoded_data.RData")
