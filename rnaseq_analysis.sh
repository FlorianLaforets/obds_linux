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
