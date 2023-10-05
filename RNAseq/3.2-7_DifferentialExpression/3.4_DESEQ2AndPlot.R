library(pheatmap)
library(ggplot2)

setwd("/Users/user/University_of_Georgia/Dawe_Lab_Documents/Striated/HTSeq_N10")

directory <- "/Users/user/University_of_Georgia/Dawe_Lab_Documents/Striated/HTSeq_N10"


#BiocManager::install("DESeq2")
library("DESeq2")
packageVersion("DESeq2")
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable, directory = directory, design= ~ condition)
ddsHTSeq

#This filters anything with very low coverage 
keep <- rowSums(counts(ddsHTSeq)) >= 10
ddsHTSeq_filt <- ddsHTSeq[keep,]

#This set W22 as the first level so that it calculates this as the "normal"
ddsHTSeq_filt$condition <- relevel(ddsHTSeq_filt$condition, "W22")

#This does the actual differential expression analysis 
dds <- DESeq(ddsHTSeq_filt)
#This normalizes 
ntd <- normTransform(dds)
res <- results(dds)
res_df <- as.data.frame(res)

#This calculates the fold change between sr2 and W22
gene1 <- which(row.names(res_df) %in% c("Zm00001eb434490"))
log2fold <- res_df[gene1,2]
foldchange <- 2^log(abs(log2fold))


#This makes the sample meta data information df 
sampleFiles <- grep(".count",list.files(directory),value=TRUE)
sampleName <- c("MB125-1", "MB125-3", "MB125-4", "MB129-1", "MB129-2", "MB129-3")
sampleCondition <- c("sr2", "sr2", "sr2", "W22", "W22", "W22")


sampleTable <- data.frame(sampleName = sampleName,
                          fileName = sampleFiles,
                          condition = sampleCondition)

sampleTable$condition <- factor(sampleTable$condition)

#This makes extracts the p values
df_row <-as.data.frame(res_df$padj)
rownames(df_row) <- rownames(res_df)
colnames(df_row) <- "adjusted p value"

##This plots the entire genome 
setwd("/Users/user/University_of_Georgia/Dawe_Lab_Documents/Striated/R_Sessions/Differential_Expression")

png(file="DeSEQ2_WholeGenome.png")
pheatmap(assay(ntd), cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df, annotation_row=df_row)
dev.off()

##This finds the index of the first gene after 140MB gene=Zm00001eb428890 and subsets the object to only the the shared region 
start <- which(rownames(dds) %in% c("Zm00001eb428890"))
end <- length(rownames(dds))
dds_10 <- dds[start:end, ]

#This normalizes 
ntd_10 <- normTransform(dds_10)

df <- as.data.frame(colData(dds_10)[,c("condition", "sizeFactor")])

png(file="DeSEQ2_Chr10CSharedRegion.png")
pheatmap(assay(ntd_10), cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df)
dev.off()

#######Zooming in on region of interest
start <- which(rownames(dds) %in% c("Zm00001eb434490"))
end <- which(rownames(dds) %in% c("Zm00001eb434540"))
dds_dup <- dds[start:end, ]
dds_dup

#editing the df_row
start_row <- which(rownames(df_row) %in% c("Zm00001eb434490"))
end_row <- which(rownames(df_row) %in% c("Zm00001eb434540"))
df_row_dup_rown <- rownames(df_row)[start:end]
df_row_dup_val <- df_row[start:end,]
df_row_dup <- as.data.frame(df_row_dup_val)
rownames(df_row_dup) <- df_row_dup_rown
colnames(df_row_dup) <- "adjusted p-value"
df_row_dup_round <- df_row_dup
df_row_dup_round$`adjusted p-value` <- round(df_row_dup$`adjusted p-value`, 4)

#This normalizes the 
ntd_dup <- normTransform(dds_dup)

df2<- as.data.frame(rowData(dds_dup))

DATA <- as.data.frame(assay(ntd_dup))
NAMES <- c("Gene 1", "Gene 2", "Gene A", "Gene 3", "Gene 4", "Gene 5")
S <- c("****", "*", "ns", "ns", "ns", "ns")
FIX<- paste(NAMES, S, sep="\n")
  
row.names(DATA) <- FIX
colnames(DATA) <- c("sr2-1", "sr2-2", "sr2-3", "WT-1", "WT-2", "WT-3")

png(file="DeSEQ2_Chr10CRegionOfInterest.png")
pheatmap(DATA, cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=FALSE, annotation_colors =annoCol, fontsize = 20)
dev.off()
