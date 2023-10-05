library(reshape2)
library(ggplot2)
library(tidyverse)

DF <- read.csv("/Users/user/University_of_Georgia/Dawe_Lab_Documents/Striated/pan_32858_leaf_tpm.csv")
SR <- read.csv("/Users/user/University_of_Georgia/Dawe_Lab_Documents/Striated/R_Sessions/Differential_Expression/SR2_TranscriptsPerMillion.csv")
SR <- SR[,-c(1)]
#This selects only leaf tip values
DF_tip <- DF[6:7,]

#This reshapes  and formats the data
DF_t <- as.data.frame(t(DF_tip))
DF_t <- DF_t[-c(1:2),]
DF_t$NAM <- rownames(DF_t)
colnames(DF_t) <- c("tpm", "copynumber", "NAM")
DF_t$copynumber <- as.numeric(DF_t$copynumber)
DF_t$tpm <- as.numeric(DF_t$tpm)
DF_t$copynumber <- round(DF_t$copynumber, 0)
DF_t$tpm <- round(DF_t$tpm, 0)

#This pulls out only my gene of interest from the SR2 data
SR_Sub <- subset(SR, Name=="Zm00001eb434490")
SR_Sub_sr <- SR_Sub[,c(1:3)]
sr_avgTPM <- rowMeans(SR_Sub_sr)

SR_Sub_W22 <- SR_Sub[,c(4:6)]
W22_avgTPM <- rowMeans(SR_Sub_W22)

temp <- data.frame(tpm=c(sr_avgTPM,W22_avgTPM, 0), copynumber=c("", "", ""), NAM=c("sr2", "W22", ""))
  
ALL <- rbind(DF_t, temp)
ALL$NAM <- factor(ALL$NAM, levels=c("B73","B97","CML103","CML228","CML247","CML277","CML322","CML333","CML52","CML69","HP301","Il14H","Ki11", "Ki3", "Ky21", "M162W", "M37W", "Mo18W","Ms71", "NC350","NC358","Oh43","Oh7B","P39","Tx303","Tzi8","","sr2","W22"))

#This plots the data
pdf()
pdf(file="sr2_NAMLines_TPM_LeafTip_v2.pdf", height = 10, width=10)
a <- ggplot(ALL, aes(x=NAM)) +
  geom_bar(aes(y=tpm), position = 'dodge', stat="identity") +
  geom_text(aes(y=tpm, label=copynumber), position=position_dodge(width=0.9), vjust=-0.25) +
  xlab("Line") +
  geom_vline(mapping=aes(xintercept=27), color="blue")+
  theme(plot.title = element_text(hjust=0.5, size = 18), plot.subtitle = element_text(hjust=0.5, size = 10), axis.title = element_text(size = 25), axis.text = element_text(size = 20, angle = 90))
a
dev.off()

