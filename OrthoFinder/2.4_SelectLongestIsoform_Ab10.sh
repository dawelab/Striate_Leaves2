module load SeqKit/0.16.1

DIR="/scratch/mjb51923/Striated/out/OrthoFinder"
PROT="Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.evd.protein.Ab10Hap.fa"

while read i
do
seqkit faidx -r $DIR/$PROT $i > $DIR/${i}_B73Ab10_protein.tmp.fasta
done < $DIR/Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.Ab10hapGeneNamesLongest.txt

cat $DIR/*_B73Ab10_protein.tmp.fasta > $DIR/Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.evd.protein.Ab10HapLongest.fa
rm $DIR/*_B73Ab10_protein.tmp.fasta
