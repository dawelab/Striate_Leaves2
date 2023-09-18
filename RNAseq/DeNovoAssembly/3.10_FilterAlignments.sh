module load SAMtools/1.16.1-GCC-11.3.0

samtools view -Sbq 20 MB125-1_v_B73.s.prim.chr10.bam chr10:151806944-151809342 > MB125-1_v_B73.s.primQ20.gene1.bam
samtools fasta MB125-1_v_B73.s.primQ20.gene1.bam > MB125-1_v_B73.s.primQ20.gene1.fasta

samtools view -Sbq 20 MB125-3_v_B73.s.prim.chr10.bam chr10:151806944-151809342 > MB125-3_v_B73.s.primQ20.gene1.bam
samtools fasta MB125-3_v_B73.s.primQ20.gene1.bam > MB125-3_v_B73.s.primQ20.gene1.fasta

samtools view -Sbq 20 MB125-4_v_B73.s.prim.chr10.bam chr10:151806944-151809342 > MB125-4_v_B73.s.primQ20.gene1.bam
samtools fasta MB125-4_v_B73.s.primQ20.gene1.bam > MB125-4_v_B73.s.primQ20.gene1.fasta

samtools view -Sbq 20 MB129-1_v_B73.s.prim.chr10.bam chr10:151806944-151809342 > MB129-1_v_B73.s.primQ20.gene1.bam
samtools fasta MB129-1_v_B73.s.primQ20.gene1.bam > MB129-1_v_B73.s.primQ20.gene1.fasta

samtools view -Sbq 20 MB129-2_v_B73.s.prim.chr10.bam chr10:151806944-151809342 > MB129-2_v_B73.s.primQ20.gene1.bam
samtools fasta MB129-2_v_B73.s.primQ20.gene1.bam > MB129-2_v_B73.s.primQ20.gene1.fasta

samtools view -Sbq 20 MB129-3_v_B73.s.prim.chr10.bam chr10:151806944-151809342 > MB129-3_v_B73.s.primQ20.gene1.bam
samtools fasta MB129-3_v_B73.s.primQ20.gene1.bam > MB129-3_v_B73.s.primQ20.gene1.fasta
