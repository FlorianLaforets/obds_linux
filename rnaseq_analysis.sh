########## Run FastQC ##########

load_mamba # Load evironment using previously created aliases

cd ./linux/2_rnaseq # Go to 2_rnaseq folder

mkdir ./3_analysis/1_fastqc # Create the output directory (fastqc does not create it automatically)
fastqc --help # if needed to leanrn about fastqc command

# Run on two files in one go. use -o to specify tge outiput directort
fastqc ./1_fastq/cd4_rep1_read1.fastq.gz ./1_fastq/cd4_rep1_read2.fastq.gz -o ./3_analysis/1_fastqc

# Use FIlezilla to access the cluster and copy the .htlm fastqc .html output file on your local machine
# Opent he files with a web browser and inspect them

######## Run multiqc ########

multiqc --help # if needed to learn about the command
mkdir ./3_analysis/reports/ # Create output directory for multiqc report
multiqc -o ./3_analysis/reports/ ./3_analysis/ # Use -o to specify the output directory

# With Filezilla, copy the multiqc report from the cluster to your local machine and open them in a web browser to inspect them

######## Run FastQC jobs on the cluster #########

cd ./linux/2_rnaseq/3_analysis/1_fastqc ## Change to the fastqc file directory
load_mamba # Load the env using the alias
cp /project/shared/linux/4_slurm/slurm_template.sh . # Copy the slurm file to the fastqc directory
ls # check file has been copied

# In a different terminal tab (CMD + t):
cd /project/clab0723/linux/2_rnaseq/3_analysis/1_fastqc # Change to the directory where the slurm_template.sh has been copied
nano slurm_template.sh # Open the file in the nano editor

# Edit the slurm script file with appropriate memory, time and number of tasks, along with input and output paths. The edited slurm_template.sh file is in the repo as well.
# NB: I can use multiple CPUs if I have multiple jobs (provided they're available)
cd /project/clab0723/linux/2_rnaseq/3_analysis # Change to the directory that contains the .sh script file
sbatch slurm_template.sh # run the script
watch squeue --me # Check my job
less <jobid>_slurm_template.sh.out # Check log when job's finished
less <jobid>_slurm_template.sh.err # Check error messages

######### Run Histat2 on the cluster ##########

cd /project/clab0723/linux/2_rnaseq/3_analysis # Change to the relevant working directory
# Create a new .sh script file that contains all the info to run the hisat command
# Adjust the memory (10G), the number of task (equals threads => 8) and specify the function.
# The script file (slurm_histat.sh) template is added to the repo
watch squeue --me # Check my job is running
less <jobid>_slurm_template.sh.out # Check log when job's finished
less <jobid>_slurm_template.sh.err # Check error messages

######### Convert Sam files to Bam and QC ###########
load_mamba # Load the env using the alias
cd /project/clab0723/linux/2_rnaseq/3_analysis # Change to the directory that contains the .sh script file.sam file (output of histat)
# Check .sam file with one or several of the follwoing options:
head aln-pe.sam # Check top of .sam file
tail aln-pe.sam # Check end of .sam file
less aln-pe.sam # Check all of .sam file

# Create a .sh script that will:
# 1 - Convert the sam file to bam 
# 2 - Sort the new bam file (1 and 2 can be piped) (specify output for 2)
# 3 - Index the sorted bam file
# 4 - Run samtools flagstat (specify output so it doesn't print to terminal or to .out file)
# 5 - Run samtools idxstats (also specify output)
# Adjust the memory (10G) and time (1h).
# The corresponding script is slurm_sam_to_bam.sh. It is included in the repository.

multiqc -o ./multiqc_report . # Run multiqc on the 3_analysis folder. This will produce the same compilation of analysis as before but also add the info produced from the .sam and .bam files

########## Run featureCounts ###########
# Create a .sh script that will run the featureCounts command
# Use the mouse genome reference file downloaded previously: /project/clab0723/linux/2_rnaseq/2_genome/Mus_musculus.GRCm39.115.gtf.gz
# Output to count.txt
# Use argument -s 2 because the data is reversly stranded
# Use argument -p because the data is paired-end
# Optional: specify the number of CPUs. Use used 4: -T 4
# The corresponding script, slurm_featureCounts.sh,  is in the repository






