#' \code{calculateAdjacencyMatrix}
#'
#' Parallel calculate the adjacency matrix of a candidate network given the
#' co-function network. Called within \code{constructCandidateNetwork} and not
#' intended to be called by user directly.
#'
#' @param candidate_network A \code{PrixFixeNetwork} generated from \code{constructCandidateNetwork}
#' @param pf_data A \code{PFData} object generated from \code{PFDataLoader}
#' @return \code{candidate_network} with updated \code{adjancency_matrix} slot
#'
calculateAdjacencyMatrix <- function(candidate_network, pf_data) {

  # Build a dummy matrix to store the network
  size <- length(candidate_network@genes)
  adjacency_matrix <- data.frame(matrix(0, nrow = size, ncol = size),
                                 row.names = candidate_network@genes)
  names(adjacency_matrix) <- candidate_network@genes

  # Fill matrix with matches from the CFN data
  adjacency_matrix <- foreach (n=1:nrow(adjacency_matrix),
                               .combine = "rbind") %dopar% {
                                 .row_parser(adjacency_matrix, pf_data@cfn_data, n)
                               }

  # Format adjacency_matrix as dataframe with row/column namesrarrr
  adjacency_matrix <- as.data.frame(adjacency_matrix, row.names = candidate_network@genes)
  names(adjacency_matrix) <- candidate_network@genes
  candidate_network@adjacency_matrix <- adjacency_matrix

  # Add selection score (s_i_star = density ^ 3)
  candidate_network@s_i_star <- sum(rowSums(adjacency_matrix)) ** 3
  return(candidate_network)
}

.row_parser <- function(adjacency_matrix, cfn_data, n) {
  # Worker function to parallel compute adjacency matrix row. This is used inside the
  # `calculateAdjacencyMatrix` function.

  r <- foreach (m=1:ncol(adjacency_matrix), .combine = "c") %dopar% {
    geneA <- rownames(adjacency_matrix)[n]
    geneB <- names(adjacency_matrix)[m]
    sset <- cfn_data[(cfn_data$X1 == geneA & cfn_data$X2 == geneB),]
    if (nrow(sset) > 0) {
      return(1)
    } else {
      return(0)
    }
  }
  return(r)
}
