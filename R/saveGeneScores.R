saveGeneScores <- function(scores, pf_data, save_path) {

  # Collect mean value of of each gene's score
  scores <- colMeans(bind_rows(scores))

  for (i in 1:length(scores)) {
    pf_data <- .update_gene_entry(names(scores)[i], scores, pf_data)
  }
  # Save the dataframe in GMT format
  pf_data@loci_dataframe %>%
    write_delim(save_path, delim = "\t",col_names = FALSE)
}

.update_gene_entry <- function(gene, scores, pf_data) {
  # Find and replace entry in loci data_frame with "Gene SCORE"
  pf_data@loci_dataframe <- pf_data@loci_dataframe %>%
    mutate_all(function(x) ifelse(x == gene, paste0(gene, " ", scores[[gene]]), x))
  return(pf_data)
}


