library(tidyverse)

#Removed the header to make this file compatible with R 
B73Ab10_GFF <- read.delim("/Volumes/Transcend/Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.noheader.gff3", header = FALSE)
colnames(B73Ab10_GFF) <- c("seqname", "source", "feature", "start", "end", "score", "strand", "frame", "attribute")

#140964412 is the start of the colored 1 (R1) https://www.maizegdb.org/gene_center/gene/Zm00001eb429330 in the B73-Ab10 genome https://www.maizegdb.org/genome/assembly/Zm-B73_AB10-REFERENCE-NAM-1.0 that marks the begining of the Ab10 haplotype. In B73-Ab10 R1 is Zm00043a049042.

#This selects only genes on the Ab10 haplotype
Ab10_GFF <- subset(B73Ab10_GFF, feature == "gene" & seqname == "chr10" & start >= 140964412)

#This separates out the gene ID 
Ab10_GFF_GENE_temp1 <- separate(Ab10_GFF, col=attribute, into= c("ID", "biotype", "logic_name"), sep= ';')
Ab10_GFF_GENE_temp2 <- separate(Ab10_GFF_GENE_temp1, col= ID, into=c("Trash", "ID"), sep="=")
Ab10_GFF_GENE_temp3 <- Ab10_GFF_GENE_temp2[,c("seqname", "start", "end", "ID")]
colnames(Ab10_GFF_GENE_temp3) <- c("Ab10_seqname", "Ab10_start", "Ab10_end", "Ab10_ID")
Ab10_GFF_GENE_temp3$Ab10_ID <-  gsub("gene:", "", Ab10_GFF_GENE_temp3$Ab10_ID)
Ab10_GFF_GENE <- Ab10_GFF_GENE_temp3

#This writes the gene names on the Ab10 haplotype
write.table(Ab10_GFF_GENE$Ab10_ID, "Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.Ab10hapGeneNames.txt", row.names = FALSE, quote = FALSE)

