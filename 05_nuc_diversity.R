#Calculate MAF 

#Load packages
library(tidyverse)
library(ggplot2)


#Read in the windowed pi files after getting mean pi in zim:
pi_1906 <- read_table("/Users/classes/bio355b/CURE_projects/temporal/data_raw/out/Jensen_historical_2218loci_sitepi.sites.pi")
pi_2014 <- read_table("/Users/classes/bio355b/CURE_projects/temporal/data_raw/out/Jensen_contemporary_2218loci_sitepi.sites.pi")

#Inspect files:
head(pi_1906)
head(pi_2014)

#Add a year label:
pi_1906 <- pi_1906 %>% mutate(year = "1906")
pi_2014 <- pi_2014 %>% mutate(year = "2014")

pi_all <- bind_rows(pi_1906, pi_2014)


#Visualize as a box plot
ggplot(pi_all, aes(x = year, y = PI)) +
  geom_boxplot() +
  theme_classic() +
  labs(
    title = "Distribution of windowed nucleotide diversity by year",
    x = "Year",
    y = "Nucleotide diversity (pi)"




    
