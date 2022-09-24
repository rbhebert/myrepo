# Script to download Google Trend CSV file for a specific date range and search topic
# Intended to retrieve all 50 states + DC 

# code adapted from http://erikjohansson.blogspot.com/2014/09/automate-google-trends-download-using-r.html
# adapted by Reginald Hebert
# version 2022-09-23

##############################################################################

# append District of Columbia to state list
state_list = append(state.abb,"DC")

#### Set search and download parameters

# Set topic
topic = ""

# Set starting year
initialYear = ""

# Set starting month
initialMonth = ""

# Set length of query in months
numMonths = ""

# Set download directory
downloadFolder = ""

##############################################################################

# function definitions, taken from http://erikjohansson.blogspot.com/2014/09/automate-google-trends-download-using-r.html

URL_GT=function(keyword="", country=NA, region=NA, year=NA, month=1, length=3){
  
  start="http://www.google.com/trends/trendsReport?hl=en-US&q="
  end="&cmpt=q&content=1&export=1"
  geo=""
  date=""
  
  #Geographic restrictions
  if(!is.na(country)) {
    geo="&geo="
    geo=paste(geo, country, sep="")
    if(!is.na(region)) geo=paste(geo, "-", region, sep="")
  }
  
  queries=keyword[1]
  if(length(keyword)>1) {
    for(i in 2:length(keyword)){
      queries=paste(queries, "%2C ", keyword[i], sep="")
    }
  }
  
  #Dates
  if(!is.na(year)){
    date="&date="
    date=paste(date, month, "%2F", year, " ", month+length-1, "m", sep="")
  }
  
  URL=paste(start, queries, geo, date, end, sep="")
  return(URL)
}

downloadGT=function(URL, downloadDir){
  
  #Determine if download has been completed by comparing the number of files in the download directory to the starting number
  startingFiles=list.files(downloadDir)
  browseURL(URL)
  endingFiles=list.files(downloadDir)
  
  while(length(setdiff(endingFiles,startingFiles))==0) {
    Sys.sleep(3)
    endingFiles=list.files(downloadDir)
  }
  filePath=setdiff(endingFiles,startingFiles)
  return(filePath)
}

##############################################################################

# Loop over list of states for given search parameters

for (i in state_list) {
  # generate URL for state CSV file
  temp_url = URL_GT(keyword = topic, country = US, region = i, year = initialYear, month = initialMonth, length = numMonths)
  
  # retrieve CSV and save to target directory
  downloadGT(temp_url, downloadFolder)
}




