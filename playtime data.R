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

Data_Location <-"C:/Users/harle/OneDrive/Desktop/IMRP 2024 Improved  War Census/Morgan vs Tattaglia Main War Files/barzini vs paterno/playtime convert/war-playtime.xlsx" # data link
Playtime <- read_xlsx(Data_Location)

Playtime_Cleaned_0 <- Playtime |>
  select(date,`info/0/minutes_online`, `info/0/date`, `info/0/f_name`, `info/0/hours_online`)

Playtime_Cleaned_1 <- Playtime |>
  select(date,`info/1/minutes_online`, `info/1/date`, `info/1/f_name`, `info/1/hours_online`)|>
  rename(`info/0/minutes_online` =`info/1/minutes_online` ) |>
  rename(`info/0/date` = `info/1/date`)|>
  rename(`info/0/f_name` = `info/1/f_name`)|>
  rename(`info/0/hours_online` =`info/1/hours_online`)
