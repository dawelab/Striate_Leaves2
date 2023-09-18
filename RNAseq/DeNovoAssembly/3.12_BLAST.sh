module load BLAST/2.2.26-Linux_x86_64
DATA_DIR="/scratch/mjb51923/Striated/out/RNASeq2"
OUT_DIR="/scratch/mjb51923/Striated/out/RNASeq3"

for i in "MB125-1" \
"MB125-3" \
"MB125-4" \
"MB129-1" \
"MB129-2" \
"MB129-3"
do
echo $i
formatdb -p F -o T -i $DATA_DIR/$i"_v_B73.s.primQ20.gene1.fasta"
blastall -p blastn -d $DATA_DIR/$i"_v_B73.s.primQ20.gene1.fasta" -i $OUT_DIR/CASP_cDNA.fasta -o  $OUT_DIR/BLAST_CASP_cDNA_v_primQ20$i.out -m 8
blastall -p blastn -d $DATA_DIR/$i"_v_B73.s.primQ20.gene1.fasta" -i $OUT_DIR/Lasp_cDNA.fasta -o  $OUT_DIR/BLAST_Lasp_cDNA_v_primQ20$i.out -m 8
blastall -p blastn -d $DATA_DIR/$i"_v_B73.s.primQ20.gene1.fasta" -i $OUT_DIR/Zm00001eb434490_T003_cDNA.fasta -o $OUT_DIR/BLAST_Zm00001eb434490_T003_cDNA_v_primQ20$i.out -m 8
blastall -p blastn -d $DATA_DIR/$i"_v_B73.s.primQ20.gene1.fasta" -i $OUT_DIR/PosMu_cDNA.fasta -o  $OUT_DIR/BLAST_PosMu_cDNA_v_primQ20$i.out -m 8
done
