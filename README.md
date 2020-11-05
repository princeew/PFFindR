# PFFindR: Prix Fixe network Finder in R

## Motivation

## Installation

This package is available for download on [github](https://github.com/princeew/PFFindR). 
The easiest way to accomplish this is to install the package from the R console:

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


### R Console Usage

```
  library(PFFindR)
  
  # Load a PFData object
  pf_data <- PFDataLoader(
      "../app/preloaded_data/FA_loci.txt",
      "../app/preloaded_data/Day3_STRING.txt")
  
  # Generate population of subnetworks
  population <- initializePopulation(
      pf_data = pf_data, 
      population_size = 100, 
      members = "true_members")
  
  # Evaluate population significance
  population_significance <- evaluatePopulationSignificance(
      pf_data = pf_data,
      population = population,
      num_trials = 100)
      
  # Calculate the gene scores from the top network
  top_network <- getTopNetwork(population)
  scores <- calculateGeneScores(top_network, pf_data)
  
  # Visualize the gene scores (will open a plot)
  viewGeneScores(PF_FanconiAnemia, getTopNetwork(population), scores)
  
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

### Command Line Usage Example

#### Advanced Usage Options

```
  usage: ./R/examples/basic_run.R [-h]
                       [--use_FA_data] [--loci_data LOCI_DATA]
                       [--cfn_data CFN_DATA] [--population_size POPULATION_SIZE]
                       [--null_trials NULL_TRIALS]
                       [--save_gene_score_plot SAVE_GENE_SCORE_PLOT]
                       [--gene_score_plot_path GENE_SCORE_PLOT_PATH]
                       [--uninstall_after]

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
    --null_trials NULL_TRIALS
                          The number of random trials to evaluate for the null
                          distribtuion to determine population significance.
                          [default "50"]
    --save_gene_score_plot SAVE_GENE_SCORE_PLOT
                          Save the results from viewGeneScores. [default "True"]
    --gene_score_plot_path GENE_SCORE_PLOT_PATH
                          Path to save the gene score visualizations. [default
                          "./PFFinderGeneScores.png"]
    --uninstall_after     Uninstall PFFindR after running this example. [default
                          "True"]
```

## Preloaded Data

## Example Output

## Troubleshooting
