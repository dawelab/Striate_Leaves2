#load modules
module load HISAT2/2.1.0-foss-2019b
module load SAMtools/1.9-GCC-8.3.0

#Define Variables
READ_DIR="/scratch/mjb51923/raw_reads/RNA"
OUT_DIR="/scratch/mjb51923/Striated/out/RNASeq2"
REF="/scratch/mjb51923/ref_genomes/B73.PLATINUM.pseudomolecules-v1.fasta"

#Index the reference
#hisat2-build $REF $REF

for i in "MB125-1" \
"MB125-3" \
"MB125-4" \
"MB129-1" \
"MB129-2" \
"MB129-3"
do
hisat2 -p 12 -x $REF -1 $OUT_DIR/$i"_R1_001_paired.fastq" -2 $OUT_DIR/$i"_R2_001_paired.fastq" -S $OUT_DIR/$i"_v_B73.bam"
samtools sort $OUT_DIR/$i"_v_B73.bam" -o $OUT_DIR/$i"_v_B73.s.bam"
samtools index $OUT_DIR/$i"_v_B73.s.bam"
#this selects only primary alignments on chromosome 10 
samtools view -F 256 -h $OUT_DIR/$i"_v_B73.s.bam" chr10 -o $OUT_DIR/$i"_v_B73.s.prim.chr10.bam"
samtools index $OUT_DIR/$i"_v_B73.s.prim.chr10.bam"
done
