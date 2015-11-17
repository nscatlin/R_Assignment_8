library("dplyr")

library("tidyr")

mammal_sizes <- read.csv("MOMv3.3.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE, na.strings = "-999")

colnames(mammal_sizes) <- c("continent", "status", "order", 
                            "family", "genus", "species", "log_mass", "combined_mass", 
                            "reference")

#the above wash pushed to the Github Repostitory named 'R_Assignment_8'

#1.2, 
# - calculate mean mass of extinct species
# - calculate mean mass extant species

#mean(mammal_sizes$combined_mass)[mammal_sizes$status == 'extinct']

### pseudo code
# for (line in mammal_sizes){
#   if (mammal_sizes$status =="extinct"){
#     print(mean(mammal_sizes$combined_mass))
#   }
# }
#!!!!!!DLYR!!!!!!

#Figuring out average mass for EXTINCT species
status_extinct <- group_by(mammal_sizes, status)
summ_extinct <- summarize(status_extinct, mean_weight = (mean(na.omit(combined_mass))))
avg_mass_extinct <- summ_extinct[summ_extinct$status == "extinct",]

#Figuring out average mass for EXTANT species
status_extant <- group_by(mammal_sizes, status)
summ_extant <- summarize(status_extant, mean_weight = (mean(na.omit(combined_mass))))
avg_mass_extant <- summ_extant[summ_extant$status == "extant",]

# Avg. mass for both extinct and extant
avg_mass_extinct$mean_weight; avg_mass_extant$mean_weight

#1.3
# mean masses within each of the different continents

# Getting rid of continent Af which is screwing up the dataset (is full of null values anyways)
mammal_sizes <- mammal_sizes[mammal_sizes$continent != "Af",]

# Extinct mass averages by continent
status_continent_extinct <- group_by(mammal_sizes, status, continent)
summ_stat_cont_extinct <- summarize(status_continent_extinct, mean_weight = (mean(na.omit(combined_mass))))
avg_mass_stat_cont_extinct <- summ_stat_cont_extinct[summ_stat_cont_extinct$status == "extinct",]

# Extant mass averages by continent
status_continent_extant <- group_by(mammal_sizes, status, continent)
summ_stat_cont_extant <- summarize(status_continent_extant, mean_weight = (mean(na.omit(combined_mass))))
avg_mass_stat_cont_extant <- summ_stat_cont_extant[summ_stat_cont_extant$status == "extant",]

#Binding the two datasets together
avg_mass_stat_cont_extinct_and_extant <- rbind(avg_mass_stat_cont_extant, avg_mass_stat_cont_extinct)
avg_mass_stat_cont_extinct_and_extant
as.vector(avg_mass_stat_cont_extinct_and_extant)
