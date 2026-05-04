# Calculate Minor Allele Frequency

#Log into zim and go to temporal/data_raw folder:
cd /Users/classes/bio355b/CURE_projects/temporal/data_raw

#Load bcftools

bcftools=/usr/bin/bcftools
 
#List all sample names stored in the VCF. 
 
$bcftools query -l  Jensen_historical_contemporary_2218loci.vcf.gz
 
#Copy sample IDs onto excel sheet column, add the according year to the column to the right, 
#then use CONCAT function in Excel to combine both values

#Ex: CONCAT Sample_8315 and -1906 for Sample_8315-1906

#Create .txt file
 touch tortoise_samples.txt
nano tortoise_samples.txt
 
#Copy  CONCATed column into tortoise_samples.txt, save then exit

#Use head and wc -l to make sure everything looks fine in file
 head tortoise_samples.txt
 
wc -l tortoise_samples.txt
 

#Create a metadata file
 
echo -e "sample_id\tpopulation\tyear\tlabel" > tortoise_samples.tsv
 

#Populate from .txt file
awk '{
  if ($0 ~ /2014/) {
    print $0 "\tcontemporary\t2014\t2014"
  } else if ($0 ~ /1906/) {
    print $0 "\thistorical\t1906\t1906"
  }
}' tortoise_samples.txt >> tortoise_samples.tsv
 

#Check to see if it looks okay
 head tortoise_samples.tsv
 
#Because metadata file has a header row, adjust for NR > 1
 
awk 'NR > 1 && $3 == 1906 {print $1}' tortoise_samples.tsv > tortoise_samples_1906.txt
awk 'NR > 1 && $3 == 2014 {print $1}' tortoise_samples.tsv > tortoise_samples_2014.txt
 
 #If no header row, input as follow:
awk '$3 == 1906 {print $1}' tortoise_samples.tsv > tortoise_samples_1906.txt
awk '$3 == 2014 {print $1}' tortoise_samples.tsv > tortoise_samples_2014.txt
 

#Check the sample lists
 
cat tortoise_samples_2014.txt
cat tortoise_samples_1906.txt
 
#Count the number of samples in each:
 
wc -l tortoise_samples_2014.txt
wc -l tortoise_samples_1906.txt
 

#Because the sample IDs were changed, the samples in the Jensen_historical_contemporary_2218loci.vcf.gz 
#need to be changed too:
 touch new_sample_names_MAF.txt
nano new_sample_names_MAF.txt
 
#In new_sample_names_MAF.txt, use Excel to  make two columns for the old sample and new sample names: 
#Example: Sample_8315	Sample_8315-1906

#Exit and then add to make a new vcf file:
bcftools reheader -s new_sample_names_MAF.txt -o Jensen_historical_contemporary_2218locinew.vcf.gz Jensen_historical_contemporary_2218loci.vcf.gz
 
#Now create one VCF for each timepoint.
$bcftools view -S tortoise_samples_2014.txt -Oz -o Jensen_contemporary_2218loci.vcf.gz  Jensen_historical_contemporary_2218locinew.vcf.gz 
$bcftools view -S tortoise_samples_1906.txt -Oz -o Jensen_historical_2218loci.vcf.gz  Jensen_historical_contemporary_2218locinew.vcf.gz
 

#Index both files:
$bcftools index -t Jensen_historical_2218loci.vcf.gz
$bcftools index -t Jensen_contemporary_2218loci.vcf.gz 
 

#Count samples in each subset
 $bcftools query -l Jensen_contemporary_2218loci.vcf.gz | wc -l
$bcftools query -l Jensen_historical_2218loci.vcf.gz  | wc -l
 

#Count variants in each subset
 $bcftools view -H Jensen_contemporary_2218loci.vcf.gz | wc -l
 $bcftools view -H Jensen_historical_2218loci.vcf.gz  | wc -l
 

#Estimate allele frequencies for each timepoint by loading vcftools
vcftools=/usr/local/bin/vcftools
 

#Use vcftools --freq and output .frq files to `out` folder:
 $vcftools --gzvcf Jensen_contemporary_2218loci.vcf.gz --freq --out out/Jensen_contemporary_2218loci
 $vcftools --gzvcf Jensen_historical_2218loci.vcf.gz --freq --out out/Jensen_historical_2218loci
 

#Check files by using `ls` on 'out' directory
#Check the output of frequencies by using `less`: 
 
less Jensen_historical_2218loci.frq
less Jensen_contemporary_2218loci.frq

#Move to R after




 
