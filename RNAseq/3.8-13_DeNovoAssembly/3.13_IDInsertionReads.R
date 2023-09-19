library(tidyverse)

DF <- data.frame(Name = c(), ReadPairs = c())
# "MB129-1", "MB129-2" "MB129-3" had no hits for CASP for Lasp so are excluded
NAMES <- c("MB125-1", "MB125-3", "MB125-4")

for(i in NAMES) {
  NAME <- i
  CASP <- read.delim(paste("/Volumes/Transcend/BLAST_CASP_cDNA_v_primQ20", NAME, ".out", sep=""), header=FALSE)
  colnames(CASP) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
  GENE <- read.delim(paste("/Volumes/Transcend/BLAST_Zm00001eb434490_T003_cDNA_v_primQ20", NAME, ".out", sep=""), header=FALSE)
  colnames(GENE) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
  CASP_temp1 <- separate(CASP, sseqid, into=c("readID", "PairNum"), sep="/")
  GENE_temp1 <- separate(GENE, sseqid, into=c("readID", "PairNum"), sep="/")
  CASP_READ_LIST <- unique(CASP_temp1$readID)
  Index <- which(GENE_temp1$readID %in% CASP_READ_LIST)
  GENE_temp2 <- GENE_temp1[Index,] 
  MERGE <- rbind(CASP_temp1, GENE_temp2)
  MERGE_sort <- MERGE[order(MERGE$readID),]
  write_csv(MERGE_sort, file=paste("ReadPairs_CASPandSr", NAME, "csv", sep="_"))
  READ_PAIRS <- length(unique(MERGE$readID))
  LINE <- data.frame(Name=NAME, ReadPairs=READ_PAIRS)
  DF <<- rbind(DF, LINE)
}

write.csv(DF, "ReadPairs_CASPandSr_SummaryTable.csv")


DF <- data.frame(Name = c(), ReadPairs = c())
# "MB129-1", "MB129-2" "MB129-3" had no hits for CASP for Lasp so are excluded
NAMES <- c("MB125-1", "MB125-3", "MB125-4")

for(i in NAMES) {
  NAME <- i
  Lasp <- read.delim(paste("/Volumes/Transcend/BLAST_Lasp_cDNA_v_primQ20", NAME, ".out", sep=""), header=FALSE)
  colnames(Lasp) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
  GENE <- read.delim(paste("/Volumes/Transcend/BLAST_Zm00001eb434490_T003_cDNA_v_primQ20", NAME, ".out", sep=""), header=FALSE)
  colnames(GENE) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
  Lasp_temp1 <- separate(Lasp, sseqid, into=c("readID", "PairNum"), sep="/")
  GENE_temp1 <- separate(GENE, sseqid, into=c("readID", "PairNum"), sep="/")
  Lasp_READ_LIST <- unique(Lasp_temp1$readID)
  Index <- which(GENE_temp1$readID %in% Lasp_READ_LIST)
  GENE_temp2 <- GENE_temp1[Index,] 
  MERGE <- rbind(Lasp_temp1, GENE_temp2)
  MERGE_sort <- MERGE[order(MERGE$readID),]
  write_csv(MERGE_sort, file=paste("ReadPairs_LaspandSr", NAME, "csv", sep="_"))
  READ_PAIRS <- length(unique(MERGE$readID))
  LINE <- data.frame(Name=NAME, ReadPairs=READ_PAIRS)
  DF <<- rbind(DF, LINE)
}

write.csv(DF, "ReadPairs_LaspandSr_SummaryTable.csv")


DF <- data.frame(Name = c(), ReadPairs = c())
# "MB129-1", "MB129-2" "MB129-3" had no hits for CASP for PosMu so are excluded
NAMES <- c("MB125-1", "MB125-3", "MB125-4")

for(i in NAMES) {
  NAME <- i
  PosMu <- read.delim(paste("/Volumes/Transcend/BLAST_PosMu_cDNA_v_primQ20", NAME, ".out", sep=""), header=FALSE)
  colnames(PosMu) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
  GENE <- read.delim(paste("/Volumes/Transcend/BLAST_Zm00001eb434490_T003_cDNA_v_primQ20", NAME, ".out", sep=""), header=FALSE)
  colnames(GENE) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
  PosMu_temp1 <- separate(PosMu, sseqid, into=c("readID", "PairNum"), sep="/")
  GENE_temp1 <- separate(GENE, sseqid, into=c("readID", "PairNum"), sep="/")
  PosMu_READ_LIST <- unique(PosMu_temp1$readID)
  Index <- which(GENE_temp1$readID %in% PosMu_READ_LIST)
  GENE_temp2 <- GENE_temp1[Index,] 
  MERGE <- rbind(PosMu_temp1, GENE_temp2)
  MERGE_sort <- MERGE[order(MERGE$readID),]
  write_csv(MERGE_sort, file=paste("ReadPairs_PosMuandSr", NAME, "csv", sep="_"))
  READ_PAIRS <- length(unique(MERGE$readID))
  LINE <- data.frame(Name=NAME, ReadPairs=READ_PAIRS)
  DF <<- rbind(DF, LINE)
}

write.csv(DF, "ReadPairs_PosMuandSr_SummaryTable.csv")

DF <- data.frame(Name = c(), ReadPairs = c())
# "MB129-1", "MB129-2" "MB129-3" had no hits for CASP for PosMu so are excluded
NAMES <- c("MB125-1", "MB125-3", "MB125-4")

for(i in NAMES) {
  NAME <- i
  PosMu <- read.delim(paste("/Volumes/Transcend/BLAST_PosMu_cDNA_v_primQ20", NAME, ".out", sep=""), header=FALSE)
  colnames(PosMu) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
  CASP <- read.delim(paste("/Volumes/Transcend/BLAST_CASP_cDNA_v_primQ20", NAME, ".out", sep=""))
  colnames(CASP) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
  PosMu_temp1 <- separate(PosMu, sseqid, into=c("readID", "PairNum"), sep="/")
  CASP_temp1 <- separate(CASP, sseqid, into=c("readID", "PairNum"), sep="/")
  PosMu_READ_LIST <- unique(PosMu_temp1$readID)
  Index <- which(CASP_temp1$readID %in% PosMu_READ_LIST)
  CASP_temp2 <- CASP_temp1[Index,] 
  MERGE <- rbind(PosMu_temp1, CASP_temp2)
  MERGE_sort <- MERGE[order(MERGE$readID),]
  write_csv(MERGE_sort, file=paste("ReadPairs_PosMuandCASP", NAME, "csv", sep="_"))
  READ_PAIRS <- length(unique(MERGE$readID))
  LINE <- data.frame(Name=NAME, ReadPairs=READ_PAIRS)
  DF <<- rbind(DF, LINE)
}

write.csv(DF, "ReadPairs_PosMuandCASP_SummaryTable.csv")


