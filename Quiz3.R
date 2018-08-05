#Q1

library("dplyr")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","Q3q1.csv")

data<- read.csv("Q3q1.csv",stringsAsFactors = FALSE)

agrilogical<-which(data$ACR==3&data$AGS==6)
data<-tbl_df(data)
head(data)
select(data,ACR==3,AGS==6)

str(data)


#Q2

library("jpeg")
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
              , 'jeff.jpg'
              , mode='wb' )

pic <- readJPEG("jeff.jpg",native=TRUE)
quantile(pic,probs = (c(0.3,0.8)))


#Q3

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","Q3q31.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv","Q3q32.csv")

d1<-read.csv("Q3q31.csv",stringsAsFactors = FALSE)
d2<-read.csv("Q3q32.csv",stringsAsFactors = FALSE)
str(d1)
head(d1)
str(d2)
summarise()


library(data.table)
d1<- fread("Q3q31.csv",
           skip = 4,
           nrow = 190,
           select = c(1,2,4,5),
           col.names = c("CountryCode", "Rank", "Economy", "Total")
           )
d2 <- fread("Q3q32.csv")
a<-merge(d1,d2, by="CountryCode")
nrow(a)