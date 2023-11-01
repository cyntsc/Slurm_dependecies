#!/bin/bash -l
# SBATCH --mail-user=bioinformatic2019@gmail.com
# SBATCH --mail-type=end,fail
#SBATCH --output=logs/%A_%a.out                               # Standard Output FIle. %A is replaced by SLURM_ARRAY_JOB_ID and %a by SLURM_ARRAY_TASK_ID 
#SBATCH --error=logs/%A_%a.err   
#SBATCH --partition=shared					                        # partition or queue name
#SBATCH --job-name=RClub0				                        # name job for easier spotting, controlling
#SBATCH --mem=5GB						                            # each job from the array will get its own private 30G to work with)

echo "**** Job starts ****"
echo "This bash runs with no dependencies"
echo ""
date

echo "**** SLURM info ****"
echo "User: ${USER}"
echo "Job name (script): ${SLURM_JOB_NAME}"
echo "Hostname (computer node): ${HOSTNAME}"
echo ""
echo "Job id: ${SLURM_JOBID}"

module load R

echo "== Create txt file =="

Rscript script_0.R

echo "== End of Job =="


## This script was made using JHPCE 3.0 SLURM Cluster
## CSC. Aug 28th, 2023
