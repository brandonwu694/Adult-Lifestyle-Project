# Overview of original dataset

Each row reports the estimated percentage of adults in a specific state and year who exhibit a particular behavioral indicator, optionally for a specific demographic group

| YearStart | LocationDesc | obesity | aerobic_activity_150 | muscle_strengthening_2plus | no_leisure_physical_activity |
|----------|--------------|--------|---------------------|-----------------------------|------------------------------|
| 2017 | Arizona | 29.5 | 48.2 | 30.1 | 24.8 |

For example: In 2017, 27.2% of adults in Arizona within a specific demographic subgroup (e.g., race, sex, income) exhibited less than 150 minutes of aerobic activity.

# Motivation 

## Original question 

**Which behavioral factors (e.g., physical activity, sedentary behavior, and nutrition) condition the posterior probability of obesity?**

## Refined question 

- Since the data set does not contain a feature/variable on sedentary behavior, the scope of the question had to be changed slightly. 

- Analysis focuses on the indicators present in the data set:

  - Physical activity
  
  - Muscle strengthening
  
  - Inactivity
  
  - Fruit consumption
  
  - Vegetable consumption

**Which behavioral indicators related to physical activity and nutrition are associated with obesity prevalence across U.S. states?**

# Structure of datasets

## `adult_obesity_behavior.csv`

- Original data set 

- 110,880 rows

- 33 columns

- Long format

## `obesity_behavior_wide.csv`

- Filtered rows that pertained to relevant questions

- Removed demographic breakdowns

- Converted to wide format

- Contains all data from 2011 - 2024, but nutrition values before 2017 are `NA`

## `obesity_behavior_activity_only.csv`

- Contains variables: obesity, aerobic activity, strength training, inactivity

- Converted to wide format

- No missing values present

## `obesity_behavior_full.csv`

- Contains variables related to both activity and nutrition

- Converted to wide format

- Time range is from 2017 - 2024
