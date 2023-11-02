library(here)
library(purrr)
here::here()


########################### Add vector of numbers to pre-existing file

sub_dir <- here('/fastscratch/myscratch/csoto/Slurm_dependecies', 'outputs/')

# if (!file.exists(sub_dir)){ stop('Directory does not exists') }

# scan the argument and compose a file name
x_name <- commandArgs(trailingOnly = TRUE)
print(x_name)
file_name <- paste0(sub_dir, x_name)

# write a header
line2 <- toString(seq(1,50))
line3 <- toString(seq(51,100))
line4 <- paste0('These are numeric vectors for ', basename(file_name), '\n\n')

# cat function to append the text to the text file 
cat(line2, line3, line4, sep = "\n", file = file_name, append = TRUE) 

message('Done!')
