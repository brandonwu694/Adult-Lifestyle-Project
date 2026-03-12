library(tidyverse)

df <- read_csv("data/raw/adult_obesity_behavior.csv")

# Identify column names and gauge general structure of dataset
glimpse(df)
names(df)
summary(df)

# Checking for missing values
colSums(is.na(df))

# Check what behavioral variables exist
unique(df$Question)

# Filter obesity rows
obesity <- df %>%
  filter(str_detect(Question, "obesity"))

unique(obesity$Question)

# Identify behavioral predictors
df %>%
  filter(str_detect(Question, "physical")) # Physical activity

df %>%
  filter(str_detect(Question, "television|screen|sedentary")) # Sedentary behavior

df %>%
  filter(str_detect(Question, "fruit|vegetable")) # Nutrition
