#### Preamble ####
# Purpose: Data simulation of Preference and Competence perception of action and inaction agents by gender. 
# Authors: Hari Lee Robledo, Sky Suh and Francesca Ye
# Date: 12 February 2024
# Pre-requisites: None

#### Work Space setup ####
library(tibble)
library(tidyverse)

#### Simulate Data set of Preference and Competence by Gender ####

set.seed(400)

simulated_pref_comp_data <-
  tibble(
  "Participant" = 1:460,
  "Preference" = sample(
    x = c(-5:5),
    size = 460,
    replace = TRUE
  ), 
  "Competence" = sample(
    x = c(-5:5),
    size = 460,
    replace = TRUE
  ), 
  "Gender" = sample(
    x = c(1:2),
    size = 460,
    replace = TRUE
  )
)
simulated_pref_comp_data

#### Test simulated data ####
# check that participants equal 460
length(unique(simulated_pref_comp_data$Participant)) == 460

# check that preference and competence scores are between -5 and 5
simulated_pref_comp_data$Preference |> min() == -5
simulated_pref_comp_data$Preference |> max() == 5

simulated_pref_comp_data$Competence |> min() == -5
simulated_pref_comp_data$Competence |> max() == 5

# check that the sum of the frequency count (participant counts) in the  graphs equals 205 for male and 255 for female. 
#Code referenced from: https://chat.openai.com/

# Extract data from the ggplot object
test_preference_male <- ggplot_build(preference_male)$data[[1]]
test_preference_female <- ggplot_build(preference_female)$data[[1]]

# Check if the sum of the frequency (participant count) in the male graphs equals 205
# Male
if (sum(test_preference_male$count) == 205) {
  print("The sum of male participant count in Preference graph equals 205.")
} else {
  print("The sum of male participant count in Preference graph does not equal 205.")
}

# Female
if (sum(test_preference_female$count) == 255) {
  print("The sum of female participant count in Preference graph equals 255.")
} else {
  print("The sum of female participant count in Preference graph does not equal 255.")
}

