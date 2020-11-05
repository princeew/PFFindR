#' \code{resample_from_bin}
#'
#' Worker function to resample genes from loci to create the null model.
#' Not intended to be called by user.
#'
#' @param degree_info A tibble containing the CFN degree information
#' @param candidate_gene The gene that is to be resampled (i.e., the true locus gene)
#' @param size the number of genes to sample from the CFN
#' @return resampled genes
#'
resample_from_bin <- function(degree_info, candidate_gene,  size = 1) {
  # resample genes n=size times based on which bin the candidate_gene belongs to.

  bin <- degree_info %>%
    filter(gene == candidate_gene) %>%
    select(bin) %>%
    unlist() %>%
    unique() %>%
    as.character()

  possible_genes <- degree_info %>%
    filter(bin == bin) %>%
    select(gene) %>%
    unlist() %>%
    as.character()

  resampled_genes <- sample(possible_genes, size = size, replace = FALSE)
  return(resampled_genes)
}
