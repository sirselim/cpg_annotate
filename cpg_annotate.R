#!/usr/bin/env Rscript
# Author:         Miles Benton
# created:        03-06-210
# last modified:  13-06-210
# cpg_annotate.R -- cleans and formats CpG data for annotation and pathways

# capture argument from bash/terminal
arguments <- commandArgs(trailingOnly = TRUE)
# check to ensure a file has been specified
try(if(length(arguments) < 1) 
  paste("...please select a file of CpG sites to annotate...")
  # stopifnot(length(arguments) < 1)
  )
# make the above exit out before evaluating the rest
for (i in 1:length(arguments)) {
  print(paste("...annotating CpGs from file", "=", arguments[i]))
}
# define date, file, input, output etc
filename <- arguments[1]
samplename <- filename
samplename <- gsub('.txt', '', samplename)
# read in cpg data
data <- read.table(file = filename, head = F)
cpgs <- as.character(as.matrix(data[1]))
# read subset of Illumina 450K annotation
ilmn450.anno <- readRDS(file = 'Ilmn450K_anno.RDS')
# get annotation for identified cpgs
ilmn450.anno <- ilmn450.anno[ilmn450.anno$IlmnID %in% as.character(cpgs), 
                          c('IlmnID', 'CHR', 'MAPINFO', 'UCSC_RefGene_Name', 'UCSC_RefGene_Group')]
# clean up the gene and feature fields
ilmn450.anno$UCSC_RefGene_Name <- sapply(sapply(strsplit(ilmn450.anno$UCSC_RefGene_Name, ";"), unique), paste, collapse = ";")
ilmn450.anno$UCSC_RefGene_Group <- sapply(sapply(strsplit(ilmn450.anno$UCSC_RefGene_Group, ";"), unique), paste, collapse = ";")
# write out limited annotation
print(paste("...writing annotation..."))
write.csv(ilmn450.anno, paste0(samplename, '_450anno.csv'), row.names = F)
# write out gene list
print(paste("...writing gene list..."))
gene.list <- sort(unique(unlist(strsplit(ilmn450.anno$UCSC_RefGene_Name, split = ';'))))
write.table(gene.list, paste0(samplename, '_genelist.csv'), row.names = F, quote = F, sep=",",  col.names=FALSE)
# done
print(paste("...done..."))
##\END