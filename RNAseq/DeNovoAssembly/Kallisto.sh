OUT_DIR="/scratch/mjb51923/Striated/out/Trinity"
DATA_DIR="/scratch/mjb51923/Striated/out/RNASeq2"

i="MB125-1"
singularity exec /apps/singularity-images/trinity-2.8.4.simg /usr/local/bin/trinityrnaseq/util/align_and_estimate_abundance.pl --transcripts $OUT_DIR/trinity.MB125-all/Trinity.fasta --left $DATA_DIR/$i"_R1_001_paired.fastq" --right $DATA_DIR/$i"_R2_001_paired.fastq" --prep_reference --est_method kallisto --seqType fq --output_dir $OUT_DIR/trinity_est_abundance_kallisto.$i --thread_count 24

i="MB125-3"
singularity exec /apps/singularity-images/trinity-2.8.4.simg /usr/local/bin/trinityrnaseq/util/align_and_estimate_abundance.pl --transcripts $OUT_DIR/trinity.MB125-all/Trinity.fasta --left $DATA_DIR/$i"_R1_001_paired.fastq" --right $DATA_DIR/$i"_R2_001_paired.fastq" --prep_reference --est_method kallisto --seqType fq --output_dir $OUT_DIR/trinity_est_abundance_kallisto.$i --thread_count 24

i="MB125-4"
singularity exec /apps/singularity-images/trinity-2.8.4.simg /usr/local/bin/trinityrnaseq/util/align_and_estimate_abundance.pl --transcripts $OUT_DIR/trinity.MB125-all/Trinity.fasta --left $DATA_DIR/$i"_R1_001_paired.fastq" --right $DATA_DIR/$i"_R2_001_paired.fastq" --prep_reference --est_method kallisto --seqType fq --output_dir $OUT_DIR/trinity_est_abundance_kallisto.$i --thread_count 24

i="MB129-1"
singularity exec /apps/singularity-images/trinity-2.8.4.simg /usr/local/bin/trinityrnaseq/util/align_and_estimate_abundance.pl --transcripts $OUT_DIR/trinity.MB125-all/Trinity.fasta --left $DATA_DIR/$i"_R1_001_paired.fastq" --right $DATA_DIR/$i"_R2_001_paired.fastq" --prep_reference --est_method kallisto --seqType fq --output_dir $OUT_DIR/trinity_est_abundance_kallisto.$i --thread_count 24

i="MB129-2"
singularity exec /apps/singularity-images/trinity-2.8.4.simg /usr/local/bin/trinityrnaseq/util/align_and_estimate_abundance.pl --transcripts $OUT_DIR/trinity.MB125-all/Trinity.fasta --left $DATA_DIR/$i"_R1_001_paired.fastq" --right $DATA_DIR/$i"_R2_001_paired.fastq" --prep_reference --est_method kallisto --seqType fq --output_dir $OUT_DIR/trinity_est_abundance_kallisto.$i --thread_count 24

i="MB129-3"
singularity exec /apps/singularity-images/trinity-2.8.4.simg /usr/local/bin/trinityrnaseq/util/align_and_estimate_abundance.pl --transcripts $OUT_DIR/trinity.MB125-all/Trinity.fasta --left $DATA_DIR/$i"_R1_001_paired.fastq" --right $DATA_DIR/$i"_R2_001_paired.fastq" --prep_reference --est_method kallisto --seqType fq --output_dir $OUT_DIR/trinity_est_abundance_kallisto.$i --thread_count 24
