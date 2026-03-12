library(tidyverse)

df <- read_csv("data/raw/adult_obesity_behavior.csv")

# Specify what survey questions that will remain for analysis
# Correspond to entries in the original data set's 'Question' column
vars_keep <- c(
  "Percent of adults aged 18 years and older who have obesity",
  "Percent of adults who engage in no leisure-time physical activity",
  "Percent of adults who report consuming fruit less than one time daily",
  "Percent of adults who report consuming vegetables less than one time daily",
  "Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)",
  "Percent of adults who engage in muscle-strengthening activities on 2 or more days a week"
)

df_model <- df %>%
  filter(
    Question %in% vars_keep, # Retain questions only specific to behavioral indicators
    Total == "Total",
    !is.na(Data_Value)
  ) %>%
  select(YearStart, LocationAbbr, LocationDesc, Question, Data_Value) %>% # Select relevant columns for analysis
  distinct()

# Convert to wide format so each indicator becomes its own column
df_wide <- df_model %>%
  pivot_wider(
    names_from = Question,
    values_from = Data_Value
  ) %>%
  rename( # Rename columns to more concise names
    obesity = `Percent of adults aged 18 years and older who have obesity`,
    no_leisure_physical_activity = `Percent of adults who engage in no leisure-time physical activity`,
    low_fruit_consumption = `Percent of adults who report consuming fruit less than one time daily`,
    low_vegetable_consumption = `Percent of adults who report consuming vegetables less than one time daily`,
    aerobic_activity_150 = `Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)`,
    muscle_strengthening_2plus = `Percent of adults who engage in muscle-strengthening activities on 2 or more days a week`
  )

# Check if reshaping step worked correctly
glimpse(df_wide)
# Check for duplicate state-year rows
df_wide %>% count(YearStart, LocationDesc)

# In the initial data set, `low_fruit_consumption` and `low_vegetable_consumption` contained many NA values
# Check what year the fruit and vegetable consumption started being reported
df_wide %>%
  summarise(
    min_year_fruit = min(YearStart[!is.na(low_fruit_consumption)]),
    min_year_veg = min(YearStart[!is.na(low_vegetable_consumption)])
  )

# Create data frame containing physical activity-related indicators
df_activity <- df_wide %>%
  select(
    YearStart, LocationAbbr, LocationDesc,
    obesity,
    aerobic_activity_150,
    muscle_strengthening_2plus,
    no_leisure_physical_activity
  ) %>%
  drop_na()

# Create data frame containing activity + nutrition indicators
df_full <- df_wide %>%
  select(
    YearStart, LocationAbbr, LocationDesc,
    obesity,
    aerobic_activity_150,
    muscle_strengthening_2plus,
    no_leisure_physical_activity,
    low_fruit_consumption,
    low_vegetable_consumption
  ) %>%
  drop_na()

# Master data set that contains all data (including NA values) in wide format
write_csv(df_wide, "data/cleaned/obesity_behavior_wide.csv")

# Data set that contains only activity-related indicators
write_csv(df_activity, "data/cleaned/obesity_behavior_activity_only.csv")

# Data set that contains both activity and nutrition variables
# Due to a high volume of NA values, this data set only contains data from 2017 - 2024
write_csv(df_full, "data/cleaned/obesity_behavior_full.csv")
