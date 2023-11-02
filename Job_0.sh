#!/bin/bash -l
# SBATCH --mail-user=bioinformatic2019@gmail.com
# SBATCH --mail-type=end,fail
#SBATCH --output=logs/Job0_%A_%a.out  
#SBATCH --error=logs/Job0_%A_%a.err   
#SBATCH --array=1-5                                         	    # Set number of job-arrays according with the file entries (<targets>.txt)
id=$(sed -n ${SLURM_ARRAY_TASK_ID}p array_target_names.txt)
# id=$( sed -n ${SLURM_ARRAY_TASK_ID}p cat array_target_names.txt)
#SBATCH --partition=shared					                       
#SBATCH --job-name=JA0_CreateFile			                    
#SBATCH --mem=5GB				                                    

# Create log
logpath="/users/csoto/csoto/Slurm_dependecies/logs/"
mkdir -p $logpath
# echo "Log folder created"

module load R


echo "**** SLURM info Job 0 ****"
echo "     Job-array with no dependencies"
date
echo ""
echo "User: ${USER}"
echo "Job name (script): ${SLURM_JOB_NAME}"
echo "Hostname (computer node): ${HOSTNAME}"
echo ""
echo "Job id: ${SLURM_JOBID}"
echo "Task id: ${SLURM_ARRAY_TASK_ID}"
echo ""
echo "Sample name: $id"
echo ""


echo "== Start: create txt file =="
Rscript script_0.R $id
echo "== End of Job =="


## This script was made using JHPCE 3.0 SLURM Cluster
## CSC. Aug 28th, 2023
