# Striate_Leaves2

## 1- Deficiency Lines
1. Remove adapters and low quality reads
2. Map deficiency line data to the Ab10 reference from https://www.maizegdb.org/genome/assembly/Zm-B73_AB10-REFERENCE-NAM-1.0
3. Filter the alignemnt files to primary alignments and with a mapping quality greater than or equal to 20 and generate a count file with average read depth per 1 bp as well as 1KB. 1 bp files were used for IGV visual determination of break points . 1 KB files were used to make the plot in 1.5
4. Determine the number of genes within the shared region that are missing in Df(K). 
5. Plot the data as seen in Supplementary Figure 1. This script uses the file KaryoploteR_genome.csv

## 2- OrthoFinder
1. Identify all of the gene names on the Ab10 haplotype
2. Select all of the protein sequences in fasta format associated with the Ab10 haplotype genes identified in 2.1
3. Identify the longest isoform for each gene on the Ab10 haplotype using the file generated in 2.2
4. Select the longest protein sequence in fasta format for all genes on the Ab10 haplotye idetified in 2.3
5. Identify the longest isoform for all genes in the B73-N10 genome. This includes all chromosomes.
6. Select all of the longest isoform protein sequences in fasta format from the B73-N10 genome identified in 2.5
7. Runs OrthoFinder using the protein fasta files generated in 2.1-6
8. Plots the data from OrthoFinder

## 3- RNAseq
1. Trim adapter sequences and remove low quality regions from raw reads
### Differential Expression
2. Align the trimmed reads to the B73-N10 v5 genome
3. Count the number of reads over each feature in the annotation file
4. Perform differential expression analysis and plot it
5. Calculate transcripts per million (TPM) for my data to make it comparable with data from 3.6
6. This file was provided by Yibing Zeng and generated in the publication of  10.1126/science.abg5289  and https://doi.org/10.1101/2023.01.23.525249.
7. Plots the expression data from 3.5 and 3.6
### De Novo Transcriptome Assembly 
8. Perform Trinity assembly using the trimmed and quality filtered reads generated in 3.1 for the all of the sr2 individuals (pooled)
9. Determine the relative expression of each isoform for the sr2 gene
10. Plot the results from 3.9
11.  Filter and subset the alignments generated in 3.2 to just around the sr2 gene
12. Identify reads with homology to the CASP like protein and/or the transposon.
13. Determine wich reads or read pairs have homology to BOTH sr2 and the CASP like protein/transposon

