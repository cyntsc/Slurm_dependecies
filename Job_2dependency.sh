#!/bin/bash -l
# SBATCH --mail-user=bioinformatic2019@gmail.com
# SBATCH --mail-type=end,fail
#SBATCH --output=logs/Dep2_%A_%a.out                               
#SBATCH --error=logs/Dep2_%A_%a.err   
#SBATCH --partition=shared					                        # partition or queue name
#SBATCH --job-name=J2dependency
# SBATCH --array=1-5                                         	    # Job main name 
#SBATCH --mem=5GB						                            # You do not need the array declaration here


echo "**** SLURM with DEPENDENCY info ****"
echo "     START Job-Array with 2 dependencies nested."
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
echo "Job-Array. Dependency 1 ID: ${ArrayAID}"
echo ""
# Add lines to pre-existing file
ArrayBID=$(sbatch --parsable --array=1-5 --dependency=aftercorr:${ArrayAID} Job_1.sh)
echo "Job-Array. Dependency 2 ID: ${ArrayBID}"
echo ""
# Add numbers to pre-existing file
# This will runs after first and second dependencies have been completed. 
sbatch --array=1-5 --dependency=aftercorr:${ArrayBID} Job_2.sh

# This is an arrangment for indendent process 
# sbatch --array=1-5 --dependency=aftercorr:${ArrayAID} ${ArrayBID} Job_2.sh

echo "=== End of Job ==="


# jobID=$(sbatch --parsable Job_0.sh)
# echo ${jobID}
# sbatch --dependency=afterok:${jobID} Job_1.sh


## This script was made using JHPCE 3.0 SLURM Cluster
## CSC. Aug 28th, 2023