# create a file with a header on it
library(here)
here::here()

# create output dir
sub_dir <- here('pattern_scripts_slurm', 'slurm_array_job_dependencies/outputs/')
if (!file.exists(sub_dir)){ dir.create(file.path(sub_dir)) }

# scan the argument and compose a file name
x_name <- commandArgs(trailingOnly = TRUE)
print(x_name)
file_name <- paste0(sub_dir, x_name)
file.create(file_name)

# write a header
header_l1 <- paste0('This is the header for ', basename(file_name))
# cat function to append the text to the text file 
cat(header_l1, sep = "\n", file = file_name, append = TRUE) 

message('Done!')

# csc.oct.2023

