library(readxl)
library(tidyverse)

fishTidy <- function(dt){
  dt <- dt %>% 
    gather(key, "measurement", -c(1,2))
  
  colnames(dt)[1:2] <- c("prey_taxon", "prey_stage")
  
  dt <- dt %>%
    separate(key, c("predator genus","predator species","predator min length", "predator max length",
                    "length units", sample size","start year", "start month","start day",
                    "end year","end month","end day", "habitat",
                    "measurment type","measurement units","author","year"),
                    sep = "_") 
  
}

check_data <- function(df){
  names(df[1:2]) %in% c("prey_stage", "prey_taxon")
}

# make list of filenames in your data folder
filename <- list.files("./Data")

# empty object to put data into
data.list <- NULL

# for loop
for(name in seq_along(filename)){
  data.list[[name]] <- read_excel(paste("Data/", filename[name], sep = ""))
}

# check data function here using lapply
lapply(data.list, FUN = check_data)

# everything above this is probably good ___________________________________________
 ?paste()
list.subset <- NULL
list.subset[[1]] <- data.list[[1]]
list.subset[[2]] <- data.list[[2]]


# below this you could combine to one call _____________________________
tidydata <- lapply(data.list, FUN = fishTidy)
tidydata[[2]]

tidy.df <- bind_rows(tidydata)


# checking full data list
tidydata <- lapply(data.list, FUN = fishTidy) %>% bind_rows()


# example of combining with pipes
lapply(data.list, FUN = fishTidy) %>%
  bind_rows()
  
?bind_rows()

