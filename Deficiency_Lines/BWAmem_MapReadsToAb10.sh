#load the modules necessary from the cluster
module load BWA/0.7.17-GCC-8.3.0
module load SAMtools/0.1.20-GCC-8.3.0
module load picard/2.26.4-Java-13.0.2

#Define Variablesq
REF="/scratch/mjb51923/ref_genomes/Zm-B73_AB10-REFERENCE-NAM-1.0.fa"
DIR="/scratch/mjb51923/Striated/out/BWAmem"
READ_DIR="/scratch/mjb51923/raw_reads"

#Index the reference file
bwa index -a bwtsw $REF
#Generates a sequence dictionary so that I can later remove duplicates using picard 
java -jar  $EBROOTPICARD/picard.jar CreateSequenceDictionary R= $REF O= /scratch/mjb51923/ref_genomes/Zm-B73_AB10-REFERENCE-NAM-1.0.dict

COUNTER=1

for i in "Unknown-DfM_R1.trimmed.fastq" \
"W23-Ab10_R1.trimmed.fastq.gz" \
"W23-DfK_R1.trimmed.fastq.gz" \
"W23-DfL_R1.trimmed.fastq.gz" 
do
NAME=$( echo $i | cut -d "_" -f 1 )
# This part assigns read group information 
FLOW=$(head -1 $DIR/$i | cut -d ":" -f 3 )
LANE=$(head -1 $DIR/$i | cut -d ":" -f 4 )
PU=$FLOW'.'$LANE'.'$NAME
ID=$FLOW'.'$LANE'.'$COUNTER
echo '@RG\tID:'$ID'\tPU:'$PU'\tSM:'$NAME'\tLB:'$NAME'\tPL:ILLUMINA'
#Align reads to reference using 30 threads (-t), provide a complete read group header line (-R), and make the output file compatible with picard (-M). 
#Then I pipe the output from the BWA command into samtools and convert it to a bam file.
bwa mem -t 30 -M -R '@RG\tID:'$ID'\tPU:'$PU'\tSM:'$NAME'\tLB:'$NAME'\tPL:ILLUMINA' $REF $READ_DIR/${NAME}"_R1.trimmed.fastq" $READ_DIR/${NAME}"_R2.trimmed.fastq" | samtools view -Sb - > $DIR/"BWAmem_"${NAME}.bam
#sorting the bam file I just generated
samtools sort -@ 30 $DIR/"BWAmem_"${NAME}.bam $DIR/"BWAmem_"${NAME}.s
#Remove PCR and optical duplicates 
java -jar $EBROOTPICARD/picard.jar MarkDuplicates -I $DIR/"BWAmem_"${NAME}.s.bam -O $DIR/"BWAmem_"${NAME}.s.r.bam -M $DIR/$NAME.dedupmetric -REMOVE_DUPLICATES  true
#index the final output file
samtools index $DIR/"BWAmem_"${NAME}.s.r.bam
COUNTER=$( expr $COUNTER + 1 )
done
