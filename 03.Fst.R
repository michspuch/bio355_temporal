#Visualizing FST in R


#Load libraries
library(tidyverse)

#Make table
fst_summary <- tribble(
  ~pop1, ~pop2, ~mean_fst,
  "historical", "contemporary", 0.024797)

#Set up plot
ggplot(fst_plot, aes(x = pop1, y = pop2, fill = mean_fst)) +
  geom_tile() +
  geom_text(aes(label = round(mean_fst, 3)), size = 3) +
  theme_classic() +
  labs(
    title = "Pairwise FST among populations",
    x = "Population 1",
    y = "Population 2",
    fill = "Mean FST"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

  
#Count FST values (2219 in all)
wc -l Jensen_pairwise_fst.weir.fst

#Check for positive Fst 
command | awk '$3 > 0' Jensen_pairwise_fst.weir.fst | wc -l

#Check for Fst greater than 0.1 
command | awk '$3 > 0.1' Jensen_pairwise_fst.weir.fst | wc -l

#Check for Fst greater than 0.05
command | awk '$3 > 0.05' Jensen_pairwise_fst.weir.fst | wc -l
