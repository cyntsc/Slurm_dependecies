#!/bin/bash -l
#SBATCH --mail-user=bioinformatic2019@gmail.com
#SBATCH --mail-type=end,fail
#SBATCH --output=logs/slurm-%A_%a.out                               # Standard Output FIle. %A is replaced by SLURM_ARRAY_JOB_ID and %a by SLURM_ARRAY_TASK_ID 
#SBATCH --error=logs/slurm-%A_%a.err   
#SBATCH --array=1-5                                         	    #change the number 2 to the number of entries in array_targets.txt
#id=$( sed -n ${SLURM_ARRAY_TASK_ID}p array_targets_names.txt)       # file names
#SBATCH --partition=shared					                        # partition or queue name
#SBATCH --job-name=RStatClub				                        # name job for easier spotting, controlling
#SBATCH --mem=5GB						                            # each job from the array will get its own private 30G to work with)

# You may not place any commands before the last SBATCH directive

# NOTE: This script runs IN THE SAME DIRECTORY in which you ran sbatch
#       So include a cd command to ensure that you run it in the expected
#	directory (where your data files are located) OR use absolute paths
#	when specifying your input and output files

echo "**** Job starts ****"
echo "This bash runs job-array no dependencies"
echo ""
date

echo "**** SLURM info ****"
echo "User: ${USER}"
echo "Job name (script): ${SLURM_JOB_NAME}"
echo "Hostname (computer node): ${HOSTNAME}"
echo ""
echo "Job id: ${SLURM_JOBID}"
echo "Task id: ${SLURM_ARRAY_TASK_ID}"
echo "Sample name: $id"

## load modules
module load R

echo "== Create txt file =="
Rscript 04_create_file.R $id
echo "== End of Job =="


## This script was made using JHPCE 3.0 SLURM Cluster
## CSC. Aug 28th, 2023
