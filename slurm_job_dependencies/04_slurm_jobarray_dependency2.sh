#!/bin/bash -l
#SBATCH --mail-user=bioinformatic2019@gmail.com
#SBATCH --mail-type=end,fail
#SBATCH --output=logs/slurm-%A_%a.out                               # Standard Output FIle. %A is replaced by SLURM_ARRAY_JOB_ID and %a by SLURM_ARRAY_TASK_ID 
#SBATCH --error=logs/slurm-%A_%a.err   
#SBATCH --array=1-5                                         	    #change the number 2 to the number of entries in array_targets.txt
#id=$( sed -n ${SLURM_ARRAY_TASK_ID}p array_targets_names.txt)       # file names
#SBATCH --partition=shared					                        # partition or queue name
#SBATCH --job-name=RStatClub				                        # name job for easier spotting, controlling
#SBATCH --mem=5GB				                        # name job for easier spotting, controlling

## load modules
module load R

echo "**** Job starts ****"
echo "This is job dependency 1"
echo "I'm using output from main job"

# first job - no dependencies
#jid1=$(sbatch 04_slurm_jobarray_main.sh)

#echo "JobID main $jid1"

ID=$(sbatch --parsable $1)
shift 
for (sbatch 04_slurm_jobarray_main.sh) in "$@"; do
  ID=$(sbatch --parsable --dependency=after:${ID}:+5 $script)
done

echo "Call file with dependency"

#sbatch -d afterok:$jid1 04_slurm_jobarray_dependency2.sh $id

echo "== End of Job =="

## This script was made using JHPCE 3.0 SLURM Cluster
## CSC. Aug 28th, 2023
