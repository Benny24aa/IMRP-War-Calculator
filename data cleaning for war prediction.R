
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

Data_Location <-"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/Morgan vs Tattaglia Main War Files/barzini vs paterno/historic data for prediction.xlsx" # data link
IMRP_Data <- read_xlsx(Data_Location, 3) ### Load in data


#### Killer Data Analytics

IMRP_Data_Cleaned_Kills <- IMRP_Data |>
  filter(`Team Kill` ==  FALSE)|>
  select (`Killer Id`, `Killed Id`, Reason, `Date Killed`, `Team Kill`,`Date Killed`, `Killer Faction Id`)|> # Reducing size of dataset to speed up process
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killer Id`, `Killer Faction Id`)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player ID' =`Killer Id` )|>
  rename('Faction' =`Killer Faction Id` )|>
  rename('Kills' = count)

#### Killed Data Analytics
IMRP_Data_Cleaned_Deaths <- IMRP_Data |>
  select (`Killer Id`, `Killed Id`, Reason, `Date Killed`, `Team Kill`,`Date Killed`, `Killed Faction Id`)|> # Reducing size of dataset to speed up process
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killed Id`, `Killed Faction Id`)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player ID' =`Killed Id` ) |>
  rename('Deaths' = count)|>
  rename('Faction' =`Killed Faction Id`)

#### Merging Data for Analytics

Merged <- merge(IMRP_Data_Cleaned_Deaths, IMRP_Data_Cleaned_Kills)

Predict <-"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/Morgan vs Tattaglia Main War Files/barzini vs paterno/leftjoin.xlsx" # data link
IMRP_Data_Predict <- read_xlsx(Predict, 1) ### Load in data


Merged_Cleaned <- Merged |>
  left_join(IMRP_Data_Predict, Merged, by = "Player ID")

write.csv(Merged_Cleaned,"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/Morgan vs Tattaglia Main War Files/barzini vs paterno/KD.csv")

### damage analytics
