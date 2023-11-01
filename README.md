# Slurm_dependecies
## Building pipelines using slurm dependencies

Here briefly provide easy samples to understand slurm-dependency and slurm-array dependency concepts

***

### Introduction to Job array and Job dependency 

A **Job-array** is the best and recommended way to submit many jobs (>100) using SLURM’s jobs array feature. The job arrays allow managing big number of jobs more effectively and faster. To specify job array use *--array*, follow for the number of jobs you will have in array:

Some examples are:

**--array=0-9**: there are 10 jobs in array. The first job has index 0, and the last job has index 9.

**--array=5-8**: there are 4 jobs in array. The first job has index 5, and the last job has index 8.

**--array=2,4,6**: there are 3 jobs in array with indices 2, 4 and 6.

<br>

A **Job-dependency** in contrast is a particular *Job* that must be launched only after previous *jobs* were successfully completed. SLURM provides a way to implement such pipelines with its *--dependency* option.

Dependency options available are:

**--dependency=afterok:<job_id>**: Submitted job will be launched if and only if job with job_id identifier was successfully completed. If job_id is a job array, then all jobs in that job array must be successfully completed.

**--dependency=afternotok:<job_id>**: Submitted job will be launched if and only if job with job_id identifier failed. If job_id is a job array, then at least one job in that array failed. This option may be useful for cleanup step.

**--dependency=afterany:<job_id>**: Submitted job wil be launched after job with job_id identifier terminated i.e. completed successfully or failed.

<br>


Now, with these two SLURM's options we can build pipelines combining job-arrays with slurm dependencies. 

### Job-array to Job-dependency file association

1. In figure 1A and 1B, we have association 1:1, one R-script to 1 Slurm-Job. 

![Image 1.Job0_Job1](images/fig1_slurm_array.png) Image 1. Job_1 is a dependency of Job_0. <br><br>


The Job_0 is a job-array that triggers 5 processes to build 5 txt files.
The Job_1 is a job-array that triggers 5 processes to add lines to pre-existing files. So, *Job_1* must be launched only after previous *Job_0* were successfully completed, in other words, it is a dependency file of Job_0.

<br>

2. To add a bit more of complexity, now let's add a third script to add a numeric line to the pre-exisiting files after the *Job_0* and *Job_1* were successfully completed.

![Image 2.Job0_Job1_Job2](images/fig2_slurm_array.png) Image 2. Job_1 and Job2 are dependency files of Job_0. <br><br>


Now we need to link these dependencies in a logic way to build a Slurm-array with dependencies pipeline.


To link the first job dependency:

```slurm
# Create 5 txt files and add lines to them"
ArrayAID=$(sbatch --parsable --array=1-5  Job_0.sh)
echo "Job-Array. ID: ${ArrayAID}"
echo ""
# This will runs after first dependency has been completed. Add lines to pre-existing file.
sbatch --array=1-5 --dependency=aftercorr:${ArrayAID} Job_1.sh
```

**--parsable** option capture the slurm ID (number) assigned to control each *Array Id*. Thus, with *ArrayAID* variable we can conditioned the next task. 

After successfully completed the corresponding array process using the *ArrayAID*, it starts the corresponding array process in Job_1

<br>

To link the first and second job dependencies:

```slurm
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
```


Again we use **--parsable ** option, but now beside to capture the *ArrayAID*, we also capture *ArrayBID* to condition the next process in Job_2. 

After successfully completed the corresponding array-id process *ArrayAID* and *ArrayBID*, it starts the next array-id process in Job_2.

<br>

More examples provided below highlight the relevance of Slurm job design to properly build the workflow.

### Examples with job-dependency 

![Image 3.Fig3](images/fig3_slurm_array.png) Image 3. Job with one dependency. <br><br>

<br>

![Image 4.Fig4](images/fig4_slurm_array.png) Image 4. Job with two dependencies. <br><br>

<br>

### Examples with Job-array dependencies recursively

A task of this job array can begin execution after the corresponding task ID in the specified job has completed successfully.

![Image 5.Fig5](images/fig5_slurm_array.png) Image 5. Job-array dependencies nested. <br><br>

<br>

![Image 5.Fig6](images/fig6_slurm_array.png) Image 5. Job-array dependencies nested 2. <br><br>

<br>


***

<br>


*Cynthia SC*

Nov 3rd, 2023

<br>

***


