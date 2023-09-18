#!/bin/bash
#SBATCH --partition=batch
#SBATCH -J Seqkit_Ab10HapPro
#SBATCH --output /scratch/mjb51923/Striated/scripts/Seqkit_Ab10HapPro.out
#SBATCH --mem=50000
#SBATCH --time=80:00:00
#SBATCH	--nodes=1
#SBATCH	--ntasks-per-node=1
#SBATCH --mail-user=meghan.brady@uga.edu
#SBATCH --mail-type=END

module load SeqKit/0.16.1

DIR="/scratch/mjb51923/Striated/out/OrthoFinder"
PROT="/scratch/mjb51923/annotations/Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.evd.protein.fa"

while read i
do
seqkit faidx -r $PROT $i > $DIR/${i}_Ab10Hap_protein.tmp.fasta
done < $DIR/Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.Ab10hapGeneNames.txt

cat $DIR/*_Ab10Hap_protein.tmp.fasta > $DIR/Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.evd.protein.Ab10Hap.fa
rm $DIR/*_Ab10Hap_protein.tmp.fasta


