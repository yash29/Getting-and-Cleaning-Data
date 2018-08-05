#load libraries
library(dplyr)

########################
## Downoad and check the files
dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipName <- "RawDataset"

if(!file.exists(zipName)){
        download.file(dataurl,zipName)
}

if(!file.exists("UCI HAR Dataset")) {
        unzip(zipName)
}
######################


#################################
#load activities and datasets
setwd("UCI HAR Dataset")
activityLabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

# Convert factor type activity and features in character form
activityLabels[,2]=as.character(activityLabels[,2])
features[,2] <- as.character(features[,2])
####################################


###################################
#Select the desired features
RequiredFeatures <- grep("mean|std", features[,2])
RequiredFeaturesNames <- features[RequiredFeatures,2] %>%
        gsub(pattern = "-mean",replacement = "Mean") %>%
        gsub(pattern = "-std",replacement = "Std") %>%
        gsub(pattern = "[-()]",replacement = "")
View(RequiredFeaturesNames)
##################################

##################################
# Merge the datasets
train <- read.table("train/X_train.txt")[RequiredFeatures]
trainActivities <- read.table("train/Y_train.txt")
trainSubjects <- read.table("train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("test/X_test.txt")[RequiredFeatures]
testActivities <- read.table("test/Y_test.txt")
testSubjects <- read.table("test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)
###################################

###################################
# merge datasets and add labels
MergedData <- rbind(train, test)
colnames(MergedData) <- c("subject", "activity", RequiredFeaturesNames)
View(MergedData)
###################################

###################################
#cleanup Memory
rm(test,train)
rm(testActivities,trainActivities,testSubjects,trainSubjects)

#make the activity and subject as factors
MergedData$activity <- factor(MergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
MergedData$subject <- as.factor(MergedData$subject)
###################################


###################################

names(MergedData)<-gsub("Acc", "Accelerometer", names(MergedData))
names(MergedData)<-gsub("Gyro", "Gyroscope", names(MergedData))
names(MergedData)<-gsub("BodyBody", "Body", names(MergedData))
names(MergedData)<-gsub("Mag", "Magnitude", names(MergedData))
names(MergedData)<-gsub("^t", "Time", names(MergedData))
names(MergedData)<-gsub("^f", "Frequency", names(MergedData))
names(MergedData)<-gsub("tBody", "TimeBody", names(MergedData))
names(MergedData)<-gsub("-mean()", "Mean", names(MergedData), ignore.case = TRUE)
names(MergedData)<-gsub("-std()", "STD", names(MergedData), ignore.case = TRUE)
names(MergedData)<-gsub("-freq()", "Frequency", names(MergedData), ignore.case = TRUE)
names(MergedData)<-gsub("angle", "Angle", names(MergedData))
names(MergedData)<-gsub("gravity", "Gravity", names(MergedData))

View(names(MergedData))
###################################


###################################
# group by subject and activity and summarise using mean
humanActivityMeans <- MergedData %>% 
        group_by(subject, activity) %>%
        summarise_all(.funs=mean)
View(humanActivityMeans)

#write back to data to table
write.table(humanActivityMeans,file="tidydata.txt",
            row.names = FALSE, quote=FALSE)
###################################