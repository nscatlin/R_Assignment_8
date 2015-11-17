library("dplyr")
library("tidyr")
library("ggplot2")
#install.packages("gridExtra")
library("gridExtra")
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
spread_data<- avg_mass_stat_cont_extinct_and_extant  %>% 
spread(status, mean_weight) 

# Sending it to a CSV file named 'continent_mass_differences.csv'
write.csv(spread_data, file = "continent_mass_differences.csv", row.names=FALSE)

# 1.4
# Make a graph that shows the data for each continent that you think is worth visualizing.

# Partitioning to only have EXTINCT mammals
extinct_mammals <- data.frame(mammal_sizes) %>%
  filter(status == "extinct")

# Partitioning to only have EXTANT mammals
extant_mammals <- data.frame(mammal_sizes) %>%
  filter(status == "extant")

#Making sure I can see both plots (code below)
par(mfrow=c(2, 1))

# Plot of Extinct Mammals
extinct_nos <- ggplot(extinct_mammals, aes(x = log_mass)) +
  geom_bar() +
  ylim(0,100) +
  ylab("Number of Species") +
  xlab("Log Mass") +
  ggtitle("Extinct") +
  facet_grid(continent ~ .) 

# Plot of Extant Mammals
extant_nos <- ggplot(extant_mammals, aes(x = log_mass)) +
  geom_bar() +
  ylim(0,100) +
  ylab("Number of Species") +
  xlab("Log Mass") +
  ggtitle("Extant") +
  facet_grid(continent ~ .) 

grid.arrange(extant_nos, extinct_nos, ncol = 2)
