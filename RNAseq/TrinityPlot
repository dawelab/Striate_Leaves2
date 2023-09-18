library(ggplot2)
library(reshape2)
library(ggpubr)
library(ggExtra)

MB125_1 <- read.table("/Volumes/Transcend/MB125-1_abundance.tsv", header=TRUE)
colnames(MB125_1) <- c("target_id", "length", "eff_length", "est_counts", "MB125_1_tpm")
MB125_3 <- read.table("/Volumes/Transcend/MB125-3_abundance.tsv", header=TRUE)
colnames(MB125_3) <- c("target_id", "length", "eff_length", "est_counts", "MB125_3_tpm")
MB125_4 <- read.table("/Volumes/Transcend/MB125-4_abundance.tsv", header=TRUE)
colnames(MB125_4) <- c("target_id", "length", "eff_length", "est_counts", "MB125_4_tpm")
MB129_1 <- read.table("/Volumes/Transcend/MB129-1_abundance.tsv", header=TRUE)
colnames(MB129_1) <- c("target_id", "length", "eff_length", "est_counts", "MB129_1_tpm")
MB129_2 <- read.table("/Volumes/Transcend/MB129-2_abundance.tsv", header=TRUE)
colnames(MB129_2) <- c("target_id", "length", "eff_length", "est_counts", "MB129_2_tpm")
MB129_3 <- read.table("/Volumes/Transcend/MB129-3_abundance.tsv", header=TRUE)
colnames(MB129_3) <- c("target_id", "length", "eff_length", "est_counts", "MB129_3_tpm")

temp1 <- merge(MB125_1[,c(1,5)], MB125_3[,c(1,5)], by="target_id")
temp2 <- merge(temp1, MB125_4[,c(1,5)], by="target_id")
temp3 <- merge(temp2, MB129_1[,c(1,5)], by="target_id")
temp4 <- merge(temp3, MB129_2[,c(1,5)], by="target_id")
All <- merge(temp4, MB129_3[,c(1,5)], by="target_id")

rm(temp1)
rm(temp2)
rm(temp3)
rm(temp4)

sr2 <- subset(All, target_id == "TRINITY_DN13879_c0_g1_i21" | target_id =="TRINITY_DN13879_c0_g1_i4" | target_id == "TRINITY_DN13879_c0_g1_i9" | target_id == "TRINITY_DN13879_c0_g1_i17"| target_id == "TRINITY_DN13879_c0_g1_i18" |target_id == "TRINITY_DN13879_c0_g1_i20"| target_id == "TRINITY_DN13879_c0_g1_i5" | target_id == "TRINITY_DN13879_c0_g1_i11")

#Splice Variants 11, 18, 17, and 20
#Insertion Bearing 21 and 9, 5
#Normal 4

sr2 <- sr2[c(3, 2, 1, 4, 7, 5, 8,  6),]

sr2$isoform_ID <- c(1:8)
sr2$isoform_ID <- as.character(sr2$isoform_ID)

sr2_melt <- melt(sr2[,-c(1)], id="isoform_ID")

sr2_125 <- sr2[,c(1:4)]
sr2_125$sr2avg <- rowMeans(sr2_125[,c(2:4)])

sr2_129 <- sr2[,c(1, 5:7)]
sr2_129$wtavg <- rowMeans(sr2_129[,c(2:4)])

avg <- c(sr2_125$sr2avg, sr2_129$wtavg)
id <- c(rep("sr2", 8), rep("WT", 8))
isoform <- c(1:8, 1:8)
x <- c(0.75, 1.75, 2.75, 3.75, 4.75, 5.75, 6.75, 7.75, 1.25, 2.25, 3.25, 4.25, 5.25, 6.25, 7.25, 8.25)
y <- c(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 105)

text <- data.frame(id=id, avg=round(avg, digits=1), isoform_ID=c(1:8, 1:8), x=x, y=y)

Splicegrob <- text_grob("splice variants", color = "black")
Insgrob <- text_grob("insertion variants", color = "black")
Fungrob <- text_grob("functional", color = "black")

ggplot() +
  geom_bar(data = sr2_melt, aes(x=isoform_ID, y=value, fill=variable, color=variable), position = "dodge", stat = "identity") +
  geom_text(data=text, aes(x=x, y=y, label=avg)) +
  scale_x_discrete(breaks=c("1", "2", "3", "4", "5", "6", "7", "8"))+
  scale_fill_manual(values=c("white", "white", "white", "darkgreen", "darkgreen", "darkgreen"), labels=c("sr2-1", "sr2-2", "sr2-3", "WT-1", "WT-2", "WT-3")) +
  scale_color_manual(values=c("brown4", "brown4", "brown4", "black", "black", "black"), labels=c("sr2-1", "sr2-2", "sr2-3", "WT-1", "WT-2", "WT-3")) +
  ylim(-10, 105) +
  geom_rect(mapping=aes(xmin=.5, xmax=4.4, ymin=-2, ymax=-2.5), alpha=0.5, fill="black", color = NA ) +
  annotation_custom(Splicegrob, xmin=1, xmax=4,  ymin=-5, ymax=-6) +
  geom_rect(mapping=aes(xmin=4.6, xmax=7.4, ymin=-2, ymax=-2.5), alpha=0.5, fill="black", color = NA ) +
  annotation_custom(Insgrob, xmin=4.6, xmax=7.5, ymin=-5, ymax=-6) +
  geom_rect(mapping=aes(xmin=7.6, xmax=8.5, ymin=-2, ymax=-2.5), alpha=0.5, fill="black", color = NA ) +
  annotation_custom(Fungrob, xmin=7.6, xmax=8.5, ymin=-8, ymax=-9) +
  ylab("TPM") +
  xlab("Isoform") +
  coord_cartesian(clip="off") +
  theme(plot.title = element_text(hjust=0.5, size = 18), plot.subtitle = element_text(hjust=0.5, size = 10), axis.title = element_text(size = 15), axis.text = element_text(size = 12), legend.title = element_text(size = 15), legend.text = element_text(size = 12))
ggsave("Isoform_BarChart_v1.png")
