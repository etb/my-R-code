##############################################################
#####       Author: etb                                   ####
#####       Date Created: Fri Feb 24 01:04:00PM 2012      ####
#####       Version 1.0:                                  ####
#####       The scrips: script for loop over files        ####
#####                   and merging it all to one         ####
#####                   data frame.                       ####
##############################################################
# rm(list = ls(all = TRUE)) ## Clear Workspace

dir <- "/../"

fnames <- list.files(path = dir, pattern = ".csv")
# read.csv(paste(dir,fnames[[1]],sep = ""))

## reading the data
dfn = list()
for (string in fnames){
dfn[[string]]=read.csv(paste0(dir,string))
}

## clean up
rm("dir", "fnames", "string")

## remove the .csv suffix
names(dfn) <- strsplit(names(dfn),".csv")

## merging the data frames together (traditional)
DF.1 <- dfn[[1]]
for ( .df in dfn) {
	DF.1 <- merge(DF.1, .df, by.x="ID", by.y="ID", all.x=T,
	           suffixes=paste(":", names(dfn), sep = ""))
}

##  merge with uniqe suffix' (merging with function)
    changenm = function(nm){
        df = dfn[[nm]]
        wh = names(df) != 'ID'
        names(df)[wh] = paste(names(df)[wh],nm,sep=':')
        df
    }

DF.2 <- Reduce(function(x,y)merge(x,y,by='ID'),lapply(names(dfn),changenm))

## stacking the data with rbind, to Nick
Stack <- dfn[[1]]
for ( .df in dfn[-1]) {
	Stack <- rbind(Stack, .df)
}

head(Stack); tail(Stack)
