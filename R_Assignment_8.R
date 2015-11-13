library(dpylr)
library(stringr)

mammal_sizes <- read.csv("MOMv3.3.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE, na.strings = "-999")

colnames(mammal_sizes) <- c("continent", "status", "order", 
                            "family", "genus", "species", "log_mass", "combined_mass", 
                            "reference")

#the above wash pushed to the Github Repostitory named 'R_Assignment_8'

#1.2, 
# - calculate mean mass of extinct species
# - calculate mean mass extant species

mean_mass_extinct <- if(mammal_sizes$status == "extinct")







