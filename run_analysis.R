library(data.table)
library(plyr)
library(tidyr)

## Download the dataset from the web and unzip it
fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("./UCI HAR Dataset")) {
    download.file(fileUrl, "Dataset.zip")
    unzip("Dataset.zip") 
}

##Load the data files into R
testX <- read.table("./UCI HAR Dataset/test/X_test.txt")
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt")

testY <- read.table("./UCI HAR Dataset/test/Y_test.txt")
trainY <- read.table("./UCI HAR Dataset/train/Y_train.txt")

testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## 1. Merges the training and the test sets to create one data set.
X <- rbind(testX,trainX)
Y <- rbind(testY,trainY)
subject <- rbind(testSubject,trainSubject)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
dataFeatures <- read.table("./UCI HAR Dataset/features.txt")
mean_std <- grep("-(mean|std)\\(\\)", dataFeatures[, 2])
X <- X[, mean_std]
names(X) <- dataFeatures[mean_std, 2]

## 3. Uses descriptive activity names to name the activities in the data set
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
Y[, 1] <- activities[Y[, 1], 2]
names(Y) <- "activity"

## 4. Appropriately labels the data set with descriptive variable names.
names(subject) <- "subject"
allData <- cbind(X, Y, subject)

names(allData)<-gsub("std()", "SD", names(allData))
names(allData)<-gsub("mean()", "MEAN", names(allData))
names(allData)<-gsub("^t", "time", names(allData))
names(allData)<-gsub("^f", "frequency", names(allData))
names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
avg <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 1:66]))

## Write the data into txt file
write.table(avg, "tidy_dataset.txt", row.name=FALSE)
