# export gtf as bed-like format
# -----------------------------

rm(list = ls())

library(tidyverse)

if(!require(GenomicRanges)){
    BiocManager::install("GenomicRanges")
    library(GenomicRanges)
}

gtf_tb <- read.csv("Mus_musculus.GRCm39.104.gtf", sep = "\t", header = F, comment.char = "#")

colnames(gtf_tb) <- c("seqname", "source", "feature", "start", "end", "score", "strand", "frame", "attributes")

genes <- gtf_tb[gtf_tb$feature == "gene",]

extract_attributes <- function(gtf_attributes, att_of_interest){
    att <- strsplit(gtf_attributes, "; ")
    att <- gsub("\"","",unlist(att))
    if(!is.null(unlist(strsplit(att[grep(att_of_interest, att)], " ")))){
        return( unlist(strsplit(att[grep(att_of_interest, att)], " "))[2])
    }else{
        return(NA)}
}

genes$gene_id <- unlist(lapply(genes$attributes, extract_attributes, "gene_id"))


## export to bed format
gene_bed <- genes %>% select(seqname, start, end, gene_id, strand)

write.table(gene_bed, "ensembl_gtf_gene.bed", sep = "\t", quote = F, row.names = F, col.names = F)