evolve <- function(population, pf_data, min_pct_change) {
  early_stop = FALSE
  while(!early_stop) {
    previous_population_density <- getNetworkDensity(population)
    population <- mateNetworks(population, pf_data, num_matings = length(population))
    next_population_density <- getNetworkDensity(population)
    pct_change <- (next_population_density / previous_population_density) - 1
    if (pct_change < min_pct_change) {
      early_stop = TRUE
      cat("\nStopping Optimization")
    } else {
      cat(paste0("\nMean Density = ", next_population_density))
    }
  }
  return(population)
}
