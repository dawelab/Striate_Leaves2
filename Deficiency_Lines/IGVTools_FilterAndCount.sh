#Load Modules
module load IGV/2.9.5-Java-11
module load SAMtools/1.14-GCC-8.3.0

#Define Variables
REF="/scratch/mjb51923/ref_genomes/Zm-B73_AB10-REFERENCE-NAM-1.0.fa"
DIR="/scratch/mjb51923/Striated/out/BWAmem"

for i in  "BWAmem_Unknown-DfM.s.r.bam" \
"BWAmem_W23-Ab10.s.r.bam" \
"BWAmem_W23-DfK.s.r.bam" \
"BWAmem_W23-DfL.s.r.bam"
do
NAME=$( echo $i | cut -d "." -f 1 )
samtools view -h $DIR/$i -bSq 20 -F 256 chr10:140964412-195026473 > $DIR/$NAME".Ab10MAPQ20Prim.s.r.bam"
igvtools count -w 1000 $DIR/$NAME".Ab10MAPQ20Prim.s.r.bam" $DIR/$NAME".Ab10MAPQ20Prim.s.r.bam.tdf" $REF
igvtools count -w 1 $DIR/$NAME".Ab10MAPQ20Prim.s.r.bam" $DIR/$NAME".Ab10MAPQ20PrimW1.s.r.bam.tdf" $REF
igvtools tdftobedgraph $DIR/$NAME".Ab10MAPQ20Prim.s.r.bam.tdf" $DIR/$NAME".Ab10MAPQ20Prim.s.r.bedgraph"
igvtools tdftobedgraph $DIR/$NAME".Ab10MAPQ20PrimW1.s.r.bam.tdf" $DIR/$NAME".Ab10MAPQ20PrimW1.s.r.bedgraph"
done
