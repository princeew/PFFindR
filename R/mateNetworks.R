mateNetworks <- function(population, pf_data, num_matings) {
  mating_iterations <- as.list(1:num_matings)
  new_population <- lapply(mating_iterations, .mateNetworks, population = population,
                           pf_data = pf_data)
  return(new_population)
}

.mateNetworks <- function(mating_iteration, population, pf_data) {
  network_scores <- getNetworkDensity(population, return_mean = FALSE) ** 3
  if (length(network_scores[network_scores > 0]) <= 2) {
    network_scores <- network_scores + 1
  }
  probs <- network_scores / sum(network_scores)
  mates <- sample(population, 2, prob = probs, replace = T)
  mates <- mutateNetworks(mates, pf_data)
  gene_options <- lapply(mates, .get_gene_options)
  offspring_genes <- apply(as.data.frame(gene_options), 1, .select_genes)
  offspring <- new(
    "PrixFixeNetwork",
    "loci" = pf_data@loci_dataframe$locusID,
    "genes" = offspring_genes)
  return(calculateAdjacencyMatrix(offspring, pf_data))
}

.get_gene_options <- function(network) {
  return(network@genes)
}

.select_genes <- function(gene_option_row) {
  return(sample(unlist(gene_option_row), 1))
}


