#Moved Galapagos historical and contemporary files from home server in Downloads directory to Smith server:
scp Jensen_historical_contemporary_2218loci.vcf mpuch@zim.smith.edu:/Users/classes/bio355b/CURE_projects/temporal/data_raw

#Calculate heterozygosity
#Assign vcf:
vcftools=/usr/local/bin/vcftools

#Go to folder:
cd /Users/classes/bio355b/CURE_projects/temporal/data_raw

#Used this link: https://gwct.bio/congen/bioinformatics/wolf-snps.html to calculate how many SNPs there are (2218 SNPs):
 grep -v "#" Jensen_historical_contemporary_2218loci.vcf | wc -l

#Use 'head' to make sure the file looks okay
head out/Jensen_historical_contemporary_2218loci.vcf.het

#The above gives runs of homozygosity. To calculate for heterozygosity, the data were copied into a Notepad file, and then to an excel sheet and was calculated there by (N_SITES-O(HOM))/N_SITES, then averaged out.
