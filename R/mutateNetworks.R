mutateNetworks <- function(population, pf_data, mutation_rate = 0.05) {
  mutated_population <- lapply(population, .mutateNetwork, pf_data = pf_data, mutation_rate = mutation_rate)
  return(mutated_population)
}

.mutateNetwork <- function(network, pf_data, mutation_rate) {
  network_genes <- unlist(lapply(pf_data@loci_data, .maybeMutateLocus,
                                 network = top_network, pf_data = pf_data,
                                 mutation_rate = mutation_rate))
  network@genes <- network_genes
  return(network)
}


.maybeMutateLocus <- function(locus, network, pf_data, mutation_rate) {
  mutation_index <- grep(locus@locus_id, network@loci)
  mutate <- sample(0:1, 1, prob = c((1 - mutation_rate), mutation_rate))
  if (mutate) {
    mutated_gene <- sample(attr(pf_data@loci_data[[mutation_index]], "true_members"), 1)
    return(mutated_gene)
  } else {
    return(network@genes[mutation_index])
  }
}
