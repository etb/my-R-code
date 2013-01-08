####################################################################
##                                                                ##
##            Define Parameters, token and REDCap url             ##
##                                                                ##
setwd('/.../')


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

RAW.API <- postForm(REDcap.URL, token=Redcap.token, content="record", type="flat", format="csv", rawOrLabel="Label", .opts=curlOptions(ssl.verifypeer=TRUE, cainfo=REDCap.crt, verbose=FALSE))

####################################################################
##                                                                ##
##      Transform and subset data workable R data frame           ##
##                                                                ##
####################################################################
Rawdata <- read.table(file = textConnection(RAW.API), header = TRUE, sep = ",", na.strings = "", stringsAsFactors = FALSE)
rm(RAW.API)
data <- Rawdata

####################################################################
##                                                                ##
##                  Push files to REDCap                          ##
##                                                                ##


#this is how you push pdf files

cat(postForm(REDcap.URL, token=Redcap.token, content="file", action="import", record=ID,field=PlaceInREDCap, event="referral_form_arm_1",file=fileUpload(filename = FileName, contentType = "pdf"),returnFormat="csv", .opts=curlOptions(ssl.verifypeer=TRUE, cainfo=REDCap.crt, verbose=FALSE)))