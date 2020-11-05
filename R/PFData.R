#' An S4 class for storing the input dataset for PrixFixeNetwork generation
#'
#' @slot loci_data_path character path to file containing the loci data
#' @slot cfn_data_path character path to file containing the co-function network data
#' @slot loci_data list of \code{Locus} objects
#' @slot loci_dataframe a tibble for storing the loci data
#' @slot cfn_data a tibble for storing the co-function network data
#' @slot degree_info a tibble for storing the gene interaction degree information
#'
setClass("PFData",
         slots = list(
           loci_data_path = "character",
           cfn_data_path = "character",
           loci_data = "list",
           loci_dataframe = "tbl",
           cfn_data = "tbl",
           degree_info = "tbl"
         ))
