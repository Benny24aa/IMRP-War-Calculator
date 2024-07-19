
# Packages Loaded

library(readxl)
library(dplyr)
library(fs)
library(purrr)
library(data.table)
library(tidyr)
library(janitor)
library(stringr)
library(readr)

Data_Location <-"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/Morgan vs Tattaglia Main War Files/last update/final with bradford data.xlsx" # data link
IMRP_Data <- read_xlsx(Data_Location, 3) ### Load in data


#### Killer Data Analytics

IMRP_Data_Cleaned_Kills <- IMRP_Data |>
  select (`Killer Name`, `Killed Name`, Reason, `Date Killed`, `Team Kill`,`Date Killed`)|> # Reducing size of dataset to speed up process
  filter(`Team Kill` == FALSE)|>
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killer Name`, `DATE`)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player Name' =`Killer Name` )|>
  rename('Deaths' = count)

#### Killed Data Analytics
IMRP_Data_Cleaned_Deaths <- IMRP_Data |>
  select (`Killer Name`, `Killed Name`, Reason, `Date Killed`, `Team Kill`,`Date Killed`)|> # Reducing size of dataset to speed up process
  filter(`Team Kill` == FALSE)|>
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killed Name`, `DATE`)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player Name' =`Killed Name` ) |>
  rename('Kills' = count)

#### Merging Data for Analytics
  
 Merged <- merge(IMRP_Data_Cleaned_Deaths, IMRP_Data_Cleaned_Kills)
