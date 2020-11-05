devtools::load_all()
# Load required input data
# pf_data <- PFDataLoader(
#   "../app/preloaded_data/FA_loci.txt",
#   "../app/preloaded_data/Day3_STRING.txt")
cat("Loading Example Dataset...")
t_s <- Sys.time()
pf_data <- PF_FanconiAnemia
cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

# Initialize the population of subnetworks
cat("\nInitializing Population...")
t_s <- Sys.time()
population <- initializePopulation(pf_data, population_size = 10, "true_members")
cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

# Calculate the p-value of the population
cat("\nCalculating Significance of Population...")
t_s <- Sys.time()
p_value <- evaluatePopulationSignficance(pf_data, population, 10)
cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

# Calculate the gene scores from the top network
cat("\nCalculating Gene Scores from Top Network...")
t_s <- Sys.time()
top_network <- getTopNetwork(population)
scores <- calculateGeneScores(top_network, pf_data)
cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

# Visualize the gene scores
cat("\nVisualizing Gene Scores...")
t_s <- Sys.time()
viewGeneScores(PF_FanconiAnemia, getTopNetwork(population), scores)
cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

cat("Saving and Exiting...")
t_s <- Sys.time()
ggplot2::ggsave("~/Desktop/genescores.png", width = 25, height = 20, units="in")
save.image()
cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

