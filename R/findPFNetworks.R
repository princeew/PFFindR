findPFNetworks <- function(pf_data,
                           population_size,
                           binary = TRUE,
                           mutation_rate = 0.05,
                           optimizer_stop_threshold = 0.05,
                           plot_fitness = TRUE,
                           plot_fitness_path = "./pffinder_search_performance.png",
                           save_gene_scores = TRUE,
                           gene_scores_path ="./Day3_Output.gmt",
                           p_val_trials = 100,
                           num_to_save = 10,
                           save_network = TRUE,
                           network_path = "./Day3_Output_Network_pval.txt") {

  # Initialize a population of possible solutions
  population <- initializePopulation(pf_data = pf_data,
                                     population_size = population_size,
                                     members = "true_members",
                                     binary = binary)

  # Evolve a population until the mean population density does not improve by
  # `optimizer_stop_threshold`
  population <- evolve(population = population,
                       pf_data = pf_data,
                       min_pct_change = optimizer_stop_threshold,
                       mutation_rate = mutation_rate,
                       plot_fitness = plot_fitness,
                       plot_fitness_path = plot_fitness_path)

  # Evaluate the significance of the final population
  p_value <- evaluatePopulationSignficance(pf_data = pf_data,
                                           population = population,
                                           num_trials = p_val_trials)

  # Save gene scores
  if (save_gene_scores) {
    if (num_to_save == 1) {
      gene_scores <- calculateGeneScores(getTopNetwork(population = population))
    } else {
      gene_scores <- lapply(getTopNetwork(population = population,
                                          multiple = TRUE,
                                          n = num_to_save), calculateGeneScores,
                            pf_data = pf_data)
      }
    saveGeneScores(scores = gene_scores, pf_data = pf_data,
                   save_path = gene_scores_path)
    }

  # Save the networks
  if (save_network) {
    top_networks <- getTopNetwork(population = population, multiple = TRUE, n = num_to_save)
    for (i in 1:length(top_networks)) {
      net_path <- sub("Network", sprintf("Network%02d", i), network_path)
      net_path <- sub(".txt", paste0(p_value, ".txt"), net_path)
      saveNetwork(top_networks[[i]],
                  save_path = net_path)
    }
  }
  return(population)
}
