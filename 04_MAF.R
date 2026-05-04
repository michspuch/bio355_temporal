#Calculate MAF 

#Load packages
library(tidyverse)
library(ggplot2)
library(readr)


#Visualize frequency data
frq_1906 <- read_table("/Users/classes/bio355b/CURE_projects/temporal/data_raw/out/Jensen_historical_2218loci.frq", skip = 1, col_names = c("CHROM", "POS", "N_ALLELES", "N_CHR", "ALLELE1", "ALLELE2"))
frq_2014 <- read_table("/Users/classes/bio355b/CURE_projects/temporal/data_raw/out/Jensen_contemporary_2218loci.frq", skip = 1, col_names = c("CHROM", "POS", "N_ALLELES", "N_CHR", "ALLELE1", "ALLELE2"))

#Look at first 10 lines
head(frq_1906)
head(frq_2014)

#Make a frequency table for 1906
frq_1906_parsed <- frq_1906 %>%
  separate(ALLELE1, into = c("ALLELE1_BASE", "ALLELE1_FREQ"), sep = ":") %>%
  separate(ALLELE2, into = c("ALLELE2_BASE", "ALLELE2_FREQ"), sep = ":") %>%
  mutate(
    ALLELE1_FREQ = as.numeric(ALLELE1_FREQ),
    ALLELE2_FREQ = as.numeric(ALLELE2_FREQ),
    MAF = pmin(ALLELE1_FREQ, ALLELE2_FREQ)
  )

#Make a frequency table for 2014
frq_2014_parsed <- frq_2014 %>%
  separate(ALLELE1, into = c("ALLELE1_BASE", "ALLELE1_FREQ"), sep = ":") %>%
  separate(ALLELE2, into = c("ALLELE2_BASE", "ALLELE2_FREQ"), sep = ":") %>%
  mutate(
    ALLELE1_FREQ = as.numeric(ALLELE1_FREQ),
    ALLELE2_FREQ = as.numeric(ALLELE2_FREQ),
    MAF = pmin(ALLELE1_FREQ, ALLELE2_FREQ)
  )

#Plot 1906 timepoint:
ggplot(frq_1906_parsed, aes(x = MAF)) +
  geom_histogram(binwidth = 0.05) +
  theme_classic() +
  labs(
    title = "Minor allele frequency distribution (1906)",
    x = "Minor allele frequency",
    y = "Number of SNPs"
  )


#Plot 2014 time point:
ggplot(frq_2014_parsed, aes(x = MAF)) +
  geom_histogram(binwidth = 0.05) +
  theme_classic() +
  labs(
    title = "Minor allele frequency distribution (2014)",
    x = "Minor allele frequency",
    y = "Number of SNPs"
  )

#Combine data by adding a year label
frq_1906_parsed <- frq_1906_parsed %>% mutate(year = "1906")
frq_2014_parsed <- frq_2014_parsed %>% mutate(year = "2014")

frq_all <- bind_rows(frq_1906_parsed, frq_2014_parsed)

#Check for real missing values
sum(is.na(frq_all$MAF))
summary(frq_all$MAF)

#Plot MAF for both time points
ggplot(frq_all, aes(x = MAF, fill = year)) +
  geom_histogram(binwidth = 0.01, alpha = 0.6, position = "identity") +
  scale_x_continuous(
    breaks = seq(0, 0.5, by = 0.05)
  ) +
  coord_cartesian(xlim = c(0, 0.5)) +
  theme_classic() +
  labs(
    title = "Minor allele frequency distributions by timepoint",
    x = "Minor allele frequency",
    y = "Number of SNPs"
  )


#Faceted plot to reduce noisy overlay
ggplot(frq_all, aes(x = MAF, fill = year)) +
  geom_histogram(binwidth = 0.05) +
  facet_wrap(~year) +
  theme_classic() +
  labs(
    title = "Minor allele frequency distributions by timepoint",
    x = "Minor allele frequency",
    y = "Number of SNPs"
  )










