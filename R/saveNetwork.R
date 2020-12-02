saveNetwork <- function(network, save_path) {
  # Extract indices to collapse matrix into long format (GMT)
  mat <- network@adjacency_matrix
  ind <- which(upper.tri(mat, diag = FALSE), arr.ind = TRUE)
  gmt_out <- as.data.frame(cbind(ind, mat[ind]))

  # Format file before saving
  gmt_out$row <- rownames(mat)[gmt_out$row]
  gmt_out$col <- rownames(mat)[gmt_out$col]
  gmt_out$V3 <- ifelse(gmt_out$V3 >0 , gmt_out$V3, NA)

  write_delim(gmt_out, save_path, delim = "\t")
}

