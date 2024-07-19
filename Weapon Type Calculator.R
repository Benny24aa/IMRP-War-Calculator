
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

IMRP_Data_Cleaned_Kills_Reason <- IMRP_Data |>
  select (`Killer Name`, `Killed Name`, Reason, `Date Killed`, `Team Kill`,`Date Killed`, `Killer Faction Id`)|> # Reducing size of dataset to speed up process
  filter(`Team Kill` == FALSE)|>
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killer Name`, Reason , `Killer Faction Id`, `DATE`)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player Name' =`Killer Name` )|>
  rename('Weapon ID' = Reason )|>
  rename('Kills' = count)|>
rename('Faction' =`Killer Faction Id` )

IMRP_Data_Cleaned_Deaths_Reason <- IMRP_Data |>
  select (`Killer Name`, `Killed Name`, Reason, `Date Killed`, `Team Kill`,`Date Killed`, `Killed Faction Id`)|> # Reducing size of dataset to speed up process
  filter(`Team Kill` == FALSE)|>
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killed Name`, Reason,`Killed Faction Id`, `DATE`)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player Name' =`Killed Name` ) |>
  rename('Deaths' = count)|>
  rename('Weapon ID' = Reason )|>
rename('Faction' =`Killed Faction Id`)

Weapon_Counts <- merge(IMRP_Data_Cleaned_Deaths_Reason, IMRP_Data_Cleaned_Kills_Reason)


write.csv(Weapon_Counts,"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/Morgan vs Tattaglia Main War Files/last update/ReasonInfo.csv")

