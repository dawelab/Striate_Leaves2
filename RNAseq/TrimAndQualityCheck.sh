module load FastQC/0.11.9-Java-11
module load Trimmomatic/0.39-Java-1.8.0_144
module load Cufflinks/2.2.1-foss-2019b
module load STAR/2.7.10a-GCC-8.3.0

RNA_DIR="/scratch/mjb51923/raw_reads/RNA"
OUT_DIR="/scratch/mjb51923/Striated/out/RNASeq2"
REF_DIR="/scratch/mjb51923/ref_genomes"
REF="B73Ab10.pseudomolecules-v2.fasta"
ANNOT_DIR="/scratch/mjb51923/annotations"

#This checks data quality
for i in MB125-1_R1_001.fastq.gz \
MB125-4_R1_001.fastq.gz \
MB129-2_R1_001.fastq.gz \
MB125-1_R2_001.fastq.gz \
MB125-4_R2_001.fastq.gz \
MB129-2_R2_001.fastq.gz \
MB125-3_R1_001.fastq.gz \
MB129-1_R1_001.fastq.gz \
MB129-3_R1_001.fastq.gz \
MB125-3_R2_001.fastq.gz \
MB129-1_R2_001.fastq.gz \
MB129-3_R2_001.fastq.gz
do
fastqc $RNA_DIR/$i --extract -o $OUT_DIR
done

#This trims adapters and low quality sequences
for i in MB125-1 \
MB125-3 \
MB125-4 \
MB129-1 \
MB129-2 \
MB129-3
do
java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE -threads 12 $RNA_DIR/$i"_R1_001.fastq.gz" $RNA_DIR/$i"_R2_001.fastq.gz" $OUT_DIR/$i"_R1_001_paired.fastq.gz" $OUT_DIR/$i"_R1_001_unpaired.fastq.gz" $OUT_DIR/$i"_R2_001_paired.fastq.gz" $OUT_DIR/$i"_R2_001_unpaired.fastq.gz" ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 MINLEN:36
done

#This rechecks quality 

for i in MB125-1_R1_001_paired.fastq.gz \
MB125-4_R1_001_paired.fastq.gz \
MB129-2_R1_001_paired.fastq.gz \
MB125-1_R2_001_paired.fastq.gz \
MB125-4_R2_001_paired.fastq.gz \
MB129-2_R2_001_paired.fastq.gz \
MB125-3_R1_001_paired.fastq.gz \
MB129-1_R1_001_paired.fastq.gz \
MB129-3_R1_001_paired.fastq.gz \
MB125-3_R2_001_paired.fastq.gz \
MB129-1_R2_001_paired.fastq.gz \
MB129-3_R2_001_paired.fastq.gz
do
fastqc $OUT_DIR/$i --extract -o $OUT_DIR
done
