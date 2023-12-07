# ---- Setup ----
library(tidyverse)

# Load data
folder_path <- "data/"
csv_files <- list.files(path = folder_path, pattern = "\\.csv$", full.names = TRUE)

for (file in csv_files){
  file_name <- tools::file_path_sans_ext(basename(file))
  file_df <- read_csv(file)
  assign(file_name, file_df)
  rm(file_df)
}

# ---- Aggregation of waves ----
# Wave 1 - Variables of interest
# ID: UID_fes1
# State of democracy: fes1_EE22_Q06
# Personal duty to fight climate change: fes1_EE22_Q13B
# Redistribution: fes1_EE22_Q14_1
# Immigraition as cultural enriching: fes1_EE22_Q14_2
# Death penalty: fes1_EE22_Q14_4
# Islam as threat for French identity: fes1_EE22_Q14_5
# Age (decade): cal_AGE
# Diploma: cal_DIPL
# Sex: cal_SEXE

w1 <- 
  wave1 |> 
  select(
    id = UID_fes1,
    state_of_democracy = fes1_EE22_Q06,
    personal_duty_to_fight_climate_change = fes1_EE22_Q13B,
    redistribution = fes1_EE22_Q14_1,
    immigration_as_cultural_enriching = fes1_EE22_Q14_2,
    death_penalty = fes1_EE22_Q14_4,
    islam_as_threat_for_french_identity = fes1_EE22_Q14_5,
    age_decade = cal_AGE,
    diploma = cal_DIPL,
    sex = cal_SEXE
  )

# Wave 2 - Variables of interest
# ID: UID_fes2
# Secularism threatened: fes2_EE22_Q08_7
# State of democracy: fes2_EE22_Q06
# Support anti-health pass movement: fes2_EE22_Q16
# Replacement of population by immigrants: fes2_EE22_Q17
# Age (decade): cal_AGE
# Diploma: cal_DIPL
# Sex: cal_SEXE
# Interest in politics: eayy_i1
# Self positioning - left-right scale: eayy_i8

w2 <- 
  wave2 |> 
  select(
    id = UID_fes2,
    secularism_threatened = fes2_EE22_Q08_7,
    state_of_democracy2 = fes2_EE22_Q06,
    support_anti_health_pass_movement = fes2_EE22_Q16,
    replacement_of_population_by_immigrants = fes2_EE22_Q17,
    age_decade2 = cal_AGE,
    diploma2 = cal_DIPL,
    sex2 = cal_SEXE,
    interest_in_politics = eayy_i1,
    self_positioning_left_right = eayy_i8
  )

# Wave 3 - Variables of interest
# ID: UID_fes3
# Group sentiment - France Insoumise: fes3_QA07_A
# Group sentiment - Europe Écologie Les Verts: fes3_QA07_B
# Group sentiment - Parti socialiste: fes3_QA07_C
# Group sentiment -  La République en marche: fes3_QA07_D
# Group sentiment - les Républicains: fes3_QA07_E
# Group sentiment - Rassemblement national: fes3_QA07_F
# Group sentiment - Reconquête: fes3_QA07_G
# EU integration: fes3_QA08_B
# Age (decade): cal_AGE
# Diploma: cal_DIPL
# Sex: cal_SEXE

w3 <- 
  wave3 |> 
  select(
    id = UID_fes3,
    group_sentiment_france_insoumise = fes3_QA07_A,
    group_sentiment_europe_ecologie_les_verts = fes3_QA07_B,
    group_sentiment_parti_socialiste = fes3_QA07_C,
    group_sentiment_la_republique_en_marche = fes3_QA07_D,
    group_sentiment_les_republicains = fes3_QA07_E,
    group_sentiment_rassemblement_national = fes3_QA07_F,
    group_sentiment_reconquete = fes3_QA07_G,
    eu_integration = fes3_QA08_B,
    age_decade3 = cal_AGE,
    diploma3 = cal_DIPL,
    sex3 = cal_SEXE
  )

# Wave 4 - Variables of interest
# ID: UID_fes4
# Interest in politics: fes4_Q01
#


# Age (decade): cal_AGE
# Diploma: cal_DIPL
# Sex: cal_SEXE





aggreg_waves <- 
  w1 |> 
  full_join(w2) |> 
  full_join(w3)
