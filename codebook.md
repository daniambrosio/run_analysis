# Codebook for Course 3 Getting and Cleaning Data Project
## Coursera Data Science Specialization
This codebook explains the logic behind the run_analysis.R code.

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

