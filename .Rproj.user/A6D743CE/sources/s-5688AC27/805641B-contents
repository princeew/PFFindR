#' \code{getNetworkDensity}
#'
#' Worker function to extract density information for a population of PrixFixeNetworks.
#' Not intended to be called by user. Called by \code{evaluePopulationSignificance}.
#'
#' @param population a list of \code{PrixFixeNetwork} objects
#' @param return_mean Boolean of whether to return the mean or the vector of network densities. Default is TRUE.
#' @return Mean density value if \code{return_mean=TRUE}, else a vector of density values
#'
getNetworkDensity <- function(population, return_mean = TRUE) {
  # Iterate over population and collect density values to average
  densities <- foreach(n=population, .combine = "c") %dopar% {
    return(n@s_i_star ** (1/3)) # s_i_star = density^3
  }
  if (return_mean) {
    return(mean(densities))
  } else {
    return(densities)
  }
}
