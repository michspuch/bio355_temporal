#Visualizing FST in R


#Load libraries
library(tidyverse)

#Make table
fst_summary <- tribble(
  ~pop1, ~pop2, ~mean_fst,
  "historical", "contemporary", 0.024797)

#Bind the fst summary data
fst_plot <- bind_rows(
  fst_summary,
  fst_summary %>% rename(pop1 = pop2, pop2 = pop1)
)

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

#Assign table for min, max, mean, and mode FST
pairwise_fst <- read_table("/Users/classes/bio355b/CURE_projects/temporal/results/Jensen_pairwise_fst.weir.fst")

#Check to make sure it works
head(pairwise_fst)

#Calculate min, max, mean FST
min(pairwise_fst$WEIR_AND_COCKERHAM_FST)
max(pairwise_fst$WEIR_AND_COCKERHAM_FST)
mean(pairwise_fst$WEIR_AND_COCKERHAM_FST)

#Mode FST
# Define the function
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Apply to a specific column (e.g., 'my_column' in data frame 'df')
result <- get_mode(pairwise_fst$WEIR_AND_COCKERHAM_FST)
print(result)


  
