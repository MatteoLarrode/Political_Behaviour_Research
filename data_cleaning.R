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
# Keep variables of interest in waves 2, 3, 4
# Wave 2 only repeats Wave 1 so ignore for now

# Wave 2 - Variables of interest

w2 <- 
  wave2 |> 
  select