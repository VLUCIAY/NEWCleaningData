# Getting-and-Cleaning-Data-Project
Getting-and-Cleaning-Data-Project

## Instructions Project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

## Processing Data
### PROGRAM FILES
   1. README.md
   2. run_analysis.R (R program)
   3. CodeBook.rmd, CodeBook.pdf and CodeBook.html (describes the VARIABLES, the DATA, and any transformations or work that you performed to clean up and contain output of execution)
   4. tidydata.txt (Program output)

### INPUT FILES:
   1. Program start DOWNLOAD file from  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
   2. After download, files will be UNZIP to "./UCI HAR Dataset/"
   3. Read files from "./UCI HAR Dataset/train/" or  "./UCI HAR Dataset/test/" or "./UCI HAR Dataset/" and start execute program features
   4. Meaning of files:
      1. Names Variables: features.txt
      2. Data: x_train.txt, x_test.txt
      3. Subject: subject_train.txt, subject_test.txt
      4. Activity: y_train.txt, y_test.txt
      5. Activity Labels: activity_labels.txt
      
### STEPS:
   1. Concatenate ROWs of train plus test: Data (x_train.txt and x_test.txt, Subject (subject_train.txt and subject_test.txt), activity ( y_train.txt and y_test.txt) 
   2. Rename column name of ACTIVITY and SUBJECT
   3. Merge COLUMNS Data, Activity and Subject
   4. Select only names of columns with mean() or std()
   5. Rename columns name with descriptive variable names
   6. Create a new dataset group by SUBJECT and ACTIVITY and calculte  average of each variable
   7. Last, create a txt file with results
   
### VARIABLES:
   1. ACTtrain, ACTtest, SUBtrain, SUBtest, FEAtrain, FEAtest, dataFEANames: read files from txt
   2. dataCOMBINE: Results of combine SUBJECT and ACTIVITY
   3. Data: Resulst of processing before step 6
   4. Data2: Results of tidy data set (subset of Data)
   