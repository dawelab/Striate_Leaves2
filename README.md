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

