# Energy Consumption Analysis with R (2020–2024)

## 📌 Project Overview

This project analyzes **energy consumption patterns between 2020 and 2024** using R. The main goal is to explore how energy consumption changes over time and how it relates to climate and sustainability indicators such as temperature and renewable energy share.

The project is designed as a **portfolio-ready data analysis project**, following clean project structure and reproducible analysis principles.

---

## Dataset Description

The dataset contains **daily observations** with the following variables:

* `date` – Date of observation
* `country` – Country name
* `avg_temperature` – Average daily temperature
* `humidity` – Humidity level
* `co2_emission` – CO₂ emissions
* `energy_consumption` – Energy consumption level
* `renewable_share` – Share of renewable energy in total consumption
* `urban_population` – Urban population ratio
* `industrial_activity_index` – Industrial activity indicator
* `energy_price` – Energy price index

---

##  Analysis Steps

* Initial data exploration (`str`, `summary`, missing values)
* Filtering and analyzing data at **country level**
* Time series visualization of energy consumption
* Exploration of relationships between temperature and energy consumption
* Visualization of renewable energy share over time

---

##  Tools & Libraries

* **R**
* **RStudio**
* `ggplot2`
* `dplyr`
* `lubridate`

---

## 📁 Project Structure

```
energy-consumption-analysis-r/
├── scripts/
│   └── 01_energy_consumption_analysis.R
├── .gitignore
├── energy-consumption-analysis-r.Rproj
└── README.md
```

---

## How to Run

1. Clone the repository
2. Open `energy-consumption-analysis-r.Rproj` in RStudio
3. Run the script inside the `scripts/` folder

---

## Purpose

This project was created for **learning and portfolio purposes**, focusing on:

* Practical R data analysis
* Clean GitHub project structure
* Reproducible and readable code

---

## Author

Arda Bora

---

*Feel free to explore or use this project as a reference for R-based data analysis workflows.*
