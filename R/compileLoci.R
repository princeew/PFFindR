#' \code{compileLoci}
#'
#' Reformat the loci data from tibble into a list of \code{Locus} objects. Called
#' within \code{PFDataLoader} and not intended to be called by user.
#'
#' @param loci_data A tibble containing the raw loci information provided by \code{loadLociData}.
#' @return A list of \code{Locus} objects
#'
compileLoci <- function(loci_data) {
  # Generate a list of Locus objects from the loci_dataframe

  # For each locus, create a new Locus class object and add it to a list.
  loci <- loci_data$locusID
  loci_list <- list()
  for (i in 1:length(loci)) {

    # Isolate the true members associated with a locus (remove NAs)
    true_members <- as.character(
      na.omit(unlist(loci_data[i,3:ncol(loci_data)])))

    # Append `loci_list` with a new Locus object
    loci_list[[i]] <- new(
      "Locus",
      locus_id = loci[i],
      true_members = true_members,
      cardinality = length(true_members)
    )
  }
  return(loci_list)
}
