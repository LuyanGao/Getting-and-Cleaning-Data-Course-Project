The script run_analysis.R downloads and unzips the dataset, performs all the 5 steps for this course project. 

Step1: Data can be merged using rbind() function. 
Step2: Only the mean and standard deviation for each measurement are extracted from the dataset. 
Step3: Use descriptive names to name the activities.
Step4: Appropriately labels the dataset with descriptive variable names.
tBodyAcc-mean()-X ----> timeBodyAccMeanX
tBodyAcc-std()-Y ----> timeBodyAccStdY
fBodyAcc-mean()-Z ----> freqBodyAccMeanZ
fBodyBodyGyroMag-mean() ----> freqBodyGyroMagMean
fBodyBodyGyroJerkMag-meanFreq() ----> freqBodyGyroJerkMagMeanFreq
Step5: Generate an independent tidy data set with the average of each variable for each activity and each subject.
       And the final output file is tidy_dataset.txt

# Description of the variables in run_analysis.R

testX, trainX, testY, trainY, testSubject and trainSubject contain the original data downloaded.
X, Y and subject contain the dataset merged from the previous one.
dataFeatures contains the file features.txt
mean_std contains all columns with the character 'mean' or 'std'.
activities contains the file activity_labels.txt. And then descriptive name is used to name the activities.
allData is merged from X, Y and subject. Descriptive variable names are used to label the dataset.
avg contains the corresponding average values and it is stored in tidy_dataset.txt
