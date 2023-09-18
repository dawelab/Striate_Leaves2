# Striate_Leaves2

## 1- Deficiency Lines
1.1 Remove adapters and low quality reads
1.2 Map deficiency line data to the Ab10 reference from https://www.maizegdb.org/genome/assembly/Zm-B73_AB10-REFERENCE-NAM-1.0
1.3 Filter the alignemnt files to primary alignments and with a mapping quality greater than or equal to 20 and generate a count file with average read depth per 1 bp as well as 1KB. 1 bp files were used for IGV visual determination of break points . 1 KB files were used to make the plot in XXXX
1.4 Determine the number of genes within the shared region that are missing in Df(K). 
1.5 Plot the data as seen in Supplementary Figure 1. This script uses the file KaryoploteR_genome.csv
