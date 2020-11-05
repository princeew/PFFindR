#' Visualize gene contribution scores for a Prix Fixe network
#'
#' @param pf_data A \code{PFData} object. Note: Loci within PFData must have gene
#' score values calculated. To do this, one can run \code{calculateGeneScores}.
#' @param network A \code{PrixFixeNetwork}. Probably selected using \code{getTopNetwork}.
#' @param scores score values return from \code{calculateGeneScore}.
#'
viewGeneScores <- function(pf_data, network, scores=NA) {

  if (!is.na(scores)) {
    gene_score_plot <- .plot_loci(pf_data, network, scores)
    return(gene_score_plot)
  } else {
    # If gene_scores do not exist, then raise an error
    simpleError("No gene_scores found in pf_data. First run calculateGeneScores
                before visualizing.")
  }
}

# Utility Functions
.plot_circle <- function(gene, fill, linetype) {
  # Plot a circle representing a gene, fill color represents the score.
  # All plot lines, legends, axes, and related text are removed.
  plot <- tibble("x"=runif(1),
                 "y"=runif(1)) %>%
    ggplot(aes(x0=x, y0=y, r=1)) +
    # ggforce::geom_circle
    geom_circle(fill=fill, linetype = linetype) +
    # ensure a perfect circle regardless of scaling
    coord_fixed() +
    geom_text(aes(mean(x), mean(y)), label = gene) +
    theme_void() +
    theme(legend.position = "none")
  return(plot)
}

.plot_locus <- function(locus, scores, network, n_col, color_palette) {

  # Get network gene for locus. This will be used to set the line type to easily
  # visualize what is actually in the subnetwork versus what is contributing
  # to the cohesiveness.
  network_gene <- network@genes[grep(locus@locus_id, network@loci)]

  plot_list <- list()
  for (gene in locus@true_members) {
    print(gene)
    gene_score <- as.numeric(scores[gene])
    has_gene_score <- !is.na(gene_score)
    if (has_gene_score) {
      linetype <- ifelse(gene == network_gene, "solid", "dashed")
      print(paste0("linetype=", linetype))
      print(paste0(gene, " has score"))
      plot_list[[gene]] <- .plot_circle(
        gene,
        # Since gene scores are integers starting with 1, they can be used as the
        # index for the color palette
        color_palette[gene_score],
        linetype)
    } else {
      plot_list[[gene]] <- .plot_circle("", "white", linetype = "dotted")
    }
  }
  # Make a title with the locus_id
  title <- ggdraw() + draw_label(locus@locus_id)

  # Plot the locus
  # setting ncol=n_col allows us to fix the length of each locus row
  locus_plot <- do.call("plot_grid",
                        c(plot_list, nrow = 1, ncol = n_col))

  # Combine title and plot
  locus_plot <- plot_grid(title, locus_plot,
                          nrow=2, rel_heights = c(0.1, 1),
                          align = "h", axis = "l")
  # return the locus_plot
  return(locus_plot)
}

.plot_loci <- function(pf_data, network, scores) {
  # Plot the set of loci (worker function)
  n_col <- foreach(locus=pf_data@loci_data, .combine = "max") %dopar%
    { locus@cardinality }

  # Build a palette for coloring. Using R Color Brewer blue-green
  # colorblind-safe palette
  unique_scores <- unique(scores)
  unique_scores <- unique_scores[!is.na(unique_scores)]
  color_palette <- brewer.pal(length(unique_scores), "BuGn")

  plot_list <- list()
  for (i in 1:length(network@loci)) {
    plot_list[[i]] <-  .plot_locus(
      pf_data@loci_data[[i]],
      unlist(scores),
      network,
      n_col,
      color_palette)
  }
  loci_plot <- do.call("plot_grid",
                       c(plot_list, ncol = 1))

  # Adding a legend
  # Linetype legend
  p1 <- .plot_circle("No Score", "white", "dotted")
  p2 <- .plot_circle("Contributing", "white", "dashed")
  p3 <- .plot_circle("In Network", "white", "solid")
  linetype_legend <- plot_grid(p1, p2, p3, nrow=1, labels="Membership")

  # Score legend
  plot_list <- list()
  for (i in 1:3) {
    plot_list[[i]] <- .plot_circle(i, color_palette[i], "blank")
  }
  score_legend<- do.call("plot_grid", c(plot_list, nrow=1, labels="Scores"))

  legend <- plot_grid(linetype_legend, score_legend, nrow=1)
  final_plot <- plot_grid(loci_plot, legend, nrow=2, rel_heights = c(1,0.1))
  return(final_plot)
}
