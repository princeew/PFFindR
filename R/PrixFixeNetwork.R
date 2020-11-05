#' An S4 class to represent a PrixFixeNetwork
#'
#' @slot loci character vector of locus_ids
#' @slot genes character vector of selected genes for each locus
#' @slot adjacency_matrix A matrix containing the adjacency information for the subnetwork
#' @slot s_i_star Numeric selection score
#'
setClass("PrixFixeNetwork",
         slots = list(
           loci = "character",
           genes = "character",
           adjacency_matrix = "list",
           s_i_star = "numeric"))
