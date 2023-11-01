#!/bin/bash -l
# SBATCH --mail-user=bioinformatic2019@gmail.com
# SBATCH --mail-type=end,fail
#SBATCH --output=logs/Dep1_%A_%a.out                               
#SBATCH --error=logs/Dep1_%A_%a.err   
#SBATCH --partition=shared					                        # partition or queue name
#SBATCH --job-name=J1dependency
# SBATCH --array=1-5                                         	    # Job main name 
#SBATCH --mem=5GB						                            # You do not need the array declaration here


echo "**** SLURM with DEPENDENCY info ****"
echo "     START Job-Array with 1 dependency nested."
# echo "User: ${USER}"
# echo "Job name (script): ${SLURM_JOB_NAME}"
# echo "Hostname (computer node): ${HOSTNAME}"
echo ""
echo "Job id: ${SLURM_JOBID}"
date
echo ""

# module load R

# Create 5 txt files and add lines to them"
ArrayAID=$(sbatch --parsable --array=1-5  Job_0.sh)
echo "Job-Array. ID: ${ArrayAID}"
echo ""
# This will runs after first dependency has been completed. Add lines to pre-existing file.
sbatch --array=1-5 --dependency=aftercorr:${ArrayAID} Job_1.sh

echo "=== End of Job ==="

## This script was made using JHPCE 3.0 SLURM Cluster
## CSC. Aug 28th, 2023