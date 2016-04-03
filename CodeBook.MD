#Code Book

Lisa Rodgers

Saturday, April 03, 2016

##Getting and Cleaning Data Course Project
Instructions for project The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Description of the DATA
*`subject` - The ID of the test subject
*`activity`- The type of activity performed when the corresponding measurements were taken

Description of abbreviations of measurements

*`leading` t or f is based on time or frequency measurements.
* `Body` = related to body movement.
* `Gravity` = acceleration of gravity
* `Acc` = accelerometer measurement
* `Gyro` = gyroscopic measurements
* `Jerk` = sudden movement acceleration
* `Mag` = magnitude of movement
* `mean and SD` are calculated for each subject for each activity for each mean and SD measurements.


## The Measurements

* `tBodyAccMeanX`
* `tBodyAccMeanY`
* `tBodyAccMeanZ`
* `tBodyAccStdX`
* `tBodyAccStdY`
* `tBodyAccStdZ`
* `tGravityAccMeanX`
* `tGravityAccMeanY`
* `tGravityAccMeanZ`
* `tGravityAccStdX`
* `tGravityAccStdY`
* `tGravityAccStdZ`
* `tBodyAccJerkMeanX`
* `tBodyAccJerkMeanY`
* `tBodyAccJerkMeanZ`
* `tBodyAccJerkStdX`
* `tBodyAccJerkStdY`
* `tBodyAccJerkStdZ`
* `tBodyGyroMeanX`
* `tBodyGyroMeanY`
* `tBodyGyroMeanZ`
* `tBodyGyroStdX`
* `tBodyGyroStdY`
* `tBodyGyroStdZ`
* `tBodyGyroJerkMeanX`
* `tBodyGyroJerkMeanY`
* `tBodyGyroJerkMeanZ`
* `tBodyGyroJerkStdX`
* `tBodyGyroJerkStdY`
* `tBodyGyroJerkStdZ`
* `tBodyAccMagMean`
* `tBodyAccMagStd`
* `tGravityAccMagMean`
* `tGravityAccMagStd`
* `tBodyAccJerkMagMean`
* `tBodyAccJerkMagStd`
* `tBodyGyroMagMean`
* `tBodyGyroMagStd`
* `tBodyGyroJerkMagMean`
* `tBodyGyroJerkMagStd`
* `fBodyAccMeanX`
* `fBodyAccMeanY`
* `fBodyAccMeanZ`
* `fBodyAccStdX`
* `fBodyAccStdY`
* `fBodyAccStdZ`
* `fBodyAccMeanFreqX`
* `fBodyAccMeanFreqY`
* `fBodyAccMeanFreqZ`
* `fBodyAccJerkMeanX`
* `fBodyAccJerkMeanY`
* `fBodyAccJerkMeanZ`
* `fBodyAccJerkStdX`
* `fBodyAccJerkStdY`
* `fBodyAccJerkStdZ`
* `fBodyAccJerkMeanFreqX`
* `fBodyAccJerkMeanFreqY`
* `fBodyAccJerkMeanFreqZ`
* `fBodyGyroMeanX`
* `fBodyGyroMeanY`
* `fBodyGyroMeanZ`
* `fBodyGyroStdX`
* `fBodyGyroStdY`
* `fBodyGyroStdZ`
* `fBodyGyroMeanFreqX`
* `fBodyGyroMeanFreqY`
* `fBodyGyroMeanFreqZ`
* `fBodyAccMagMean`
* `fBodyAccMagStd`
* `fBodyAccMagMeanFreq`
* `fBodyBodyAccJerkMagMean`
* `fBodyBodyAccJerkMagStd`
* `fBodyBodyAccJerkMagMeanFreq`
* `fBodyBodyGyroMagMean`
* `fBodyBodyGyroMagStd`
* `fBodyBodyGyroMagMeanFreq`
* `fBodyBodyGyroJerkMagMean`
* `fBodyBodyGyroJerkMagStd`
* `fBodyBodyGyroJerkMagMeanFreq`

## Activity Labels
```
V1                 V2
1            WALKING : subject was walking during the test
2   WALKING_UPSTAIRS : subject was walking up a staircase during the test
3 WALKING_DOWNSTAIRS : subject was walking down a staircase during the test
4            SITTING : subject was sitting during the test
5           STANDING : subject was standing during the test
6             LAYING : subject was laying down during the test
```

##Download the Data
```
###set filename variable and check if the file exists
filename <-"getdata_dataset.zip"


## if file does not exist download the data zip file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
if (!file.exists(filename)){
  fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
  
}
```

##Load Required packages &Clean up workspace

```
rm(list=ls())

##load library
library(reshape2)
```

###Files in folder ‘UCI HAR Dataset’ that will be used are:

SUBJECT FILES
*'test/subject_test.txt
*'train/subject_train.txt

ACTIVITY FILES
*'test/X_test.txt
*'train/X_train.txt

DATA FILES
*'test/y_test.txt
*'train/y_train.txt

features.txt - Names of column variables in the dataTable

activity_labels.txt - Links the class labels with their activity name.

###Read the ‘UCI HAR Dataset’ files and created data tables.
```

activity_Labels <-read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_Wanted]
train_Activities <- read.table ("UCI HAR Dataset/train/Y_train.txt")
train_Subjects <- read.table ("UCI HAR Dataset/train/subject_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_Wanted]
test_Activities <- read.table ("UCI HAR Dataset/test/Y_test.txt")
test_Subjects <- read.table ("UCI HAR Dataset/test/subject_test.txt")

```

##1.Merges the training and the test sets to create one data set.

```

# merge datasets and add labels
all_Data <- rbind(train_data, test_data)
colnames(all_Data) <- c("subject", "activity", features_Wanted.names)
```

## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
```
# Extract only the data on mean and standard deviation
features_Wanted <- grep(".*mean.*|.*std.*", features[,2])
features_Wanted.names <- features[features_Wanted,2]
features_Wanted.names = gsub('-mean', 'Mean', features_Wanted.names)
features_Wanted.names = gsub('-std', 'Std', features_Wanted.names)
features_Wanted.names <- gsub('[-()]', '', features_Wanted.names)
```


#Uses descriptive activity names to name the activities in the data set
```
# turn activities and subjects into factors
all_Data$activity <- factor(all_Data$activity, levels = activity_Labels[,1], labels = activity_Labels[,2])
all_Data$subject <- as.factor(all_Data$subject)

# Melt the data
all_Data.melted <- melt(all_Data, id = c("subject", "activity"))
all_Data.mean <- dcast(all_Data.melted, subject + activity ~ variable, mean)

```

##4. Appropriately labels the data set with descriptive variable names.
leading t or f is based on time or frequency measurements.
```
1. Body = related to body movement.
2. Gravity = acceleration of gravity
3. Acc = accelerometer measurement
4. Gyro = gyroscopic measurements
5. Jerk = sudden movement acceleration
6. Mag = magnitude of movement
mean and SD are calculated for each subject for each activity for each mean and SD measurements. The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.
```

##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```
#Create the tidy.txt file
write.table(all_Data.mean,"tidy.txt", row.names = FALSE, quote = FALSE)

```
