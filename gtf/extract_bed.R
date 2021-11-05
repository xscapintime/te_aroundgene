# export gtf as bed-like format
# -----------------------------

rm(list = ls())

library(tidyverse)


## gene lists
up <- read.table("../data/Archive/WTvsKO.up.tsv", header = T, sep = "\t")
dn <- read.table("../data/Archive/WTvsKO.dn.tsv", header = T, sep = "\t")
total <- read.table("../data/genes_ntc_expression.tsv/genes_ntc_expression.tsv", header = T, sep = "\t")


up_gn <- up$X
dn_gn <- dn$X
total_gn <- total$ensg


## gtf converted bed
gene_bed <- read.table("ensembl_gtf_gene.bed")

## get gene position
up_bed <- gene_bed %>% filter(V4 %in% up_gn)
dn_bed <- gene_bed %>% filter(V4 %in% dn_gn)
total_bed <- gene_bed %>% filter(V4 %in% total_gn)

setdiff(up_gn, up_bed$V4)
setdiff(dn_gn, dn_bed$V4)
setdiff(total_gn, total_bed$V4)


## add "chr" to seqname
up_bed$V1 <- paste0("chr", up_bed$V1)
dn_bed$V1 <- paste0("chr", dn_bed$V1)
total_bed$V1 <- paste0("chr", total_bed$V1)


## export to bed
write.table(up_bed, "up_gene.bed", sep = "\t", quote = F, row.names = F, col.names = F)
write.table(dn_bed, "dn_gene.bed", sep = "\t", quote = F, row.names = F, col.names = F)
write.table(total_bed, "total_gene.bed", sep = "\t", quote = F, row.names = F, col.names = F)