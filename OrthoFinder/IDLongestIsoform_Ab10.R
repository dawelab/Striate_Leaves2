module load R/4.1.3-foss-2020b
R 

library(tidyr)
library(dplyr)

setwd("/scratch/mjb51923/Striated/out/OrthoFinder")

Ab10HapProt <- read.delim("/scratch/mjb51923/Striated/out/OrthoFinder/Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.evd.protein.Ab10Hap.fa.fai", header=FALSE)

names(Ab10HapProt) <- c("name", "length", "offset", "linebases", "linewidth")


Ab10HapProt <- separate(Ab10HapProt, col = name, into=c("gene", "isoform"), sep="_")

genes <- unique(Ab10HapProt$gene)

Long <- Ab10HapProt %>% group_by(Ab10HapProt$gene) %>% arrange(-length) %>% slice(1)
length(Long$gene)

Long$ID <- paste(Long$gene, Long$isoform, sep="_")

#Print a list of gene names and numbers of the longest isoforms
write.table(Long$ID, file = "Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.Ab10hapGeneNamesLongest.txt", sep="\n", row.names = FALSE, col.names = FALSE, quote = FALSE)
