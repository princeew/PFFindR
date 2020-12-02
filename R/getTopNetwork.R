#' Extract the top network from a population
#'
#' Identify and return the top network (as determined by the density) from a list
#' of \code{PrixFixeNetwork} objects.
#'
#' @param population a list of \code{PrixFixeNetwork} objects
#' @param multiple a Boolean on whether to return multiple top networks.
#' @param n integer for how many networks to return if multiple==TRUE
#' @return a \code{PrixFixeNetwork} object
#'
#' @examples
#' \dontrun{
#' # load example PFData (FA genes)
#' data(PF_FanconiAnemia)
#' # generate population of subnetworks
#' population <- initializePopulation(PF_FanconiAnemia, population_size=100, "true_members")
#' # extract top network
#' top_network <- getTopNetwork(population)
#' }
#'
getTopNetwork <- function(population, multiple = FALSE, n = 10) {
  # Extract the top network (or networks) from the population based on density.
  densities <- getNetworkDensity(population, return_mean = FALSE)
  top_network_index <- grep(max(densities), densities)

  # If only a single result requested and multiple top networks exist, select
  # the first index in the list.
  if (!multiple & length(top_network_index) > 1) {
    top_network_index <- top_network_index[1]
    return(population[[top_network_index]])
  } else if (!multiple & length(top_network_index) == 1){
    return(population[[top_network_index]])
  } else {
    top_network_index <- sort(densities, decreasing = TRUE)[1:n]
    return(population[top_network_index])
  }

}
