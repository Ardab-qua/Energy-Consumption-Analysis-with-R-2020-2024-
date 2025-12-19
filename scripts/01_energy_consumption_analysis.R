# ============================================================
# Energy Consumption Analysis – Turkey (2020–2024)
# ============================================================
# This script explores the relationship between energy consumption,
# climate indicators, industrial activity, and sustainability metrics
# using daily and monthly data for Turkey.

# ============================================================
# 1. Libraries
# ============================================================
library(ggplot2)
library(dplyr)
library(lubridate)

# ============================================================
# 2. Data Loading and Initial Exploration
# ============================================================
# The dataset is loaded from the local 'data' directory to ensure
# reproducibility across different environments.

global_climate_energy_2020_2024 <- read.csv(
  "data/global_climate_energy_2020_2024.csv"
)

# Preview the first rows of the dataset
head(global_climate_energy_2020_2024)

# Inspect the structure of the dataset to understand variable types
# (in particular, to verify whether the date variable is stored as Date or character)
str(global_climate_energy_2020_2024)

# Summary statistics provide a high-level overview of distributions
# and potential anomalies in the data
summary(global_climate_energy_2020_2024)

# ============================================================
# 3. Country-Level Filtering: Turkey
# ============================================================
# Filter the dataset to focus exclusively on Turkey. This creates a
# country-specific subset for all subsequent analyses.

turkey_data <- global_climate_energy_2020_2024 %>%
  filter(country == "Turkey")
# Convert date column to Date format for time-based analysis
turkey_data <- turkey_data %>%
  mutate(date = as.Date(date))

# ============================================================
# 4. Time Series Analysis: Energy Consumption
# ============================================================
# Visualize how energy consumption evolves over time in Turkey.

ggplot(turkey_data,
       aes(x = date, y = energy_consumption)) + 
  geom_line() +
  labs(
    title = "Turkey – Energy Consumption Over Time",
    x = "Date",
    y = "Energy Consumption"
  )

# ============================================================
# 5. Temperature and Energy Consumption Relationship
# ============================================================
# Explore the relationship between average temperature and energy
# consumption using a scatter plot.

ggplot(turkey_data,
       aes(x = avg_temperature, y = energy_consumption)) +
  geom_point(alpha = 0.4) +
  labs(
    title = "Temperature vs Energy Consumption (Turkey)",
    x = "Average Temperature",
    y = "Energy Consumption"
  )

# ============================================================
# 6. Energy Consumption and Temperature Over Time
# ============================================================
# Overlay energy consumption and temperature trends on the same time
# axis to visually compare their temporal dynamics. Temperature is
# scaled to allow comparison on a single plot.

ggplot(turkey_data, aes(x = date)) +
  geom_line(aes(y = energy_consumption), color = "blue") +
  geom_line(aes(y = avg_temperature * 100), color = "red") +
  labs(
    title = "Energy Consumption and Temperature Over Time (Turkey)",
    y = "Energy Consumption (blue) / Temperature (scaled, red)"
  )

# ============================================================
# 7. Renewable Energy Share Over Time
# ============================================================
# Analyze how the share of renewable energy in total consumption has
# changed over time in Turkey.

ggplot(turkey_data,
       aes(x = date, y = renewable_share)) +
  geom_line() +
  labs(
    title = "Renewable Energy Share Over Time in Turkey",
    x = "Date",
    y = "Renewable Energy Share"
  )

# ============================================================
# 8. Renewable Energy Share and Energy Prices
# ============================================================
# Compare renewable energy share and energy prices over time to explore
# potential co-movement. Note that daily data may limit the ability to
# capture price dynamics accurately.

ggplot(turkey_data, aes(x = date)) +
  geom_line(aes(y = renewable_share), color = "red") +
  geom_line(aes(y = energy_price), color = "blue") +
  labs(
    title = "Renewable Energy Share and Energy Prices Over Time (Turkey)",
    y = "Renewable Share (red) / Energy Price (blue)"
  )

# ============================================================
# 9. Renewable Energy and CO₂ Emissions
# ============================================================
# Examine the relationship between renewable energy share and CO₂
# emissions to assess the environmental impact of cleaner energy use.

ggplot(turkey_data,
       aes(x = renewable_share, y = co2_emission)) +
  geom_point(alpha = 0.4) +
  labs(
    title = "Renewable Energy Share vs CO₂ Emissions (Turkey)",
    x = "Renewable Energy Share",
    y = "CO₂ Emissions"
  )

# ============================================================
# 10. Monthly Aggregation: Energy Consumption
# ============================================================
# Aggregate daily energy consumption into monthly averages to reduce
# noise and highlight medium-term trends.

monthly_energy_turkey <- turkey_data %>%
  
  mutate(month = floor_date(date, "month")) %>%
  group_by(month) %>%
  summarise(
    monthly_avg_energy = mean(energy_consumption, na.rm = TRUE)
  )

# Visualize monthly average energy consumption

ggplot(monthly_energy_turkey,
       aes(x = month, y = monthly_avg_energy)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Turkey – Monthly Average Energy Consumption (2020–2024)",
    x = "Month",
    y = "Average Energy Consumption"
  )

# ============================================================
# 11. Industrial Activity and Energy Consumption
# ============================================================
# Investigate whether daily variations in industrial activity can
# explain daily energy consumption levels.

ggplot(turkey_data,
       aes(x = industrial_activity_index, y = energy_consumption)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Industrial Activity vs Energy Consumption (Turkey)",
    x = "Industrial Activity Index",
    y = "Energy Consumption"
  )

# ============================================================
# 12. Industrial Activity, CO₂ Emissions, and Renewables (Monthly)
# ============================================================
# Create a monthly-level dataset combining industrial activity,
# CO₂ emissions, and renewable energy share to analyze structural
# relationships and sustainability effects.

monthly_industry_co2 <- turkey_data %>%
  mutate(month = floor_date(date, "month")) %>%
  group_by(month) %>%
  summarise(
    avg_industry = mean(industrial_activity_index, na.rm = TRUE),
    avg_co2 = mean(co2_emission, na.rm = TRUE),
    avg_renewable = mean(renewable_share, na.rm = TRUE)
  )

# Visualize the relationship between industrial activity and CO₂
# emissions using monthly averages and a linear trend line.

ggplot(monthly_industry_co2,
       aes(x = avg_industry, y = avg_co2)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Industrial Activity vs CO₂ Emissions (Monthly Averages, Turkey)",
    x = "Average Industrial Activity Index",
    y = "Average CO₂ Emissions"
  ) +
  theme_minimal()

# The fitted regression line highlights the average relationship
# between industrial activity and CO₂ emissions, suggesting that
# higher industrial activity is generally associated with increased
# emissions at the monthly level.