#' Calculate the Prix Fixe gene score
#'
#' Evaluate the gene contributions to a given subnetwork.
#'
#' @section Scoring Methodology:
#' To score a gene contribution to a subnetwork we first calculate the null locus
#' scenario in which we remove, or zero out, a given locus and calculate the
#' density of the resulting network. Next, we iteratively consider all genes
#' associated with that locus by substituting and caculating the density. The
#' difference between each gene density and the empty locus density is the score
#' for that gene. If the gene has no connectivity to the subnetwork, then we give
#' it an \code{NA} value.
#'
#' To implement this method we simplify the problem. First, we are only considering
#' one locus at a time and therefor all other loci remain constant and can be
#' ignored here. Due to this, the null locus density must be zero because there
#' is no connectivity by definition. Therefore, the only value we need to derive
#' is the sum of the connections between the permuted gene and the other fixed
#' loci.
#'
#' Moreover, to quickly calculate the contributions we create a copy of a network
#' and modify the genes to include the network genes and all genes associated
#' with a given locus. The adjacency matrix is then recalculated, and filtered
#' such that the rows only contain the locus genes and the columns are the network
#' genes. The contribution for each one of the locus genes is then calculated
#' as the corresponding row sum.
#'
#' @param network A \code{PrixFixeNetwork}. Probably selected using \code{getTopNetwork}.
#' @param pf_data A \code{PFData} object.

calculateGeneScores <- function(network, pf_data) {
  # Create a progress bar
  dopar_progress_bar <- make_progress_bar(length(pf_data@loci_data))
  # For each locus, score the associated genes in the context of the network
  scored_loci <- foreach (locus=pf_data@loci_data, .combine = "list") %dopar% {
    scores <- .scoreGenes(network, locus, pf_data)
    return(scores)
  }
  return(unlist(scored_loci))
}


.scoreGenes <- function(network, locus, pf_data) {
  # Score genes for a given locus and network.

  # Leverage the methods I've already implemented. Copy the network, modify
  # the genes to contain all network genes and all genes for a locus, recalculate
  # the adjacency matrix and collect the contributions of each gene
  network_copy <- network
  network_copy@genes <- unique(c(network_copy@genes, locus@true_members))
  network_copy <- calculateAdjacencyMatrix(network_copy, pf_data)

  # Isolate the adjacency matrix and filter.
  # Rows = genes associated with the locus
  # Columns = genes associated with the prix fixe network (i.e., other loci)
  A <- network_copy@adjacency_matrix
  A <- A[locus@true_members, network@genes]

  # Important: Remove any interactions with the network gene for that locus
  # (i.e., zero the matrix column corresponding to that locus).
  A[,grep(locus@locus_id, network@loci)] <- 0

  # Collect the sum of interactions between each locus gene and the genes
  # identified within the network.
  scores <- rowSums(A)

  # Per the methods in Tasan et al (2015), any gene not connected to the subnetwork
  # receives a score of NA.
  scores <- ifelse(scores > 0, scores, NA)
  return(scores)
}

# Unnecessary...
# .getEmptyLocusDensity <- function(locus, network) {
#   # Helper function to create an empty locus in the adjacency matrix and
#   # returns the density of the subnetwork.
#   empty_locus <- network@adjacency_matrix
#   # zero out the row; do not have to zero out the corresponding column
#   # because I am using the rowsums for degrees.
#   empty_locus[grep(locus, network@loci),] <- 0
#   empty_locus_density <- sum(rowSums(empty_locus))
#   return(empty_locus_density)
# }
