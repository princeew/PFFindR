#' \code{sampleLoci}
#'
#' Worker function to sample genes from loci in parallel.
#' Not intended to be directly implemented by the user.
#'
#' @param pf_data A \code{PFData} object
#' @param slot character identifying the slot to sample from
#' @return character vector of sampled values
#'
sampleLoci <- function(pf_data, slot="true_members") {
  # Randomly sample loci genes to construct Prix Fixe Network
  slot_values <- foreach (locus=pf_data@loci_data, .combine = "c") %dopar%
    sample(attr(locus, slot), size=1)
  return(slot_values)
}
