# Get TE family count matrix
# ---------------------------

rm(list = ls())

library(tidyverse)

file <- list.files("../gene_rmsk", pattern = "_rmsk.bed", full.names = T)

bed <- lapply(file, function(x) read.table(x, sep = "\t", header = F))

## group by TE family
fml <- lapply(bed, function(x) x %>% group_by(V5, V6) %>% summarise(count = n()) %>% mutate(te = paste0(V5, "_", V6)))

names(fml) <- unlist(lapply(file, function(x) strsplit(basename(x), "_")[[1]][1]))


## reduce to one

dat <- Reduce(function(x, y) merge(x, y, all = T, by = "te"), fml, accumulate=FALSE)
dat <- dat %>% select(te, count.x, count.y, count)
dat[is.na(dat)] <- 0

colnames(dat)[-1] <- names(fml)


## total gene length
gene_len <- read.table("../gtf/genegroup_len.txt", row.names = 1)


## TE count devide by gene len
for (n in colnames(dat)[2:4]) {
    dat[n] <- dat[n] / gene_len[n, ]
}


## log2fc against `total`
dat %>% mutate(dn_vs_to = (dn+1)/(total+1), up_vs_to = (up+1)/(total+1))
`

