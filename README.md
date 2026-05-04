
# BIO355 CURE Project – Temporal Change & Monitoring

## Dataset

-   Source (DOI / link): https://doi.org/10.5061/dryad.7tp3sg0
-   Species/system: Pinzón Island Galápagos Giant Tortoise (Chelonoidis duncanensis)
-   Data type (e.g., VCF, FASTA): VCF File - Jensen_historical_contemporary_2218loci.vcf
-   The file was used to assess temporal change between two time points (1906 and 2014)

------------------------------------------------------------------------

## Research questions

1.  What was the genetic diversity of the tortoises after the 19th century bottlenecks?

2.  How has the genetic diversity of the tortoises changed after conservation management?

3.  Do genetic diversity trends between the two time points indicate a successful conservation action?

------------------------------------------------------------------------

## Analyses

-   Heterozygosity
-   PCA 
-   Pairwise FST
-   Allelic Richness

------------------------------------------------------------------------

## Folder structure

-   `data_raw/` → original downloaded data, sample lists, population assignments\
-   `data_raw/out` → filtered/modified data\
-   `script2/` → analysis scripts\

------------------------------------------------------------------------

## Workflow notes

Brief summary of your workflow: 
- The VCF file already 
- Key analysis steps 
- Any important decisions

------------------------------------------------------------------------

## Notes

-   Challenges:
-       PLINK package was used when attempting ROH analysis with RADseq data, but 0 ROH kept appearing even when trying out different flags. 







