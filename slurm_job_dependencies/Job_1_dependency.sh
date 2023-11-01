#!/bin/bash -l
# SBATCH --mail-user=bioinformatic2019@gmail.com
# SBATCH --mail-type=end,fail
#SBATCH --output=logs/%A_%a.out                               # Standard Output FIle. %A is replaced by SLURM_ARRAY_JOB_ID and %a by SLURM_ARRAY_TASK_ID 
#SBATCH --error=logs/%A_%a.err   
#SBATCH --partition=shared					                        # partition or queue name
#SBATCH --job-name=R1dependency
#SBATCH --mem=5GB						                            # each job from the array will get its own private 30G to work with)

echo "**** Job starts ****"
echo "This bash runs with 1 dependency"
echo ""
date

echo "**** SLURM info ****"
echo "User: ${USER}"
echo "Job name (script): ${SLURM_JOB_NAME}"
echo "Hostname (computer node): ${HOSTNAME}"
echo ""
echo "Job id: ${SLURM_JOBID}"

## load modules
module load R

echo "**** Job starts ****"
echo "This is job dependency 1"

echo "== Create txt files and add lines to files =="

jobID=$(sbatch --parsable Job_0.sh)
echo ${jobID}
sbatch --dependency=afterok:${jobID} Job_1.sh

echo "== End of Job =="

## This script was made using JHPCE 3.0 SLURM Cluster
## CSC. Aug 28th, 2023