module load HTSeq/0.13.5-foss-2019b-Python-3.7.4

ANNOT="/scratch/mjb51923/annotations/Zm-B73-REFERENCE-NAM-5.0_Zm00001eb.1.gtf"
OUT_DIR="/scratch/mjb51923/Striated/out/RNASeq2"
REF="/scratch/mjb51923/ref_genomes/B73.PLATINUM.pseudomolecules-v1.fasta"


for i in "MB125-1" \
"MB125-3" \
"MB125-4" \
"MB129-1" \
"MB129-2" \
"MB129-3"
do
htseq-count -f bam -c $OUT_DIR/$i"_v_B73.count" -n 12 $OUT_DIR/$i"_v_B73.s.bam" $ANNOT
done

