#' \code{loadCFNData}
#'
#' Load co-function network data into memory. Called by \code{PFDataLoader}, not intended to be
#' directly invoked by user.
#'
#' @param path filepath to tab delimited input file containing CFN interactions and weights.
#' @return A formatted tibble with CFN information
#'
#'
loadCFNData <- function(path) {

  # load co-function network and check formatting
  cfn_data = read_data_func(path)

  # Check that there are 3 columns in the CFN data (gene A, gene B, weight).
  assert_that(ncol(cfn_data) == 3,
                          msg = "(load_cfn_dataframe) :: CFN dataframe does not
                          have 3 columns. Check CFN input filepath and formatting.")

  # Check for correct types
  assert_that(all(sapply(cfn_data[,1:2], class) == "character"),
                          msg = "(load_cfn_dataframe) :: CFN dataframe columns 1
                          and/or 2 are not of type `character`. Check CFN file
                          formatting.")

  assert_that(typeof(unlist(cfn_data[,3])) == "double",
                          msg = "(load_cfn_dataframe) :: the weight column
                          (column 3) of the CFN file is not type `double`. Check
                          CFN file formatting.")

  # Check that the CFN data contains at least 2 rows ().
  # TODO: Check into what the actual minimum number of rows needed is
  assert_that(nrow(cfn_data) > 1,
                          msg = "(load_cfn_dataframe) :: CFN data provided does not
                          have at least 2 rows. Check that you have selected the
                          correct input and that is in the correct format.")

  return(cfn_data)

}
