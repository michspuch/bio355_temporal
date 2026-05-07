### Estimate nucleotide diversity (pi) in windows back in Zim

#Go to data_raw folder
cd /Users/classes/bio355b/CURE_projects/temporal/data_raw

#Load vcftools
vcftools=/usr/local/bin/vcftools

#Read the compressed file and calculate windowed nucleotide diversity
$vcftools --gzvcf Jensen_historical_2218loci.vcf.gz --window-pi 1000 --out out/Jensen_historical_2218loci_10000
$vcftools --gzvcf Jensen_contemporary_2218loci.vcf.gz --window-pi 1000 --out out/Jensen_contemporary_2218loci_10000

#Inspect files:
head out/Jensen_contemporary_2218loci_10000.windowed.pi
head out/Jensen_historical_2218loci_10000.windowed.pi

#Calculate mean pi for 1906 and 2014:
awk 'NR > 1 {sum += $6; n += 1} END {print "Mean pi (2014):", sum/n}' out/Jensen_contemporary_2218loci_10000.windowed.pi

awk 'NR > 1 {sum += $6; n += 1} END {print "Mean pi (1906):", sum/n}' out/Jensen_historical_2218loci_10000.windowed.pi

#Move forward with visualizing pi in RStudio








