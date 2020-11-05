#!/usr/bin/env Rscript
basic_run <- function(args) {
  # Basic example template to run PFFindR

  # If no args provided, run with the preloaded FA dataset
  if (all(is.na(args))) {
    cat("Loading Example Dataset...")
    t_s <- Sys.time()
    pf_data <- PF_FanconiAnemia
    cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))
  } else {
    # otherwise use the args to build a dataset
  }


  # Initialize the population of subnetworks
  cat("\nInitializing Population...")
  t_s <- Sys.time()
  population <- initializePopulation(pf_data, population_size = 10, "true_members")
  cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

  # Calculate the p-value of the population
  cat("\nCalculating Significance of Population...")
  t_s <- Sys.time()
  p_value <- evaluatePopulationSignficance(pf_data, population, 10)
  cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

  # Calculate the gene scores from the top network
  cat("\nCalculating Gene Scores from Top Network...")
  t_s <- Sys.time()
  top_network <- getTopNetwork(population)
  scores <- calculateGeneScores(top_network, pf_data)
  cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

  # Visualize the gene scores
  cat("\nVisualizing Gene Scores...")
  t_s <- Sys.time()
  viewGeneScores(PF_FanconiAnemia, getTopNetwork(population), scores)
  cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))

  cat("Saving and Exiting...")
  t_s <- Sys.time()
  ggplot2::ggsave("~/Desktop/genescores.png", width = 25, height = 20, units="in")
  save.image()
  cat(paste0("\n\tDone. Time Elapsed=", round(as.numeric((Sys.time()-t_s)), 2), " s"))
}

main <- function() {
  check_and_maybe_install_dependencies()
  args <- load_arguments()
}

check_and_maybe_install_dependencies <- function() {
  # Install PFFindR if not already present
  if (!is.element("PFFindR", installed.packages()[,1])) {
    devtools::install_github("princeew/PFFindR")
  }

  # Check for argparser
  if (!is.element("argparse", installed.packages()[,1])) {
    install.packages("argparse")
  }

  # load packages
  suppressPackageStartupMessages(library("argparse"))
  library("PFFindR")
}

load_arguments <- function() {
  # Command line argument handling
  parser <- ArgumentParser()
  parser$add_argument("--use_FA_data", action = "store_true", default = FALSE,
                      help = "Use the example PF_FanconiAnemia dataset. Overrides --loci_data and --cfn_data [default \"%(default)s\"]")
  parser$add_argument("--loci_data", type = "character",
                      help = "Path to tab delimented loci data (i.e., a GMT file).")
  parser$add_argument("--cfn_data", type = "character",
                      help = "Path to tab delimted co-function network data.")
  parser$add_argument("--population_size", type = "integer", default = 10,
                      help = "The number of subnetworks to consider in a population. [default \"%(default)s\"]")
  parser$add_argument("--null_trials", type = "integer", default = 50,
                      help = "The number of random trials to evaluate for the null distribtuion to determine population significance. [default \"%(default)s\"]")
  parser$add_argument("--save_gene_score_plot", type = "logical", default = TRUE,
                      help = "Save the results from viewGeneScores. [default \"%(default)s\"]")
  parser$add_argument("--gene_score_plot_path", type = "character", default = "./PFFinderGeneScores.png",
                      help = "Path to save the gene score visualizations. [default \"%(default)s\"]")
  parser$add_argument("--uninstall_after", action = "store_true", default = TRUE,
                      help = "Uninstall PFFindR after running this example. [default \"%(default)s\"]")
  args <- parser$parse_args()
  return(args)
}

main()


# Load required input data
# pf_data <- PFDataLoader(
#   "../app/preloaded_data/FA_loci.txt",
#   "../app/preloaded_data/Day3_STRING.txt")


