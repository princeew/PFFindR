library(argparse)
devtools::load_all()

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
  parser$add_argument("--weighted_network", action = "store_true", default = FALSE,
                      help = "Use weighted edges instead of binary. [default \"%(default)s\"]")
  parser$add_argument("--mutation_rate", type = "double", default = 0.05,
                      help = "The percent (in decimal form) for which to mutate loci in networks. [default \"%(default)s\"]")
  parser$add_argument("--optimizer_stop_threshold", type = "double", default = 0.05,
                      help = "The minimum percent improvement to continue optimization. [default \"%(default)s\"]")
  parser$add_argument("--plot_fitness", type = "logical", default = TRUE,
                      help = "Whether to plot the fitness during evolution.")
  parser$add_argument("--plot_fitness_path", type = "character", default = "./PFFindR_Search_Performance.png",
                      help = "File path for where to store optimizer performance plot. [default \"%(default)s\"]")
  parser$add_argument("--save_gene_scores", type = "logical", default = TRUE,
                      help = "Whether to save gene scores or not. [default \"%(default)s\"]")
  parser$add_argument("--gene_scores_path", type = "character", default = "./Day3_Output.gmt",
                      help = "File path for where to store gene scores as GMT file. [default \"%(default)s\"]")
  parser$add_argument("--null_trials", type = "integer", default = 50,
                      help = "The number of random trials to evaluate for the null distribtuion to determine population significance. [default \"%(default)s\"]")
  parser$add_argument("--num_to_save", type = "integer", default = 10,
                      help = "The number of networks to save to disk. [default \"%(default)s\"]")
  parser$add_argument("--save_network", type = "logical", default = TRUE,
                      help = "Boolean whether to save network findings. [default \"%(default)s\"]")
  parser$add_argument("--network_path", type = "character", default = "./Day3_Output_Network_pval.txt",
                      help = "File path for where to save networks. Note: using the template *_Network_pval.txt will result in a modified file name with network ID number and p-value for population. [default \"%(default)s\"]")
  parser$add_argument("--random_seed", type = "integer", default = 42,
                      help = "random number generator seed (for reproducibility). [default \"%(default)s\"]")
  parser$add_argument("--uninstall_after", action = "store_true", default = TRUE,
                      help = "Uninstall PFFindR after running this example. [default \"%(default)s\"]")
  args <- parser$parse_args()
  return(args)
}

main <- function(args) {

  set.seed(args$random_seed)

  if (args$use_FA_data) {
    pf_data <- PF_FanconiAnemia
  } else {
    pf_data = PFDataLoader(loci_data_path = args$loci_data,
                           cfn_data_path = args$cfn_data)
  }

  findPFNetworks(pf_data = pf_data,
                 population_size = args$population_size,
                 binary = !args$weighted_network,  # NOT weighted_network
                 mutation_rate = args$mutation_rate,
                 optimizer_stop_threshold = args$optimizer_stop_threshold,
                 plot_fitness = args$plot_fitness,
                 plot_fitness_path = args$plot_fitness_path,
                 save_gene_scores = args$save_gene_scores,
                 gene_scores_path = args$gene_scores_path,
                 p_val_trials = args$null_trials,
                 save_network = args$save_network,
                 network_path = args$network_path)
}

main(load_arguments())
