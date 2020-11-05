#' An S4 class to represent a Locus
#'
#' @slot locus_id a character to label the locus (derived from the 2nd column of the loci data).
#' @slot true_members a character vector containing the true members of the locus
#' @slot null_members a character vector containing bin-matched null members for significance testing.
#' @slot cardinality an integer for the length of genes within the locus
#'
setClass("Locus",
         slots = list(
           locus_id  = "character",
           true_members = "character",
           null_members = "character",
           cardinality = "numeric"
         ))
