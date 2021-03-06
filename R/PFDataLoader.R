#' Build a \code{PFData} Object
#'
#' Loads data from input file paths and constructs a PFNData class object
#' comprised of a set of Locus class objects and associated data for analysis.
#'
#' @param loci_data_path character path for target loci data. This is expected to be a
#' tab-delimited file where the first column is a project metalabel, the
#' second column is the column is a descriptor for the loci, and each subsequent
#' column is a gene associated with the locus. Each row represents another locus
#' to consider.
#' @param cfn_data_path character path for the co-function network
#' @param bin A boolean on whether to bin degrees in the co-function network
#' @param n_bins Number of bins to separate degrees into (quantile based binning).
#'
#' @return A \code{PFData} object
#'
#' @examples
#' \dontrun{
#' pf_data <- PFDataLoader(
#' "../app/preloaded_data/FA_loci.txt",
#' "../app/preloaded_data/Day3_STRING.txt")
#' }
#'
PFDataLoader <- function(
  loci_data_path,
  cfn_data_path,
  bin = TRUE,
  n_bins = 128) {

  # -- Load Dataframes --
  loci_dataframe <- loadLociData(loci_data_path)
  cfn_dataframe <- loadCFNData(cfn_data_path)

  # -- Extract Degree Information --
  degree_info = getDegreeInfo(cfn_dataframe, bin, n_bins)

  # -- Build PFNData object --
  pf_data <- new("PFData",
                 loci_data_path = loci_data_path,
                 cfn_data_path = cfn_data_path,
                 loci_data = compileLoci(loci_dataframe),
                 loci_dataframe = loci_dataframe,
                 cfn_data = cfn_dataframe,
                 degree_info = degree_info)
  return(pf_data)
}
