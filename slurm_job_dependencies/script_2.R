library(here)
library(purrr)
here::here()


########################### Add info to an existing file

sub_dir <- here('pattern_scripts_slurm', 'slurm_job_dependencies/outputs/')

if (!file.exists(sub_dir)){ stop('Directory does not exists') }

# Create another bunch of files

# create x additional files with a generic name-pattern
sapply(paste0(sub_dir,"f2_", 1:3, ".txt"), file.create) 

message('Created file')


files_txt <- list.files(path=sub_dir, pattern="f2*.txt", all.files=TRUE, full.names=TRUE)

# Function to add info to each file
write_smtg <- function(filex) {
    
    # write a header
    l1_header <- paste0('___This is the 2nd line of file #', basename(filex))
    # cat function to append the text to the text file 
    cat(l1_header, sep = "\n", file = filex, append = TRUE) 
    
}    

# map to parse the vector and add the line of text
map(files_txt, write_smtg)

message('Done!')
