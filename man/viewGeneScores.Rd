% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/viewGeneScores.R
\name{viewGeneScores}
\alias{viewGeneScores}
\title{Visualize gene contribution scores for a Prix Fixe network}
\usage{
viewGeneScores(pf_data, network, scores = NA)
}
\arguments{
\item{pf_data}{A \code{PFData} object. Note: Loci within PFData must have gene
score values calculated. To do this, one can run \code{calculateGeneScores}.}

\item{network}{A \code{PrixFixeNetwork}. Probably selected using \code{getTopNetwork}.}

\item{scores}{score values return from \code{calculateGeneScore}.}
}
\value{
a ggplot object
}
\description{
Visualize gene contribution scores for a Prix Fixe network
}
