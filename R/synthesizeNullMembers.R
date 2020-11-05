#' \code{synthesizeNullMembers}
#'
#' Worker function. Called by \code{evaluatePopulationSignificance}, not intended to be
#' called by the user.
#'
#' @param pf_data A \code{PFData} object
#' @return A \code{PFData} object with completed loci_data
#'
synthesizeNullMembers <- function(pf_data) {
  # Update list of Locus objects with randomized null hypothesis values
  loci = foreach (locus=pf_data@loci_data) %dopar%
    synthesize_null_member(locus, pf_data)
  pf_data@loci_data <- loci
  return(pf_data)
}
