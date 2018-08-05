#Q1

library("jsonlite")
library("httr")
oauth_endpoints("github")

myapp<- oauth_app("github",
                  key="502e82a01e8d57412ac0",
                  secret = "5f7a4573ed41f6a3da109cf4dfb4de7731eee2c0")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json1<-content(req)

gitDF <- fromJSON(toJSON(json1))
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

#Q2

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv","Q2.csv")
library("sqldf")
library("data.table")
acs<-fread("Q5.csv")
str(acs)
sqldf("select pwgtp1 from acs")


#Q4
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

#Q5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
 w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
 colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header = FALSE, skip = 4, col.names = colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])

