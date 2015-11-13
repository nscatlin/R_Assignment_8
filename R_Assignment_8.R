mammal_sizes <- read.csv("MOMv3.3.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE, na.strings = "-999")

colnames(mammal_sizes) <- c("continent", "status", "order", 
                            "family", "genus", "species", "log_mass", "combined_mass", 
                            "reference")

head(mammal_sizes)





