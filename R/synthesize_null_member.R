#' \code{synthesize_null_member}
#'
#' Worker function. Called by \code{synthesizeNullMembers}, not intended to be
#' called by the user.
#'
#' @param locus A \code{Locus} object
#' @param pf_data A \code{PFData} object
#' @return A \code{Locus} object with the null member slot filled
#'
synthesize_null_member <- function(locus, pf_data) {
  # Scan the vector of na-omitted locus true members and replace each value with
  # a member of the same degree bin with respect to the total STRING network.
  null_members <- c()
  for (i in 1:length(locus@true_members)) {
    null_members <- c(null_members, resample_from_bin(
      pf_data@degree_info,
      candidate_gene = locus@true_members[i],
      size = 1
    ))
  }
  locus@null_members <- null_members
  return(locus)
}
