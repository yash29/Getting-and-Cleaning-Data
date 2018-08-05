#Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile = "Q1.csv")
q<-read.csv("Q1.csv")
unique(q$VAL)

k<-q$VAL[is.na(q$VAL)==FALSE]

sum(k>=24)

#Q2
q$FES

#Q3
library("xlsx")

dat <- read.xlsx("DATA.gov_NGAP.xlsx",1,rowIndex = 18:23,colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

#Q4
library("XML")
dat<- xmlTreeParse("getdata%2Fdata%2Frestaurants.xml",useInternal = TRUE)
top <- xmlRoot(dat)
xmlName(top)
a<-sum(xpathSApply(top,"//zipcode",xmlValue) == 21231)
a


#Q5
library("data.table")
addr <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(addr,"Q5.csv")
DT <- fread("Q5.csv")
system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(DT[,mean(pwgtp15),by=SEX])
