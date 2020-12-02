# PFFindR: Prix Fixe network Finder in R

## Motivation

The purpose of this software is to provide an R implementation of the methodology 
proposed by [Tasan et al. (2015)](https://www.nature.com/articles/nmeth.3215).
Specifically, this method seeks to identify Prix Fixe (i.e., fixed price) dense
subnetworks of genes in linkage disequillibrium with disease-associated tagSNPs.
These subnetworks are identified heuristically using a simple genetic algorithm.

## Installation

This package is available for download on [github](https://github.com/princeew/PFFindR)
and was built under R version 3.6.1. The easiest way to accomplish this is to 
install the package from the R console:

```
library(devtools)
install_github("princeew/PFFindR")
```

Alternatively, you can clone the repository and manually install the package yourself.

```
cd <location/to/store/package>
git clone princeew/PFFindR
R -e "install.packages("./PFFindR", repos=NULL, source=TRUE)"
```

**NOTE:** If you are only interested in running the example script to test the software,
the PFFindR package will be automatically installed, executed, and uninstalled.
This behavior can be modified using the command line options (see Command Line
Usage Example below).

### Uninstall PFFindR

To uninstall PFFindR run `remove.packages("PFFindR")` from your R console.

## Usage

### Required Input Files and Formats

PFFindR requires two separate input files. The first is a GMT file containing
the loci information. It is expected that the first column is a metalabel, the 
second column is a locus ID, and every subsequent column are genes for each locus.
It is expected that there is no header information in this file.

The second file is the interaction information and it is expected to be a tab-
delimited file with the first two columns giving the gene interaction pairs and
the third column is the weight for the interaction. It is expected that there is 
no header information in this file.

### Command Line Usage Example

```
  usage: ./PFFindR/scripts/PFFind.R [-h] [--use_FA_data] [--loci_data LOCI_DATA]
                [--cfn_data CFN_DATA] [--population_size POPULATION_SIZE]
                [--weighted_network] [--mutation_rate MUTATION_RATE]
                [--optimizer_stop_threshold OPTIMIZER_STOP_THRESHOLD]
                [--plot_fitness PLOT_FITNESS]
                [--plot_fitness_path PLOT_FITNESS_PATH]
                [--save_gene_scores SAVE_GENE_SCORES]
                [--gene_scores_path GENE_SCORES_PATH]
                [--null_trials NULL_TRIALS] [--num_to_save NUM_TO_SAVE]
                [--save_network SAVE_NETWORK] [--network_path NETWORK_PATH]
                [--random_seed RANDOM_SEED] [--uninstall_after]

optional arguments:
  -h, --help            show this help message and exit
  --use_FA_data         Use the example PF_FanconiAnemia dataset. Overrides
                        --loci_data and --cfn_data [default "False"]
  --loci_data LOCI_DATA
                        Path to tab delimented loci data (i.e., a GMT file).
  --cfn_data CFN_DATA   Path to tab delimted co-function network data.
  --population_size POPULATION_SIZE
                        The number of subnetworks to consider in a population.
                        [default "10"]
  --weighted_network    Use weighted edges instead of binary. [default
                        "False"]
  --mutation_rate MUTATION_RATE
                        The percent (in decimal form) for which to mutate loci
                        in networks. [default "0.05"]
  --optimizer_stop_threshold OPTIMIZER_STOP_THRESHOLD
                        The minimum percent improvement to continue
                        optimization. [default "0.05"]
  --plot_fitness PLOT_FITNESS
                        Whether to plot the fitness during evolution.
  --plot_fitness_path PLOT_FITNESS_PATH
                        File path for where to store optimizer performance
                        plot. [default "./PFFindR_Search_Performance.png"]
  --save_gene_scores SAVE_GENE_SCORES
                        Whether to save gene scores or not. [default "True"]
  --gene_scores_path GENE_SCORES_PATH
                        File path for where to store gene scores as GMT file.
                        [default "./Day3_Output.gmt"]
  --null_trials NULL_TRIALS
                        The number of random trials to evaluate for the null
                        distribtuion to determine population significance.
                        [default "50"]
  --num_to_save NUM_TO_SAVE
                        The number of networks to save to disk. [default "10"]
  --save_network SAVE_NETWORK
                        Boolean whether to save network findings. [default
                        "True"]
  --network_path NETWORK_PATH
                        File path for where to save networks. Note: using the
                        template *_Network_pval.txt will result in a modified
                        file name with network ID number and p-value for
                        population. [default "./Day3_Output_Network_pval.txt"]
  --random_seed RANDOM_SEED
                        random number generator seed (for reproducibility).
                        [default "42"]
  --uninstall_after     Uninstall PFFindR after running this example. [default
                        "True"]
```

### Output

There are three types of outputs generated by PFFindR:

1. A GMT file with loci genes and respective weights. Fields are tab-delimited and
gene scores are separated by genes with a space character. Any zero value is reported
as NA. For example:

Fanconi anemia locus 0	Locus for PALB2	NUPR1 NA	CTB-134H23.2 NA
Fanconi anemia locus 2  Locus for RAD51C, BRIP1   PRKCA 3	FTSJ3 NA	TBX4 NA

2. A GMT file for each reported network (i.e., `num_to_save` variable above). For example:

ZNF788	TSSK4	0.182120
RUVBL2	RRAGC	0.667000
SNRNP70	BRIX1	0.286122

3. A png image file with optimization performance metrics. Specifically, a line plot
of mean population density over optimizer generations.

### --- Alternative Usage ---
### R Console

```
library(PFFindR)

# Load a PFData object
pf_data <- PFDataLoader(
    "../app/preloaded_data/FA_loci.txt",
    "../app/preloaded_data/Day3_STRING.txt")

# Run Optimizer
## This example will save all values to files.
population <- findPFNetworks(pf_data,
                             population_size = 500,
                             binary = FALSE,
                             mutation_rate = 0.05,
                             optimizer_stop_threhsold = 0.05,
                             plot_fitness = TRUE,
                             plot_fitness_path = "./pffinder_search_performance.png",
                             save_gene_scores = TRUE,
                             gene_scores_path ="./Day3_Output.gmt",
                             p_val_trials = 100,
                             num_to_save = 10,
                             save_network = TRUE,
                             network_path = "./Day3_Output_Network_pval.txt")

# Save the workspace
save.image()
```

#### Package Documentation

Rich documentation exists for all major functions in the PFFindR package and can
be accessed using the native R methodology. For example, the `initializePopulation`
function documentation can be obtained using either of the following two
(equivalent) commands within the R console:

```
  help(initializePopulation)
  ?initializePopulation
```

## Preloaded Data

This package comes preloaded with an example dataset built using 12 loci, each 
comprised of up to 46 genes, that are associated with the disease Fanconi Anemia,
and a co-function network built using the [STRING database](https://string-db.org).
It can be accessed by the handle `PF_FanconiAnemia`.


## Troubleshooting

Please report any issues, comments, or questions to Eric Prince via
email Eric.Prince@CUAnschutz.edu, or [file an issue](https://github.com/princeew/PFFindR/issues).
