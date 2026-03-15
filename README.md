# Project Title

This repository analyzes the relationship between adult lifestyle behaviors and obesity prevalence in the United States using survey data. The project includes data cleaning, exploratory analysis, and Bayesian regression modeling.

## Dataset Overview

The dataset used in this project is the Nutrition, Physical Activity, and Obesity – Behavioral Risk Factor Surveillance System dataset from the U.S. Department of Health & Human Services.

It contains state-level estimates derived from the Behavioral Risk Factor Surveillance System (BRFSS), a large national health survey of U.S. adults. Observations represent aggregated percentages for demographic groups (e.g., the percentage of males in Arizona who consume fruit less than once per day).

The dataset is provided in a long survey-style format and includes variables for location, year, demographic stratifications, behavioral indicators, and estimated prevalence values.

The original CSV file (~40 MB) is not included in this repository but can be downloaded from the [official data portal](https://catalog.data.gov/dataset/nutrition-physical-activity-and-obesity-behavioral-risk-factor-surveillance-system).

To reproduce the analysis:

1. Download the dataset from the official portal
2. Place the file in the following directory:

`data/raw`

## Analysis Workflow

The analysis is organized into 4 reports:

1. **Initial Data Inspection**: Understanding the initial structure of the dataset
2. **Dataset Formation**: Converting the original dataset from survey/long-format to wide-format
3. **Exploratory Data Analysis**: EDA and visualizations
4. **Model Building and Conclusion**: Fitting Bayesian regression models an behavioral indicators and interpretting results

## Reports

1. [Initial Data Inspection](scripts/01_initial_data_check.md)
2. [Dataset Formation](scripts/02_create_dataset.md)
3. [Exploratory Data Analysis](scripts/03_eda.md)
4. [Model Building and Conclusion](scripts/04_model_building.md)