# Readme for run_analysis project
## Coursera Data Science Specialization - Course 3 Getting and Cleaning Data Project

The run_analysis.R script has all the code necessary to perform the transformations and calculations required by the project.
The code is very well documented, explaining each step into building the data. More information about the strucure and rationale for the code can be found in the cookbook.md file in the root of the repository.

## Note to the ones Evaluating the code:
To the evaluation: I uploaded an incorrect txt file - the CSV file now under version control in github is the correct one.
Please consider this one instead of the submitted txt file.

The code is built following the 5 steps specified in the Project, however not in the exact same order.

### Step 0:
The zip file is downloaded and unzipped to a specific data folder. In case the file is already there, it is not downloaded again, since it is a large file.

### Step 1:
Now the test and train data are merged - first the subject test and train files are read and merged, followed by the y and X data files.
They are always merged using rbind in the same order, i.e. test first and then train, to keep the consistency of the original data between files.

### Step 2:
Now, instead of extracting the mean and std files only from the dataset, I read the labels from the activity_labels.txt and apply the correct names to the y_merged file.

### Step 3:
I now label all the columns with the names read from the features.txt file, making the colum names much more significant than the original Var1, Var2 etc.

### Step 4:
Now I do extract only the mean and std columns from the large data set and store them in a new variable called "mean_and_std_data". Since the project made me confused whether the tidy data file (from step 5) should include all the data or only the mean and std, I decided to store them in different variables.

### Step 5:
Aggregate the data and save the table to a tidy_data.csv file.

### About the project - Assignment

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

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
