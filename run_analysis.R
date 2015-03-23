# Course Project - Getting and Cleaning Data
# Daniel Ambrosio
# 2015/March
#
# One of the most exciting areas in all of data science right now is wearable 
# computing - see for example this article . Companies like Fitbit, Nike, and 
# Jawbone Up are racing to develop the most advanced algorithms to attract 
# new users. The data linked to from the course website represent data 
# collected from the accelerometers from the Samsung Galaxy S smartphone. 
# A full description is available at the site where the data was obtained: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
# Here are the data for the project: 
#    
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# You should create one R script called run_analysis.R that does the following. 
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - From the data set in step 4, creates a second, independent tidy data 
#     set with the average of each variable for each activity and each subject.

# Libraries needed for this script
library(reshape2)

#
# Paths used during processing
#
wd = "./data"
zipFile <- paste(wd,"projectdata.zip",sep="/")
dirData <- paste(wd,"UCI HAR Dataset",sep="/")
testDir <- paste(dirData,"test",sep="/")
trainDir <- paste(dirData,"train",sep="/")

#
# Get the remote data into a working data folder and unzip it
#
if(!file.exists(wd)) {dir.create(wd)}
if(!file.exists(zipFile)) {
    print("downloading zip file...")
    zipFileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(zipFileURL, destfile=zipFile, method="curl")    
} else {
    print("zip file found - no need to download again")
}

if(!file.exists(dirData)) {
    print("unzipping file...")
    unzip(zipFile, exdir=wd)
} else {
    print("unzipped file found - skipping")
}


########################################################################
# 1 - Merges the training and the test sets to create one data set.
########################################################################
# read and combine the subject data
print("Step 1 - Merging subject data...")
subject_test <- read.table(paste(testDir,"subject_test.txt",sep="/"))
subject_train <- read.table(paste(trainDir,"subject_train.txt",sep="/"))
subject_merged <- rbind(subject_test,subject_train)
# read and combine the y data
print("Step 1 - Merging y data...")
y_test <- read.table(paste(testDir,"y_test.txt",sep="/"))
y_train <- read.table(paste(trainDir,"y_train.txt",sep="/"))
y_merged <- rbind(y_test,y_train)
# read and combine the X data
print("Step 1 - Merging X data...")
X_test = read.table(paste(testDir,"X_test.txt",sep="/"))
X_train = read.table(paste(trainDir,"X_train.txt",sep="/"))
X_merged = rbind(X_test,X_train)

########################################################################
# 3 - Uses descriptive activity names to name the activities in the data set
########################################################################
print("Step 3 - Change y values to Label...")
labels <- read.table(paste(dirData,"activity_labels.txt",sep="/"))
#y_merged <- merge(y_merged,labels,by.y="V1",sort=FALSE)

########################################################################
# 4 - Appropriately labels the data set with descriptive variable names. 
########################################################################
# set the column names for the merged files
print("Step 4 - Rename and merge study data...")
colnames(subject_merged) <- c("subject")
colnames(y_merged) <- c("activity")
features <- read.table(paste(dirData,"features.txt",sep="/"))
colnames(X_merged) <- c(as.character(features[,2]))
# prepare final merged data, including test and train data
study_data <- cbind(subject_merged, y_merged, X_merged)
#colnames(study_data)[2] <- "activity" # why did it not bind the col name also?

########################################################################
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
########################################################################
print("Step 2 - Extracting std and mean data only from X...")
std_index <- grep("std",features[,2])
mean_index <- grep("mean()",features[,2],fixed=TRUE) # eliminates meanFreq()
filter_index <- sort(c(std_index,mean_index))
mean_and_std_data <- cbind(subject_merged, y_merged,X_merged[filter_index])
#colnames(mean_and_std_data)[2] <- "activity" # why did it not bind the col name also?

########################################################################
# 5 - From the data set in step 4, creates a second, independent tidy data 
#     set with the average of each variable for each activity and each subject.
########################################################################
print("Step 5 - Aggregating the data and saving to CSV file...")
agg <- aggregate(study_data[,3:length(study_data)], by=list(study_data$subject,study_data$activity), FUN=mean)
agg <- merge(agg,labels,by.y="V1",by.x="Group.2",sort=FALSE)
agg$Group.2 <- agg$V2 # replace the number of activity by its name - label
names(agg)[1:2]<-c("activity","subject")
write.csv(agg,paste(dirData,"tidy_data.csv",sep="/"))

