
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

Data_Location <-"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/Morgan vs Tattaglia Main War Files/barzini vs paterno/paterno vs barzini main file current.xlsx" # data link
IMRP_Data <- read_xlsx(Data_Location, 3) ### Load in data


#### Killer Data Analytics

IMRP_Data_Cleaned_Kills <- IMRP_Data |>
  filter(`Team Kill` ==  FALSE)|>
  select (`Killer Name`, `Killed Name`, Reason, `Date Killed`, `Team Kill`,`Date Killed`, `Killer Faction Id`)|> # Reducing size of dataset to speed up process
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killer Name`, `Killer Faction Id`)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player Name' =`Killer Name` )|>
  rename('Faction' =`Killer Faction Id` )|>
  rename('Kills' = count)

#### Killed Data Analytics
IMRP_Data_Cleaned_Deaths <- IMRP_Data |>
  select (`Killer Name`, `Killed Name`, Reason, `Date Killed`, `Team Kill`,`Date Killed`, `Killed Faction Id`)|> # Reducing size of dataset to speed up process
  mutate(DATE = as.Date(`Date Killed`), format = "%d/%m/%Y")|>
  group_by(`Killed Name`, `Killed Faction Id`)|>
  summarise(count=n(), .groups = 'drop')|>
  rename('Player Name' =`Killed Name` ) |>
  rename('Deaths' = count)|>
  rename('Faction' =`Killed Faction Id`)

#### Merging Data for Analytics
  
 Merged <- merge(IMRP_Data_Cleaned_Deaths, IMRP_Data_Cleaned_Kills)
 
 # Merged_Final <- Merged |>
 #   mutate(Ratio = Kills/Deaths)
write.csv(Merged,"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/Morgan vs Tattaglia Main War Files/barzini vs paterno/KD.csv", row.names = F)
### damage analytics
