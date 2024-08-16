
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

Data_Location <-"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/Census Final File Without War 40 Important/census test.xlsx" # data link
IMRP_Data <- read_xlsx(Data_Location, 3) ### Load in data

#### Killer Data Analytics

IMRP_Data_Cleaned_Kills <- IMRP_Data |>
  filter(`Team Kill` ==  FALSE)|>
  select (`Killer Name`, `Killer Id`,`Killed Id`,`Killed Name`, Reason, `Date Killed`, `Team Kill`,`Date Killed`, `Killer Faction Id`, War)|> # Reducing size of dataset to speed up process
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killer Id`, War)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player ID' = `Killer Id` )|>
  rename('Kills' = count)

#### Killed Data Analytics
IMRP_Data_Cleaned_Deaths <- IMRP_Data |>
  select (`Killer Name`, `Killer Id`, `Killed Id`, `Killed Name`, Reason, `Date Killed`, `Team Kill`,`Date Killed`, `Killed Faction Id`, War)|> # Reducing size of dataset to speed up process
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killed Id`,War)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player ID' = `Killed Id` ) |>
  rename('Deaths' = count) 

#### Merging Data for Analytics

Merged <- merge(IMRP_Data_Cleaned_Deaths, IMRP_Data_Cleaned_Kills)

write.csv(Merged,"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/historykd.csv", row.names = F)
