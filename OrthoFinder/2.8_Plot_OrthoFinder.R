library(tidyverse)
library(reshape2)
library(splitstackshape)
library(karyoploteR)
library(readxl)
library(ggplot2)
library(pafr)
library(Rsamtools)

ORTHO <- read.delim("/Users/user/University_of_Georgia/Dawe_Lab_Documents/Striated/Zm-B73-REFERENCE-NAM-5.0_Zm00001eb.1.protein.Longest__v__Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.evd.protein.Ab10HapLongest.tsv")

B73_GFF <- read.delim("/Volumes/Transcend/Zm-B73-REFERENCE-NAM-5.0_Zm00001eb.1.noheader.gff3", header = FALSE)
colnames(B73_GFF) <- c("seqname", "source", "feature", "start", "end", "score", "strand", "frame", "attribute")

Ab10_GFF <- read.delim("/Volumes/Transcend/Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.Ab10hapGene.gff3", header = FALSE)
colnames(Ab10_GFF) <- c("seqname", "source", "feature", "start", "end", "score", "strand", "frame", "attribute")

#This section alters the B73 GFF to be compatible with the OrthoFinder Output
B73_GFF_GENE <- subset(B73_GFF, feature == "gene")

B73_GFF_GENE_temp1 <- separate(B73_GFF_GENE, col=attribute, into= c("ID", "biotype", "logic_name"), sep= ';')

B73_GFF_GENE_temp2 <- separate(B73_GFF_GENE_temp1, col= ID, into=c("Trash", "ID"), sep="=")

B73_GFF_GENE_temp3 <- B73_GFF_GENE_temp2[,c("seqname", "start", "end", "ID")]
colnames(B73_GFF_GENE_temp3) <- c("B73_seqname", "B73_start", "B73_end", "B73_ID")

B73_GFF_GENE <- B73_GFF_GENE_temp3

#This section alters the Ab10 GFF to be compatible with the OrthoFinder Output
Ab10_GFF_GENE <- subset(Ab10_GFF, feature == "gene")

Ab10_GFF_GENE_temp1 <- separate(Ab10_GFF_GENE, col=attribute, into= c("ID", "biotype", "logic_name"), sep= ';')

Ab10_GFF_GENE_temp2 <- separate(Ab10_GFF_GENE_temp1, col= ID, into=c("Trash", "ID"), sep="=")

Ab10_GFF_GENE_temp3 <- Ab10_GFF_GENE_temp2[,c("seqname", "start", "end", "ID")]
colnames(Ab10_GFF_GENE_temp3) <- c("Ab10_seqname", "Ab10_start", "Ab10_end", "Ab10_ID")

Ab10_GFF_GENE_temp3$Ab10_ID <-  gsub("gene:", "", Ab10_GFF_GENE_temp3$Ab10_ID)

Ab10_GFF_GENE <- Ab10_GFF_GENE_temp3

#This section converts the file so that there is only one gene in each file 
ORTHO_MELT_temp1 <- cSplit(ORTHO, "Zm.B73.REFERENCE.NAM.5.0_Zm00001eb.1.protein.Longest", sep = ",", direction = "long")

ORTHO_MELT_temp2 <- cSplit(ORTHO_MELT_temp1, "Zm.B73_AB10.REFERENCE.NAM.1.0_Zm00043a.1.evd.protein.Ab10HapLongest", sep = ",", direction = "long")

ORTHO_MELT_temp3 <- separate(ORTHO_MELT_temp2, col = Zm.B73.REFERENCE.NAM.5.0_Zm00001eb.1.protein.Longest, into = c("B73_ID", "B73_Iso"))

ORTHO_MELT_temp4 <- separate(ORTHO_MELT_temp3, col = Zm.B73_AB10.REFERENCE.NAM.1.0_Zm00043a.1.evd.protein.Ab10HapLongest , into = c("Ab10_ID", "Ab10_Iso"))

ORTHO_MELT <- ORTHO_MELT_temp4

#This section merges the GFF files with the OrthoFinder Files
DATA_temp1 <- merge(ORTHO_MELT, B73_GFF_GENE)
DATA_temp2 <- merge(DATA_temp1, Ab10_GFF_GENE)
DATA <- DATA_temp2

#This alters the data for KaryoploteR
GENOME <- read.csv("~/University_of_Georgia/Dawe_Lab_Documents/Striated/KaryoploteR_genome.csv")
GENOME_Ab10 <- subset(GENOME, Chr == "Ab10" | Chr == "B73 10 Shared Region")

#This relabels N10 for nicer plotting
GENOME_Ab10[2,1] <- "N10"

#This makes the Ab10 and N10 genome
Ab10.genome <- toGRanges(GENOME_Ab10)

#################################################### Orthofinder Plots

#This loads in the links from orthofinder
OrthoLink_10_temp1 <- subset(DATA, DATA$B73_seqname == "chr10" & DATA$Ab10_seqname == "chr10")

Uninverted <- subset(OrthoLink_10_temp1, Ab10_start < 143000000)
Uninverted_start <- Uninverted[,c("B73_seqname", "B73_start", "B73_end")]
Uninverted_end <- Uninverted[,c("Ab10_seqname", "Ab10_start", "Ab10_end")]
Uninverted_start$B73_seqname <- "N10"
Uninverted_end$Ab10_seqname <- "Ab10"
Uninverted_start_range <- toGRanges(Uninverted_start)
Uninverted_end_range <- toGRanges(Uninverted_end)

Inv1 <- subset(OrthoLink_10_temp1, Ab10_start > 151000000 & Ab10_start < 157960000 )
Inv1_start <- Inv1[,c("B73_seqname", "B73_start", "B73_end")]
Inv1_end <- Inv1[,c("Ab10_seqname", "Ab10_start", "Ab10_end")]
Inv1_start$B73_seqname <- "N10"
Inv1_end$Ab10_seqname <- "Ab10"
Inv1_start_range <- toGRanges(Inv1_start)
Inv1_end_range <- toGRanges(Inv1_end)

Inv2 <- subset(OrthoLink_10_temp1, Ab10_start > 158960000 & Ab10_start < 167968901)
Inv2_start <- Inv2[,c("B73_seqname", "B73_start", "B73_end")]
Inv2_end <- Inv2[,c("Ab10_seqname", "Ab10_start", "Ab10_end")]
Inv2_start$B73_seqname <- "N10"
Inv2_end$Ab10_seqname <- "Ab10"
Inv2_start_range <- toGRanges(Inv2_start)
Inv2_end_range <- toGRanges(Inv2_end)

Other <- subset(OrthoLink_10_temp1, (Ab10_start > 143000000 & Ab10_start < 151000000) | (Ab10_start > 157960000 & Ab10_start < 158960000) | Ab10_start > 167968901)
Other_start <- Other[,c("B73_seqname", "B73_start", "B73_end")]
Other_end <- Other[,c("Ab10_seqname", "Ab10_start", "Ab10_end")]
Other_start$B73_seqname <- "N10"
Other_end$Ab10_seqname <- "Ab10"
Other_start_range <- toGRanges(Other_start)
Other_end_range <- toGRanges(Other_end)

#These numbers refer to the last 3 digits in the B73-N10 v5 gene names
#gene 490 is at 151806944 in B73 
#gene 500 is at 151809681 in B73 
#gene 510 is at 151941902 in B73 
#gene 520 is at 151944890 in B73 
#gene 530 is at 151946938 in B73 
#gene 540 is at 151948302 in B73 
#I removed the genes (510 and 520) that have an orthologe in the inversion so that I only highlight the orthologes that could be sr2
Dup <- subset(OrthoLink_10_temp1, B73_start == 151806944 | B73_start == 151809681 | B73_start == 151946938 | B73_start == 151948302)
Dup_start <- Dup[,c("B73_seqname", "B73_start", "B73_end")]
Dup_end <- Dup[,c("Ab10_seqname", "Ab10_start", "Ab10_end")]
Dup_start$B73_seqname <- "N10"
Dup_end$Ab10_seqname <- "Ab10"
Dup_start_range <- toGRanges(Dup_start)
Dup_end_range <- toGRanges(Dup_end)

#This section loads in the position of known morphological markers on B73-N10 and Ab10 and the position of the Df() line breakpoints on Ab10 
#B73
#W2 is at 146758676 in B73-N10
#O7 is at 150834905 in B73-N10
x_N10 <- c(146758676, 150834905)
y_N10 <- c(0.2, 0.2)
genes_N10 <- c("W2", "O7")

#W2 is 167105020 in B73-Ab10
#O7 is 161788577 in B73-Ab10
x_Ab10 <- c(161788577, 167105020, 167426118, 172190001)
y_Ab10 <- c(-0.45, -0.45, -.6, -.6)
genes_Ab10 <- c("O7", "W2", "Df(K)", "DF(M)")

#This alters plot parameters, this is actually just the default still
pp <- getDefaultPlotParams(plot.type=1)
pp$ideogramheight <- 1
pp$data1height <- 200
pp$data2height <- 100
pp$bottommargin <- 200

#This alters the GFF files to be plotable
Ab10_GFF_Heat <- Ab10_GENE_GFF[,c("seqname", "start", "end")]
Ab10_GFF_Heat$seqname <- "Ab10"
Ab10_GFF_Heat$y <- 0.1
Ab10_GFF_range <- toGRanges(Ab10_GFF_Heat)

B73_GFF_Heat <- B73_GFF_GENE[,c("B73_seqname", "B73_start", "B73_end")]
B73_GFF_Heat_filt <- subset(B73_GFF_Heat, B73_seqname == "chr10" & B73_start >= 141187279)
B73_GFF_Heat_filt$seqname <- "N10"
B73_GFF_Heat_filt$y <- 0.1
B73_GFF_range <- toGRanges(B73_GFF_Heat_filt)

#This reads in the bam file with the B73_N10 short read data. This file was generated in step 1.3
BED <- read.delim("/Volumes/Transcend/BWAmem_B73.Ab10MAPQ20Prim.s.bam.bedgraph", header=FALSE)
BED$V4 <- BED$V4/100
xs=BED$V2
xe=BED$V3
yb <- rep(0,nrow(BED))
yt=BED$V4


###### In this section I pull out all the Gene Names for Ab10 and B73 with unexpected orthologes 
Unexpected_temp <- subset(OrthoLink_10_temp1, OrthoLink_10_temp1$Ab10_start >= 167968902 | (OrthoLink_10_temp1$Ab10_start > 143960000 & OrthoLink_10_temp1$Ab10_start < 150960000))
Unexpected <- subset(Unexpected_temp, Unexpected_temp$B73_start >= 140960000)
Unexpected

#I manually got the GO terms from maize GDB
GO <- read_excel("~/University_of_Georgia/Dawe_Lab_Documents/Striated/Unexpected_Orthologues_Between_N10SharedRegion_Ab10.xlsx")
Unexpected_GO <- merge(Unexpected, GO)
write.csv(Unexpected_GO, file="Unexpected_Orthologues_Between_N10SharedRegion_Ab10_Positions.csv", row.names = FALSE)

#This does the plotting
png(file="Orthologes_KaryoploteR.png", width = 480*4, height = 480*3, units = "px", pointsize = 24, bg = "white")
kp <- plotKaryotype(genome = Ab10.genome, chromosomes = c("N10", "Ab10"), plot.type=1, plot.params=pp)
kpRect(kp, chr="N10", x0=141187279, x1=152435371, y0=0.01, y1=0.1, col = "darkgoldenrod3")
kpRect(kp, chr="Ab10", x0=152050000, x1=156880000, y0=-0.25, y1=-0.35, col = "darkgoldenrod3")
kpRect(kp, chr="Ab10", x0=158250000, x1=167721000, y0=-0.25, y1=-0.35, col = "darkgoldenrod3")
kpRect(kp, chr="Ab10", x0=142472000, x1=146699300, y0=-0.25, y1=-0.35, col = "deepskyblue")
kpRect(kp, chr="Ab10", x0=150656000, x1=153145000, y0=-0.25, y1=-0.35, col = "deepskyblue")
kpRect(kp, chr="Ab10", x0=157485200, x1=159356550, y0=-0.25, y1=-0.35, col = "deepskyblue")
kpRect(kp, chr="Ab10", x0=174433450, x1=182846100, y0=-0.25, y1=-0.35, col = "green")
kpRect(kp, chr="Ab10", x0=148964528, x1=149082763, y0=-0.25, y1=-0.35, col = "blue", border= "blue")
kpRect(kp, chr="Ab10", x0=189326066, x1=190330226, y0=-0.25, y1=-0.35, col = "darkgreen")
kpRect(kp, chr="Ab10", x0=167426118, x1=172190001, y0=-0.54, y1=-0.54, col = "black")
kpAddLabels(kp, labels="Features", r0=-.3, r1 =-.3)
kpAddLabels(kp, labels="Df() Breakpoints", r0=-.5, r1 =-.5)
kpPlotLinks(kp, data=Uninverted_start_range, data2=Uninverted_end_range, r0=-.5, r1 = -.25, y= 1.6, col = "palegreen", border = "palegreen" )
kpPlotLinks(kp, data=Inv1_start_range, data2=Inv1_end_range, r0=-.5, r1 = -.25, y= 1.6, col = "seagreen1", border = "seagreen1")
kpPlotLinks(kp, data=Inv2_start_range, data2=Inv2_end_range, r0=-.5, r1 = -.25, y= 1.6, col = "aquamarine", border = "aquamarine")
kpPlotLinks(kp, data=Other_start_range, data2=Other_end_range, r0=-.5, r1 = -.25, y= 1.6, col = "purple" , border = "purple")
kpPlotLinks(kp, data=Dup_start_range, data2=Dup_end_range, r0=-.5, r1 = -.25, y= 1.6, col = "red", border = "red")
kpAddBaseNumbers(kp, tick.dist = 10000000, tick.len = 10, tick.col="red", cex=1, minor.tick.dist = 1000000, minor.tick.len = 5, minor.tick.col = "gray")
kpText(kp, chr="N10", x=x_N10, y=y_N10, labels=genes_N10, col = c("black", "black"))
kpText(kp, chr="Ab10", x=x_Ab10, y=y_Ab10, labels=genes_Ab10, col = c("black", "black"))
kpHeatmap(kp, data=Ab10_GFF_range, chr="Ab10", r0=-.8, r1 = -.7 )
kpAddLabels(kp, labels="Genes", r0=-.8, r1 = -.7)
kpHeatmap(kp, data=B73_GFF_range, chr="N10", r0=.4, r1 =.5 )
kpAddLabels(kp, labels="Genes", r0=.4, r1 =.5)
kp <- kpBars(kp, chr="Ab10", x0=xs, x1=xe, y0=yb, y1=yt, r0=-.9, r1 =-.8 )
kpAddLabels(kp, labels="N10", r0=-.88, r1 =-.88)
kpArrows(kp, chr="N10", x0=150834905, x1=150834905, y0=0.15, y1=-0.1, col="black")
kpArrows(kp, chr="Ab10", x0=161788577, x1=161788577, y0=-0.4, y1=-0.22, col="black")
kpArrows(kp, chr="N10", x0=146758676, x1=146758676, y0=0.15, y1=-0.1, col="black")
kpArrows(kp, chr="Ab10", x0=167105020, x1=167105020, y0=-0.4, y1=-0.1, col="black")
dev.off()
