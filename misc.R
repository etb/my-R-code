# R -q
# q('no')
# rm(list = ls(all = TRUE)) ## Clear workspace
# clc <- function() cat(rep("\n",50)) # funk to clear terminal
# clc()

sessionInfo()

options(repos=c("http://cran.at.r-project.org/"))
# chooseCRANmirror(graphics = FALSE)

# install.packages(c("qgraph", "foreign", "mvbutils", "diagram", "gtools", "gdata", "reshape"))
install.packages("Hmisc", dependencies = TRUE)
 # install.packages(c("psych", "ggplot2"), dependencies = TRUE)
# update.packages(ask = FALSE, dependencies = c('Suggests'))
# require(ggplot2)

## List the Files in a Directory/Folder
list.files(pattern = "*.txt")


ptm <- proc.time() 
2+2
print(proc.time() - ptm)


pcon <- pipe("pbpaste")
df <- read.table(pcon, , header = T)
dput(df)
