
#Calculate PCA

#Load packages
library(tidyverse)
library(ggplot2)


#read in pca file
pca <- read_table("/Users/classes/bio355b/CURE_projects/temporal/data_raw/out/Jensen_historical_contemporary_2218loci_pca.eigenvec", col_names = FALSE)

#read in the file that has population level information per individual
popmap <- read_table("/Users/classes/bio355b/CURE_projects/temporal/data_raw/population_map.txt")


#make it human readable
colnames(pca)[1:2] <- c("FID","ID")
colnames(pca)[3:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-2))

colnames(pca)


#view the data
head(pca)

#merge pop file with existing pce
pca <- pca %>%
  mutate(sampleID = paste(FID, ID, sep = "_"))

#add column for pop level identifiers
pca <- left_join(pca, popmap, by = "sampleID")
head(pca)
colnames(pca)


#Plot PC1 vs PC2
ggplot(pca, aes(x = PC1, y = PC2)) +
  geom_point(size = 3) +
  theme_classic() +
  labs(
    title = "Population Structure PCA",
    x = "PC1",
    y = "PC2"
  )


#add color and labels
ggplot(pca, aes(x = PC1, y = PC2, color = population)) +
  geom_point(size = 3) +
  theme_classic() +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Population Structure PCA",
    x = "PC1",
    y = "PC2",
    color = "Population"
  )

