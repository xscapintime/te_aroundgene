# heatmap of log2FC
# -----------------

rm(list = ls())

library(tidyverse)


### logFC
log1pfc <- read.table("TE-updnstrm_montecarlo_log1pfc.txt", sep = "\t", header = T, row.names = 1)
colnames(log1pfc) <- c("Dn", "Total", "Up")

log1pfc <- log1pfc[, c(3, 1, 2)]

### heatmap
library(ComplexHeatmap)

## heatmap color
library(circlize)
cols <- colorRamp2(c(min(log1pfc), 0, max(log1pfc)), c("#2166AC", "#FFFFFF", "#B2182B"))


pdf("logfc_heatmap_clustered.pdf", width = 6, height = 8)
ht <- ComplexHeatmap::pheatmap(as.matrix(log1pfc),
                        name = "log2FC",
                        scale = "none",
                        cluster_cols = F,
                        cluster_rows = T,
                        color = cols,
                        # annotation_col = anno_col,
                        # annotation_colors = list(`Z-Score` = anno_colors),
                        border_color = "grey60",
                        cellwidth = 8,
                        cellheight = 8,
                        fontsize = 6.5,
                        show_rownames = T)
draw(ht)
dev.off()
