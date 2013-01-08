##############################################################
#####       Author: Esben Baek                            ####
#####       Date Created: Tue Jan 8  1:04:00PM 2013       ####
#####       Version 0.1                                   ####
#####       The scrips: Demonstates how to pull and push  ####
#####                   data from a REDCap server using R ####
##############################################################


####################################################################
##                                                                ##
##            Define Parameters, token and REDCap url             ##
##                                                                ##
# setwd('/.../')

# read your certificate, ask your REDCap provider about obterining this.
# If you are on a closed network you can turn this efture of by changing,
# ".opts=curlOptions(ssl.verifypeer=TRUE, cainfo=REDCap.crt)" to 
# ".opts=curlOptions(ssl.verifypeer=FALSE)" I added the 
# "verbose=FALSE" to the code to make it esey to siwch this to TRUE and
# get a better understanindg of what RCurl is doing.
REDCap.crt <- '/.../[some file name].cert'

# Your REDCap issued token, I read mine from a text file
Redcap.token <- readLines("/.../Redcap.token.txt") # Read API token from keys folder

# REDCAp site API-URL, vil mostlike be the site where you normally login + api
REDcap.URL  <- ''

####################################################################
##                                                                ##
##                      Get data from REDCap                      ##
##                                                                ##
require(RCurl)

RAW.API <- postForm(REDcap.URL, token=Redcap.token, content="record", 
           type="flat", format="csv", rawOrLabel="Label", 
           .opts=curlOptions(ssl.verifypeer=TRUE, cainfo=REDCap.crt, 
           verbose=FALSE))

####################################################################
##                                                                ##
##      Transform and subset data workable R data frame           ##
##                                                                ##
Rawdata <- read.table(file = textConnection(RAW.API), header = TRUE, 
                      sep = ",", na.strings = "", stringsAsFactors = FALSE)
rm(RAW.API)
data <- Rawdata

####################################################################
##                                                                ##
##      Your R thing ...                                          ##
##                                                                ##
...

####################################################################
##                                                                ##
##        Parse data frame back to bizarro REDCap format          ##
##                                                                ##

# This function needs to be optimized

ParseRtoREDCap <- function(df) {
    ## Replace NA with "", converting column types as needed
    df[] <- lapply(df, function(X) {
                if(any(is.na(X))) {X[is.na(X)] <- ""; X} else {X}
            })

    ## Print integers in first column as 2-digit character strings
    ## (DO NOTE: Hardwiring the number of printed digits here is probably
    ## inadvisable, though needed to _exactly_ reconstitute RAW.API.) 
    df[[1]] <- sprintf("%1.0f", df[[1]])

    ## Separately build header and table body, then suture them together 
    l1 <- paste(names(df), collapse=",")
    l2 <- capture.output(write.table(df, sep=",", col.names=FALSE, 
                                     row.names=FALSE))
    out <- paste0(c(l1, l2, ""), collapse="\n")

    ## Reattach attributes
    att <- list("Content-Type" = structure(c("text/html", "utf-8"), 
                .Names = c("", "charset")))
    attributes(out) <- att
    out
}

API.OUT <- ParseRtoREDCap(data)

# Heavily inspired by this http://stackoverflow.com/a/12435389/1305688# answer at SO, thanks to Josh O'Brien. 
####################################################################
##                                                                ##
##                  Push files to REDCap                          ##
##                                                                ##

# I've wrapped my 'postForm()' in a 'cat()' to make any respone from
# the REDCap server reasdebel.

cat(postForm(REDcap.URL, data=API.OUT, token=Redcap.token, content="record", type="flat", format="csv",returnFormat="csv", overwriteBehavior="overwrite", .opts=curlOptions(ssl.verifypeer=TRUE, cainfo=REDCap.crt, verbose=FALSE)))


#this is how you push pdf files

cat(postForm(REDcap.URL, token=Redcap.token, content="file", action="import", record=ID,field=PlaceInREDCap, event="referral_form_arm_1",file=fileUpload(filename = FileName, contentType = "pdf"),returnFormat="csv", .opts=curlOptions(ssl.verifypeer=TRUE, cainfo=REDCap.crt, verbose=FALSE)))