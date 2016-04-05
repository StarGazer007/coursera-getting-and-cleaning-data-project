##########################################################################################################
## Coursera Getting and Cleaning Data Course Project
## Lisa Rodgers
## 2016-04-03

# Clean up workspace
rm(list=ls())

##load library
library(reshape2)


##set filename variable and check if the file exists
filename <-"getdata_dataset.zip"

## if file does not exist download the data zip file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
if (!file.exists(filename)){
  fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
  
}

##Unzip the data file to UCI HAR Dataset
if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

# Load activity labels and features

activity_Labels <-read.table("UCI HAR Dataset/activity_labels.txt")
activity_Labels[,2] <- as.character(activity_Labels[,2])

## Load the features file into a table
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
features_Wanted <- grep(".*mean.*|.*std.*", features[,2])
features_Wanted.names <- features[features_Wanted,2]
features_Wanted.names = gsub('-mean', 'Mean', features_Wanted.names)
features_Wanted.names = gsub('-std', 'Std', features_Wanted.names)
features_Wanted.names <- gsub('[-()]', '', features_Wanted.names)

## Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_Wanted]
train_Activities <- read.table ("UCI HAR Dataset/train/Y_train.txt")
train_Subjects <- read.table ("UCI HAR Dataset/train/subject_train.txt")
train_data <- cbind(train_Subjects, train_Activities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_Wanted]
test_Activities <- read.table ("UCI HAR Dataset/test/Y_test.txt")
test_Subjects <- read.table ("UCI HAR Dataset/test/subject_test.txt")
test_data <- cbind(test_Subjects, test_Activities, test)

# merge datasets and add labels
all_Data <- rbind(train_data, test_data)
colnames(all_Data) <- c("subject", "activity", features_Wanted.names)


# turn activities and subjects into factors
all_Data$activity <- factor(all_Data$activity, levels = activity_Labels[,1], labels = activity_Labels[,2])
all_Data$subject <- as.factor(all_Data$subject)

all_Data.melted <- melt(all_Data, id = c("subject", "activity"))
all_Data.mean <- dcast(all_Data.melted, subject + activity ~ variable, mean)

write.table(all_Data.mean,"tidy_data.txt", row.names = FALSE, quote = FALSE)


