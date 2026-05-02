#PCA Analysis

#Using bcftools
bcftools=/usr/bin/bcftools

#First, convert vcf file to PLINK
plink=/usr/local/plink/plink

#Check to see the samples
$bcftools query -l  Jensen_historical_contemporary_2218loci.vcf

#Compress .vcf file to .vcf.gz
bcftools view Jensen_historical_contemporary_2218loci.vcf -Oz -o Jensen_historical_contemporary_2218loci.vcf.gz

#Index new file
$bcftools index -t Jensen_historical_contemporary_2218loci.vcf.gz

#Convert vcf to plink
$plink --vcf Jensen_historical_contemporary_2218loci.vcf.gz \
--allow-extra-chr \
--make-bed \
--out Jensen_historical_contemporary_2218loci

#Check if bed files have data in it
ls -lht *.bed

#Calculate principle components 
$plink --bfile Jensen_historical_contemporary_2218loci \
--allow-extra-chr \
--pca \
--out out/Jensen_historical_contemporary_2218loci_pca

#Use excel sheet from 01_Heterozygosity.sh to copy sample ID and population information into new file named 'population_map.txt', then copy it to zim server:
scp population_map.txt mpuch@zim.smith.edu:/Users/classes/bio355b/CURE_projects/temporal/data_raw
