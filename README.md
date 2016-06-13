# cpg_annotate
A small R script to provide quick annotation and gene lists for series of IlmnID's (450k probes)

## example usage

This has currently been tested on Linux, but should work on any system with R installed.

```R
Rscript cpg_annotate.R reinius_beta_CD8T.txt
```

*Note: the above text file `reinius_beta_CD8T.txt` has been included in this repository for testing purposes.*

## To do

  - add exit before further evaluation if no file is provided
  - further tidy up script
