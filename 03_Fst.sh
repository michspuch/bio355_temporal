#Calculate Fst


#Set up vcftools:
vcftools=/usr/local/bin/vcftools

#Split vcf file into historical and contemporary
#Make a .txt file for historical and contemporary population, then copy sample IDs into each file accordingly
#For historical:
touch keep_historical.txt
nano keep_historical.txt

#For contemporaru:
touch keep_contemporary.txt
nano keep_contemporary.txt

#Make new vcf files
#Historical:
vcftools --vcf data_raw/Jensen_historical_contemporary_2218loci.vcf --keep data_raw/keep_historical.txt --remove data_raw/keep_contemporary.txt --recode --recode-INFO-all --out data_processed/Jensen_historical_only.vcf

#Contemporary:
vcftools --vcf data_raw/Jensen_historical_contemporary_2218loci.vcf --keep data_raw/keep_contemporary.txt --remove data_raw/keep_historical.txt --recode --recode-INFO-all --out data_processed/Jensen_contemporary_only.vcf

#Convert vcf to vcf.gz
#Historical
$bcftools view -Oz -o Jensen_historical_only.vcf.gz Jensen_historical_only.vcf.recode.vcf

#Contemporary
$bcftools view -Oz -o Jensen_contemporary_only.vcf.gz Jensen_contemporary_only.vcf.recode.vcf

#Index the files
#Historical
$bcftools index -t data_processed/Jensen_historical_only.vcf.gz 

#Contemporary
$bcftools index -t data_processed/Jensen_contemporary_only.vcf.gz 

#Make a script & open the script:
touch /Users/classes/bio355b/CURE_projects/temporal/script2/run_pairwise_fst.sh
nano /Users/classes/bio355b/CURE_projects/temporal/script2/run_pairwise_fst.sh

#Edit the run_pairwise_fst.sh script:
#!/bin/bash

LABDIR=/Users/classes/bio355b/CURE_projects/temporal/data_processed
OUTDIR=/Users/classes/bio355b/CURE_projects/temporal/results

mkdir -p "$OUTDIR"

    # Merge the two population VCFs into a temporary pairwise VCF
    bcftools merge \
      "$LABDIR/Jensen_historical_only.vcf.gz" \
      "$LABDIR/Jensen_contemporary_only.vcf.gz" \
      -Oz \
      -o "$OUTDIR/Jensen_pairwise.vcf.gz"

    bcftools index "$OUTDIR/Jensen_pairwise.vcf.gz"

    # Extract sample names for each original population
    bcftools query -l "$LABDIR/Jensen_historical_only.vcf.gz" > "$LABDIR/keep_historical_only.txt"
    bcftools query -l "$LABDIR/Jensen_contemporary_only.vcf.gz" > "$LABDIR/keep_contemporary_only.txt"

    # Run pairwise FST
    vcftools --gzvcf "$OUTDIR/Jensen_pairwise.vcf.gz" \
      --weir-fst-pop "$LABDIR/keep_historical_only.txt" \
      --weir-fst-pop "$LABDIR/keep_contemporary_only.txt" \
      --out "$OUTDIR/Jensen_pairwise_fst"

echo "All pairwise FST comparisons done."


#Make the script executable:
chmod +x /Users/classes/bio355b/CURE_projects/temporal/script2/run_pairwise_fst.sh

#Run the script:
./script2/run_pairwise_fst.sh


#Use 'head' to see output
head/Jensen_pairwise_fst.weir.fst


#Count FST values (2219 in all)
wc -l Jensen_pairwise_fst.weir.fst

#Check for positive Fst 
command | awk '$3 > 0' Jensen_pairwise_fst.weir.fst | wc -l

#Check for Fst greater than 0.1 
command | awk '$3 > 0.1' Jensen_pairwise_fst.weir.fst | wc -l

#Check for Fst greater than 0.05
command | awk '$3 > 0.05' Jensen_pairwise_fst.weir.fst | wc -l




