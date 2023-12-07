# ---- Setup ----
library(tidyverse)

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
    interest_in_politics2 = eayy_i1,
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
    group_sentiment_FI = fes3_QA07_A,
    group_sentiment_EELV = fes3_QA07_B,
    group_sentiment_PS = fes3_QA07_C,
    group_sentiment_LREM = fes3_QA07_D,
    group_sentiment_LR = fes3_QA07_E,
    group_sentiment_RN = fes3_QA07_F,
    group_sentiment_reconquete = fes3_QA07_G,
    eu_integration = fes3_QA08_B,
    age_decade3 = cal_AGE,
    diploma3 = cal_DIPL,
    sex3 = cal_SEXE
  )

# Wave 4 - Variables of interest
# ID: UID_fes4
# Interest in politics: fes4_Q01
# Trust - Parliament: fes4_Q07a
# Trust - Government: fes4_Q07b
# Trust - Scientists: fes4_Q07d
# Trust - Political Parties: fes4_Q07e
# Trust - Traditional media: fes4_Q07f
# Trust - Social networks: fes4_Q07g
# Vote - First round presidential election: fes4_Q10p1.b
# Vote Intention - First round legislative elections:  fes4_Q10lh1.c
# Party sympathy - France Insoumise: fes4_Q16b
# Party sympathy - Europe Écologie Les Verts: fes4_Q16a
# Party sympathy - Parti socialiste: fes4_Q16f
# Party sympathy -  La République en marche: fes4_Q16c
# Party sympathy - les Républicains: fes4_Q16d
# Party sympathy - Rassemblement national: fes4_Q16g
# Party sympathy - Reconquête: fes4_Q16h
# Party sympathy - MoDem: fes4_Q16e
# Party identification - Which party, if any: fes4_Q23c
# Party identification - Strength: fes4_Q23d
# Age (decade): cal_AGE
# Diploma: cal_DIPL
# Sex: cal_SEXE
w4 <- wave4 %>%
  select(
    id = UID_fes4,
    interest_in_politics4 = fes4_Q01,
    trust_parliament = fes4_Q07a,
    trust_government = fes4_Q07b,
    trust_scientists = fes4_Q07d,
    trust_political_parties = fes4_Q07e,
    trust_traditional_media = fes4_Q07f,
    trust_social_networks = fes4_Q07g,
    vote_r1_pres_election = fes4_Q10p1.b,
    vote_intention_legislative = fes4_Q10lh1.c,
    party_sympathy_FI = fes4_Q16b,
    party_sympathy_EELV = fes4_Q16a,
    party_sympathy_PS = fes4_Q16f,
    party_sympathy_LREM = fes4_Q16c,
    party_sympathy_LR = fes4_Q16d,
    party_sympathy_RN = fes4_Q16g,
    party_sympathy_reconquete = fes4_Q16h,
    party_sympathy_modem = fes4_Q16e,
    party_identification_which = fes4_Q23c,
    party_identification_strength = fes4_Q23d,
    age_decade4 = cal_AGE,
    diploma4 = cal_DIPL,
    sex4 = cal_SEXE
  )



aggreg_waves <-
  w1 |>
  full_join(w2) |>
  full_join(w3) |>
  full_join(w4)
