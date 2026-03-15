Data Cleaning and Dataset Formation
================

``` r
# Load the raw CDC obesity behavior dataset
df <- read_csv("../data/raw/adult_obesity_behavior.csv", show_col_types = FALSE)
```

``` r
# Keep columns needed for modeling purposes only
df_use <- df %>%
  filter(Total == "Total") %>%
  select(LocationDesc, YearStart, Question, Data_Value)
```

``` r
# Convert long-format survey responses into a wide dataset of behavioral indicators
df_wide <- df_use %>%
  pivot_wider(
    names_from = Question,
    values_from = Data_Value
  )
```

``` r
# Replace long survey question text with shorter variable names
df_wide <- df_wide %>%
  rename(
    obesity = `Percent of adults aged 18 years and older who have obesity`,
    overweight = `Percent of adults aged 18 years and older who have an overweight classification`,
    activity_150 = `Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)`,
    activity_150_strength = `Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic physical activity (or an equivalent combination) and engage in muscle-strengthening activities on 2 or more days a week`,
    activity_300 = `Percent of adults who achieve more than 300 minutes a week of moderate-intensity aerobic physical activity or 150 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)`,
    muscle_strengthening = `Percent of adults who engage in muscle-strengthening activities on 2 or more days a week`,
    no_leisure_activity = `Percent of adults who engage in no leisure-time physical activity`,
    fruit_lt_1_per_day = `Percent of adults who report consuming fruit less than one time daily`,
    vegetables_lt_1_per_day = `Percent of adults who report consuming vegetables less than one time daily`
  )
```

``` r
# Inspect the wide-format dataset to verify structure and summary statistics
glimpse(df_wide)
```

    ## Rows: 770
    ## Columns: 11
    ## $ LocationDesc            <chr> "Alabama", "Alaska", "Arizona", "Arkansas", "C…
    ## $ YearStart               <dbl> 2011, 2011, 2011, 2011, 2011, 2011, 2011, 2011…
    ## $ obesity                 <dbl> 32.0, 27.4, 25.1, 30.9, 23.8, 20.7, 24.5, 28.8…
    ## $ overweight              <dbl> 34.7, 38.9, 37.8, 33.9, 36.4, 35.4, 35.2, 35.0…
    ## $ activity_150            <dbl> 42.4, 57.9, 52.8, 45.7, 58.2, 61.8, 52.6, 48.5…
    ## $ activity_150_strength   <dbl> 15.0, 25.0, 24.2, 16.7, 23.7, 27.3, 21.8, 21.5…
    ## $ activity_300            <dbl> 23.9, 37.7, 33.1, 27.8, 36.1, 40.7, 32.8, 28.3…
    ## $ muscle_strengthening    <dbl> 24.7, 33.8, 32.5, 24.7, 32.1, 35.6, 30.6, 32.3…
    ## $ no_leisure_activity     <dbl> 32.6, 22.0, 24.1, 30.9, 19.1, 16.5, 25.5, 27.0…
    ## $ fruit_lt_1_per_day      <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
    ## $ vegetables_lt_1_per_day <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…

``` r
dim(df_wide)
```

    ## [1] 770  11

``` r
summary(df_wide)
```

    ##  LocationDesc         YearStart       obesity        overweight   
    ##  Length:770         Min.   :2011   Min.   :20.20   Min.   :29.10  
    ##  Class :character   1st Qu.:2014   1st Qu.:27.80   1st Qu.:34.10  
    ##  Mode  :character   Median :2018   Median :30.90   Median :35.10  
    ##                     Mean   :2018   Mean   :30.98   Mean   :34.98  
    ##                     3rd Qu.:2021   3rd Qu.:34.20   3rd Qu.:36.00  
    ##                     Max.   :2024   Max.   :41.40   Max.   :39.10  
    ##                                    NA's   :19      NA's   :19     
    ##   activity_150   activity_150_strength  activity_300   muscle_strengthening
    ##  Min.   :19.60   Min.   : 5.40         Min.   : 9.80   Min.   : 9.80       
    ##  1st Qu.:48.52   1st Qu.:19.00         1st Qu.:29.30   1st Qu.:28.80       
    ##  Median :52.10   Median :21.60         Median :32.75   Median :31.45       
    ##  Mean   :52.31   Mean   :22.05         Mean   :33.36   Mean   :32.12       
    ##  3rd Qu.:57.17   3rd Qu.:24.30         3rd Qu.:36.88   3rd Qu.:35.38       
    ##  Max.   :67.80   Max.   :38.30         Max.   :50.60   Max.   :49.10       
    ##  NA's   :452     NA's   :452           NA's   :452     NA's   :452         
    ##  no_leisure_activity fruit_lt_1_per_day vegetables_lt_1_per_day
    ##  Min.   :13.9        Min.   :29.70      Min.   :12.40          
    ##  1st Qu.:21.5        1st Qu.:36.10      1st Qu.:17.40          
    ##  Median :24.2        Median :38.90      Median :19.70          
    ##  Mean   :24.7        Mean   :39.39      Mean   :20.04          
    ##  3rd Qu.:27.0        3rd Qu.:42.70      3rd Qu.:21.30          
    ##  Max.   :54.0        Max.   :56.00      Max.   :46.60          
    ##  NA's   :20          NA's   :609        NA's   :609

``` r
df_wide %>%
  summarise(across(everything(), ~sum(is.na(.)))) %>%
  pivot_longer(everything(),
               names_to = "variable",
               values_to = "missing") %>%
  arrange(desc(missing))
```

    ## # A tibble: 11 × 2
    ##    variable                missing
    ##    <chr>                     <int>
    ##  1 fruit_lt_1_per_day          609
    ##  2 vegetables_lt_1_per_day     609
    ##  3 activity_150                452
    ##  4 activity_150_strength       452
    ##  5 activity_300                452
    ##  6 muscle_strengthening        452
    ##  7 no_leisure_activity          20
    ##  8 obesity                      19
    ##  9 overweight                   19
    ## 10 LocationDesc                  0
    ## 11 YearStart                     0

``` r
# Count missing values for each variable in the wide-format dataset
df_wide %>%
  group_by(YearStart) %>%
  summarise(
    fruit_missing = sum(is.na(fruit_lt_1_per_day)),
    activity_missing = sum(is.na(activity_150))
  )
```

    ## # A tibble: 14 × 3
    ##    YearStart fruit_missing activity_missing
    ##        <dbl>         <int>            <int>
    ##  1      2011            55                3
    ##  2      2012            55               55
    ##  3      2013            55                3
    ##  4      2014            55               55
    ##  5      2015            55                1
    ##  6      2016            55               55
    ##  7      2017             1                1
    ##  8      2018            55               55
    ##  9      2019             2                2
    ## 10      2020            55               55
    ## 11      2021             1               55
    ## 12      2022            55               55
    ## 13      2023            55                2
    ## 14      2024            55               55

``` r
# Examine how missingness in diet and activity indicators varies by year
df_wide %>%
  mutate(
    fruit_present = !is.na(fruit_lt_1_per_day),
    activity_present = !is.na(activity_150)
  ) %>%
  group_by(YearStart) %>%
  summarise(
    fruit_rate = mean(fruit_present),
    activity_rate = mean(activity_present)
  )
```

    ## # A tibble: 14 × 3
    ##    YearStart fruit_rate activity_rate
    ##        <dbl>      <dbl>         <dbl>
    ##  1      2011      0             0.945
    ##  2      2012      0             0    
    ##  3      2013      0             0.945
    ##  4      2014      0             0    
    ##  5      2015      0             0.982
    ##  6      2016      0             0    
    ##  7      2017      0.982         0.982
    ##  8      2018      0             0    
    ##  9      2019      0.964         0.964
    ## 10      2020      0             0    
    ## 11      2021      0.982         0    
    ## 12      2022      0             0    
    ## 13      2023      0             0.964
    ## 14      2024      0             0

``` r
# Remove rows where all behavioral indicators and obesity measures are missing
df_final <- df_wide %>%
  filter(
    !if_all(
      c(
        obesity,
        overweight,
        activity_150,
        activity_150_strength,
        activity_300,
        muscle_strengthening,
        no_leisure_activity,
        fruit_lt_1_per_day,
        vegetables_lt_1_per_day
      ),
      is.na
    )
  )
```

``` r
# Save cleaned panel dataset for modeling
write_csv(df_final, "../data/cleaned/adult_behavior_panel.csv")
```
