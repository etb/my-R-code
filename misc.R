# rm(list = ls(all = TRUE)) ## Clear workspace
  sessionInfo()

options(repos=c("http://cran.at.r-project.org/"))
# chooseCRANmirror(graphics = FALSE)

# install.packages(c("psych", "qgraph", "foreign", "mvbutils", "diagram", "gtools", "gdata", "ggplot2", "reshape"))
install.packages("Hmisc", dependencies = TRUE)
# update.packages()

## List the Files in a Directory/Folder
list.files(pattern = "*.txt")


ptm <- proc.time() 
2+2
print(proc.time() - ptm)
