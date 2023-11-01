library(here)
here::here()

# create output dir
sub_dir <- here('pattern_scripts_slurm', 'slurm_job_dependencies/outputs/')
if (!file.exists(sub_dir)){ dir.create(file.path(sub_dir)) }

# Create a file with a specific name
file_name <- paste0(sub_dir,'file_Job0_all.txt')
file.create(file_name)

# create x additional files with a generic name-pattern
sapply(paste0(sub_dir,"f_", 1:3, ".txt"), file.create) 

message('Created file')
