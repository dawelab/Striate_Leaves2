library(karyoploteR)
library(tidyverse)
library(readxl)

#This makes the ideogram for KaryoploteR
GENOME <- read.csv("~/University_of_Georgia/Dawe_Lab_Documents/Striated/KaryoploteR_genome.csv")
GENOME_Ab10 <- subset(GENOME, Chr == "Ab10")
#This makes the Ab10 and N10 genome
Ab10.genome <- toGRanges(GENOME_Ab10)

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
#This alters the GFF files to be plotable
Ab10_GFF_Heat <- Ab10_GFF_GENE[,c("Ab10_seqname", "Ab10_start", "Ab10_end")]
Ab10_GFF_Heat$seqname <- "Ab10"
Ab10_GFF_Heat$y <- 0.1
Ab10_GFF_range <- toGRanges(Ab10_GFF_Heat)


#This loads the count files
AB10_BED <- read.delim("/Volumes/Transcend/BWAmem_W23-Ab10.Ab10MAPQ20Prim.s.r.bedgraph", header=FALSE)
K_BED <- read.delim("/Volumes/Transcend/BWAmem_W23-DfK.Ab10MAPQ20Prim.s.r.bedgraph", header=FALSE)
M_BED <- read.delim("/Volumes/Transcend/BWAmem_Unknown-DfM.Ab10MAPQ20Prim.s.r.bedgraph", header=FALSE)
L_BED <- read.delim("/Volumes/Transcend/BWAmem_W23-DfL.Ab10MAPQ20Prim.s.r.bedgraph", header=FALSE)
N10_BED <- read.delim("/Volumes/Transcend/BWAmem_B73.Ab10MAPQ20Prim.s.bam.bedgraph", header=FALSE)

#This scales the average read depth to make the plot more visually appealing
AB10_BED$V4 <- AB10_BED$V4/100
K_BED$V4 <- K_BED$V4/100
M_BED$V4 <- M_BED$V4/100
L_BED$V4 <- L_BED$V4/100
N10_BED$V4 <- N10_BED$V4

#This converts the bed files to a format appropriate for KaryoploteR for each line
AB10_xs=AB10_BED$V2
AB10_xe=AB10_BED$V3
AB10_yt=AB10_BED$V4
AB10_yb <- rep(0,nrow(AB10_BED))

K_xs=K_BED$V2
K_xe=K_BED$V3
K_yt=K_BED$V4
K_yb <- rep(0,nrow(K_BED))

M_xs=M_BED$V2
M_xe=M_BED$V3
M_yt=M_BED$V4
M_yb <- rep(0,nrow(M_BED))

L_xs=L_BED$V2
L_xe=L_BED$V3
L_yt=L_BED$V4
L_yb <- rep(0,nrow(L_BED))

N10_BED$V4 <- N10_BED$V4/100
N10_xs=N10_BED$V2
N10_xe=N10_BED$V3
N10_yb <- rep(0,nrow(N10_BED))
N10_yt=N10_BED$V4

#This creates the data for the marker text
#W2 is 167105020
#O7 is 161788577
x_Ab10 <- c(161788577, 167105020)
y_Ab10 <- c(-0.3, -0.3)
genes_Ab10 <- c("O7", "W2")

#This alters plot parameters
pp <- getDefaultPlotParams(plot.type=2)
pp$ideogramheight <- 1
pp$data2height <- 100

#This does the plotting
png(file="DfSeq_KaryoploteR.png", width = 480*4, height = 480*3, units = "px", pointsize = 24, bg = "white")
kp <- plotKaryotype(genome = Ab10.genome, chromosomes = c("Ab10"), plot.type=2, plot.params=pp)
kpRect(kp, chr="Ab10", x0=152050000, x1=156880000, y0=-0.2, y1=-0.25, col = "darkgoldenrod3")
kpRect(kp, chr="Ab10", x0=158250000, x1=167721000,y0=-0.2, y1=-0.25, col = "darkgoldenrod3")
kpRect(kp, chr="Ab10", x0=142472000, x1=146699300,y0=-0.2, y1=-0.25, col = "deepskyblue")
kpRect(kp, chr="Ab10", x0=150656000, x1=153145000,y0=-0.2, y1=-0.25, col = "deepskyblue")
kpRect(kp, chr="Ab10", x0=157485200, x1=159356550,y0=-0.2, y1=-0.25, col = "deepskyblue")
kpRect(kp, chr="Ab10", x0=174433450, x1=182846100,y0=-0.2, y1=-0.25, col = "green")
kpRect(kp, chr="Ab10", x0=148964528, x1=149082763,y0=-0.2, y1=-0.25, col = "blue", border= "blue")
kpRect(kp, chr="Ab10", x0=189326066, x1=190330226,y0=-0.2, y1=-0.25, col = "darkgreen")
kpAddLabels(kp, labels="Features", data.panel = 2, r0=1, r1 =-0.9)
kpAddBaseNumbers(kp, tick.dist = 10000000, tick.len = 10, tick.col="red", cex=1, minor.tick.dist = 1000000, minor.tick.len = 5, minor.tick.col = "gray")
kpText(kp, chr="Ab10", x=x_Ab10, y=y_Ab10, labels=genes_Ab10, col = c("black", "black"))
kpHeatmap(kp, data=Ab10_GFF_range, chr="Ab10", data.panel = 2, r0=0.3, r1=0.4)
kpAddLabels(kp, labels="Genes", r0=0.3, r1=0.4, data.panel = 2)
kpBars(kp, chr="Ab10", x0=K_xs, x1=K_xe, y0=K_yb, y1=K_yt, data.panel = 1, r0=0, r1=0.60)
kpAddLabels(kp, labels="Df(K)", data.panel = 1,  r0=0, r1=0.1)
kpBars(kp, chr="Ab10", x0=M_xs, x1=M_xe, y0=M_yb, y1=M_yt, data.panel = 1, r0=0.20, r1=0.8)
kpAddLabels(kp, labels="Df(M)", data.panel = 1,  r0=0.2, r1=0.3)
kpBars(kp, chr="Ab10", x0=L_xs, x1=L_xe, y0=L_yb, y1=L_yt, data.panel = 1, r0=0.45, r1=1)
kpAddLabels(kp, labels="Df(L)", data.panel = 1,  r0=0.45, r1=0.55)
kpBars(kp, chr="Ab10", x0=AB10_xs, x1=AB10_xe, y0=AB10_yb, y1=AB10_yt, data.panel = 1,r0=0.7, r1=1.2,)
kpAddLabels(kp, labels="Ab10", data.panel = 1,  r0=0.7, r1=0.8)
kpBars(kp, chr="Ab10", x0=N10_xs, x1=N10_xe, y0=N10_yb, y1=N10_yt, data.panel = 1, r0=0.9, r1=1)
kpAddLabels(kp, labels="N10", data.panel = 1,  r0=0.9, r1=1)
kpArrows(kp, chr="Ab10", x0=167426118, x1=167426118, y0=-.05, y1=0, col="red")
kpArrows(kp, chr="Ab10", x0=177845876, x1=177845876, y0=0.4, y1=0.45, col="red")
kpArrows(kp, chr="Ab10", x0=172190001, x1=172190001, y0=0.15, y1=0.2, col="red")
dev.off()
