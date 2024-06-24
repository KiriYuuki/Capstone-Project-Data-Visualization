# Import Library Dashboard
library(shiny)
library(shinydashboard)

# Import Library Visualization
library(readxl)
library(dplyr)
library(plotly)
library(glue)
library(scales)
library(tidyr)
library(stringr)
library(lubridate)

# Import Library Read Table
library(DT)

# Setting to prevent scientific notation
options(scipen = 9999)

# Data Preparation

# Load the cleaned dataset
file_path <- 'data_input/cleaned_healthcomplains.csv'
cleaned_dataset <- read_csv(file_path)

# Data Cleansing
# Convert relevant columns to appropriate data types
cleaned_dataset <- cleaned_dataset %>%
  mutate(
    Percentage = as.numeric(Percentage),
    Year = as.numeric(as.character(Year)),
    Gender = as.factor(Gender),
    Area_Type = as.factor(Area_Type),
    Province = factor(Province, levels = sort(unique(Province)))
  ) %>%
  na.omit()