#load the modules necessary from the cluster
module load OrthoFinder/2.5.2-foss-2019b-Python-3.7.4

#Define Variables 
DIR="/scratch/mjb51923/Striated/out/OrthoFinder"

#These are the files in the folder $DIR/Ab10_N10_proteomes: Zm-B73_AB10-REFERENCE-NAM-1.0_Zm00043a.1.evd.protein.Ab10HapLongest.fa Zm-B73-REFERENCE-NAM-5.0_Zm00001eb.1.protein.Longest.fa
orthofinder -t 30 -f $DIR/Ab10_N10_proteomes
