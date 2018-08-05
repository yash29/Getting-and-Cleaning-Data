#1

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","q4q1.csv")
dat1<-read.csv("q4q1.csv")
class(dat1)
t1<- strsplit(names(dat1),"wgtp")
t1[123]

#2
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","q4q2.csv")
dtGDP <- data.table(read.csv("q4q2.csv", skip = 4, nrows = 215, stringsAsFactors = FALSE))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", dtGDP$gdp))

#3


#4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv","q4q4.csv")
dat2<-read.csv("q4q4.csv")
dted<-data.table(dat2)
dt<-merge(dtGDP,dted,all = TRUE,by=c("CountryCode"))
t1<-grepl("fiscal year end",tolower(dt$Special.Notes))
t2<-grepl("june",tolower(dt$Special.Notes))
table(t1,t2)


#5

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
amzn
class(amzn)
?`xts-package`
library(lubridate)
sum(year(ymd(sampleTimes)) == 2012 & wday(ymd(sampleTimes))==2)

