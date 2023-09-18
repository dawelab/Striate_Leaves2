#load the modules necessary from the cluster
module load cutadapt/2.7-GCCcore-8.3.0-Python-3.7.4

#Define Variables
REF="/scratch/mjb51923/ref_genomes/B73Ab10.pseudomolecules-v2.fasta"
READ_DIR="/scratch/mjb51923/raw_reads/Ab10"
OUT_DIR="/scratch/mjb51923/Ab10_FT_Mapping/out/Df_Seq"

for i in "Unknown-DfM_R1_001.fastq.gz" \
"W23-Ab10_R1.fastq_001.gz" \
"W23-DfK_R1.fastq_001.gz" \
"W23-DfL_R1.fastq_001.gz" 
do
NAME=$( echo $i | cut -d "_" -f 1 )
#Trim the adapter sequences off the reads and trim the  reads based on quality
# -a says the following is the 3' R1 adapter, -A says the following is the 3' R2 adapter, -O sets the minimum overlap length between the adapter and the read, -q is a base quality cut off applied to both reads in paired end data, -m is the minimum read length allowed, -o is the output file, -p has a second output file generated for all of the read 2 information, 
cutadapt -j 20 -q 20 -a AGATCGGAAGAGC -A AGATCGGAAGAGC -O 1 -m 100 -o $OUT_DIR/${NAME}"_R1.fastq.gz" -p $OUT_DIR/${NAME}"_R2.fastq.gz" $READ_DIR/${NAME}"_R1.trimmed.fastq.gz" $READ_DIR/${NAME}"_R2.trimmed.fastq.gz"
done
