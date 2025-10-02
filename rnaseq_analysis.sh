# Load evironment using previously created aliases
load_mamba

# Go to 2_rnaseq folder
cd ./linux/2_rnaseq

# Run FastQC
## Create the output directory (fastqc does not create it automatically)
## Run on two files in one go. use -o to specify tge outiput directort

mkdir ./3_analysis/1_fastqc
fastqc --help # if needed to leanrn about fastqc command
fastqc ./1_fastq/cd4_rep1_read1.fastq.gz ./1_fastq/cd4_rep1_read2.fastq.gz -o ./3_analysis/1_fastqc

# Use FIlezilla to access the cluster and copy the .htlm fastqc .html output file on your local machine
# Opent he files with a web browser and inspect them

# Run multiqc
multiqc --help # if needed to learn about the command

mkdir ./3_analysis/reports/ # Create output directory for multiqc report
multiqc -o ./3_analysis/reports/ ./3_analysis/ # Use -o to specify the output directory

# With Filezilla, copy the multiqc report from the cluster to your local machine and open them in a web browser to inspect them
