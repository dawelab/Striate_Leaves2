#!/usr/bin/bash
#SBATCH --partition=batch
#SBATCH -J Trinity_sr2_125_pool
#SBATCH --output /scratch/mjb51923/Striated/scripts/Trinity_sr2_125_pool.out
#SBATCH --mem=200GB
#SBATCH --time=80:00:00
#SBATCH	--nodes=1
#SBATCH	--ntasks-per-node=24
#SBATCH --mail-user=meghan.brady@uga.edu
#SBATCH --mail-type=BEGIN,END

module load Trinity/2.10.0-foss-2019b-Python-3.7.4
module load SAMtools/1.14-GCC-8.3.0

OUT_DIR="/scratch/mjb51923/Striated/out/Trinity"
DATA_DIR="/scratch/mjb51923/Striated/out/RNASeq2"

cat $DATA_DIR/MB125-1_R1_001_paired.fastq $DATA_DIR/MB125-3_R1_001_paired.fastq $DATA_DIR/MB125-4_R1_001_paired.fastq > $DATA_DIR/MB125-all_R1_001_paired.fastq 
cat $DATA_DIR/MB125-1_R2_001_paired.fastq $DATA_DIR/MB125-3_R2_001_paired.fastq $DATA_DIR/MB125-4_R2_001_paired.fastq > $DATA_DIR/MB125-all_R2_001_paired.fastq 


for i in "MB125-all"
do
echo "########### Starting new line"
mkdir $OUT_DIR/trinity.$i
Trinity --seqType fq --output  $OUT_DIR/trinity.$i --max_memory 170G --left $DATA_DIR/$i"_R1_001_paired.fastq" --right $DATA_DIR/$i"_R2_001_paired.fastq" --CPU 24
done
