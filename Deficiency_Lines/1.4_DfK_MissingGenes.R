library(tidyverse)
library(readxl)

#Loades the genes
Ab10_GFF <- read.delim("/Volumes/Transcend/Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.Ab10hapGene.gff3", header = FALSE)
colnames(Ab10_GFF) <- c("seqname", "source", "feature", "start", "end", "score", "strand", "frame", "attribute")

#This section alters the Ab10 GFF to be compatible with the OrthoFinder Output
Ab10_GFF_GENE <- subset(Ab10_GFF, feature == "gene")
Ab10_GFF_GENE_temp1 <- separate(Ab10_GFF_GENE, col=attribute, into= c("ID", "biotype", "logic_name"), sep= ';')
Ab10_GFF_GENE_temp2 <- separate(Ab10_GFF_GENE_temp1, col= ID, into=c("Trash", "ID"), sep="=")
Ab10_GFF_GENE_temp3 <- Ab10_GFF_GENE_temp2[,c("seqname", "start", "end", "ID")]
colnames(Ab10_GFF_GENE_temp3) <- c("Ab10_seqname", "Ab10_start", "Ab10_end", "Ab10_ID")
Ab10_GFF_GENE_temp3$Ab10_ID <-  gsub("gene:", "", Ab10_GFF_GENE_temp3$Ab10_ID)
Ab10_GFF_GENE <- Ab10_GFF_GENE_temp3

#This section determines what and how many genes are lost in Df-K relative to the illumina determined shared region. K break point is chr10:167426118, End of Shared Region is chr10:167721000.
KMissing <- subset(Ab10_GFF_GENE, Ab10_start > 167426118 & Ab10_start < 167721000)
write.csv(KMissing, file="GenesMissingInKFromSharedRegion.csv", row.names = FALSE) 
