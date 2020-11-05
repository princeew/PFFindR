#' \code{read_data_func}
#'
#' Sipmle wrapper function for reading the target loci. Called by
#' \code{\link{loadLociData}} and `loadCFNData` within `PFDataLoader`, not meant to invoked
#' by user.
#'
#' @param path filepath to tab delimited input file
#' @return A tibble
#'

read_data_func <- function(path) {

  # Stop if path variable is not string and not NA.
  stopifnot(is.character(path) && !is.na(path))

  return(read_delim(path, delim = "\t", col_names = FALSE))
}
