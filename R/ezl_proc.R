library(tidyverse)

# Read raw csv files
raw_ezl_learners_grades <- read_csv("raw_EZL_learners_grades.csv")
raw_ezl_centres_grades <- read_csv("raw_EZL_centres_grades.csv")

# Extract list of EZL learners to delete
ezl_to_delete <- raw_ezl_learners_grades %>%
  filter(str_detect(str_to_lower(grade), "del"))

# Extract the list of grades for each centre
# Remove rows with Delete listed as a class name
ezl_learners_grades <- raw_ezl_learners_grades %>%
  filter(!str_detect(str_to_lower(grade), "del"))

# Write learners to delete to csv
ezl_to_delete %>%
  write.csv("ezl_learners_to_delete.csv", row.names = F, quote = F)

# Write learners and class enrollment to csv
ezl_learners_grades %>%
  write.csv("ezl_learners_grades.csv", row.names = F, quote = F)



