#' \code{loadLociData}
#'
#' Load loci data into memory. Called by \code{PFDataLoader}, not intended to be
#' directly invoked by user.
#'
#' @param path filepath to tab delimited input file containing loci membership.
#' @return A formatted tibble with loci information
#'
#'
loadLociData <- function(path) {

  # load and check data format
  loci_data <- read_data_func(path)

  # Check that the loci data contains at least 3 columns (metalabel, locusID, gene1)
  # TODO: Check into what the actual minimum number of genes needed is
  assert_that(ncol(loci_data) >= 3,
                          msg = "(loadLociData) :: Loci data provided has less than 3 columns.
  Check that you have selected the correct input and that is in the correct format.")

  # Check that the loci data contains at least 2 rows (loci).
  # TODO: Check into what the actual minimum number of rows needed is
  assert_that(nrow(loci_data) > 1,
                          msg = "(loadLociData) :: Loci data provided does not
                          have at least 2 rows. Check that you have selected the
                          correct input and that is in the correct format.")

  # Check that the loci data is all the correct type (character)
  assert_that(all(sapply(loci_data, class) == "character"),
                          msg = "(loadLociData) :: Loci data contains input
                          columns that are not of type `character`. Please check
                           that the format of your loci data is correct.")
  names(loci_data) <- c("Metalabel", "locusID",
                        paste("Gene ", 1:(ncol(loci_data) - 2)))
  return(loci_data)
}
