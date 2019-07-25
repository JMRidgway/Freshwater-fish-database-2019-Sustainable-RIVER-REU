library(readxl)
library(tidyverse)
library(plyr)

fishTidy <- function(dt){
  dt <- dt %>% 
    gather(key, "measurement", -c(1,2))
  
  colnames(dt)[1:2] <- c("preyTaxon", "preyStage")
  
  dt <- dt %>%
    separate(key, c("predatorGenus","predatorSpecies","predatorMinLength", "predatorMaxLength",
                    "lengthUnits", "sampleSize","startYear", "startMonth","startDay",
                    "endYear","endMonth","endDay", "habitat",
                    "measurementType","measurementUnits","author","year", "journal"),
                    sep = "_") %>%
    mutate(enteredBy = "JR")
}

check_data <- function(df){
  names(df[1:2]) %in% c("prey_stage", "prey_taxon")
}

filename <- list.files("./Data")

data.list <- NULL

for(name in seq_along(filename)){
  data.list[[name]] <- read_excel(paste("Data/", filename[name], sep = ""))
}

lapply(data.list, FUN = check_data)

tidydata <- lapply(data.list, FUN = fishTidy) %>% rbind.fill()


