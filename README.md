# cpg_annotate
A small R script to provide quick annotation and gene lists for series of IlmnID's (450k probes). Currently working on a version to include support for 850k arrays. 

**Note:** There is a hg38 updated slimmed down annotation file available for the 850k array (`IlluminaEPIC_annotation_hg38.RDS`).

## example usage

Either clone or download this repository, ensure the `Ilmn450K_anno.RDS` file is in the same directory as the R script (`cpg_annotate.R`).

This has currently been tested on Linux, but should work on any system with R installed.

```R
Rscript cpg_annotate.R reinius_beta_CD8T.txt
```

*Note: the above text file `reinius_beta_CD8T.txt` has been included in this repository for testing purposes.*

## other bed files

Added a selection of potential useful bed files that were generated during the development of this script.

  - added original bed file for 450k probes lifted over to hg38 with dbSNP info
  - added a custom bed of hg38 UCSC gene symbols
  - created a bed which intersects the above two files generating a hg38 version with UCSC genes (hg38), rather than the original hg19 UCSC genes from the Illimina annotation. Build process:
    + `bedmap --echo --echo-map-id-uniq illumina450k_annotation_cpgsnps_hg38_all_sorted.bed ucsc_genes/hg38_ucsc_all_refgenes_sorted.bed | tr '|' '\t' > illumina450k_annotation_cpgsnps_hg38_ucscgenes_sorted.bed`
    + `bgzip illumina450k_annotation_cpgsnps_hg38_ucscgenes_sorted.bed`
    + `tabix illumina450k_annotation_cpgsnps_hg38_ucscgenes_sorted.bed.gz`

## To do

  - ~~add Illumina EPIC 850k annotation~~
  - modify `cpg_annotate` to work for both 450k and 850k
  - ~~add hg38 position and SNP information to annotation file~~
  - ~~add UCSC hg38 referecnce gene symbols from custom bed~~
  - add exit before further evaluation if no file is provided
  - further tidy up script
