## Getting and Cleaning Data Course Project
## The purpose of this project is to demonstrate your ability to collect, work with, 
## and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
## You should create one R script called run_analysis.R that does the following.
## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names.
## 5.From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

## Download data set
# Check if directory exists
if(!file.exists("Data")){dir.create("Data")}

# Check if zip file exists
if(!file.exists("Dataset.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zfile <- paste("./Data/","Dataset.zip",sep="")
    download.file(url,destfile=zfile,method="curl")
}

# Check if file unzipped 
if(!file.exists("Dataset.zip")){
    unzip(zfile,exdir="./Data")
}

## Read files - ACTIVITY - TRAIN 7352 X TEST 2947
ACTtrain <- read.table("./Data/UCI HAR Dataset/train/y_train.txt", header = FALSE) 
ACTtest <- read.table("./Data/UCI HAR Dataset/test/y_test.txt", header = FALSE) 

## Read Files - SUBJECT - TRAIN 7352 X TEST 2947
SUBtrain <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt", header = FALSE) 
SUBtest <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

## Read Files - FEATURES - TRAIN 7352 X TEST 2947
FEAtrain <- read.table("./Data/UCI HAR Dataset/train/X_train.txt", header = FALSE) 
FEAtest  <- read.table("./Data/UCI HAR Dataset/test/X_test.txt", header = FALSE) 

## Show Variables
str(ACTtrain)
str(ACTtest)
str(SUBtrain)
str(SUBtest)
str(FEAtrain)
str(FEAtest)

## --------------------------------------------------------------
## 1.Merges the training and the test sets to create one data set.
## Step 1 - CONCATENATE ROWS - Total 10299
dataACT <- rbind(ACTtrain, ACTtest)
dataSUB <- rbind(SUBtrain, SUBtest)
dataFEA <- rbind(FEAtrain, FEAtest)

## Show variables
nrow(dataACT)
nrow(dataSUB)
nrow(dataFEA)

## Step 2 - DEFINE NAMES
names(dataACT) <- c("ACTIVITY")
names(dataSUB) <- c("SUBJECT")
dataFEANames <- read.table("./Data/UCI HAR Dataset/features.txt", header = FALSE) 
names(dataFEA) <- dataFEANames$V2

## Step 3 - MERGE COLUMNS -> Row 10.299 Col= 563
dataCOMBINE <- cbind(dataSUB, dataACT)
Data <- cbind(dataFEA, dataCOMBINE)

##Show variables
ncol(Data)
nrow(Data)

## ----------------------------------------------------------------------------------------
## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
## Step 1 - Find NAMES of features with mean() or std()
subdataFEANames <- dataFEANames$V2[grep("mean\\(\\)|std\\(\\)", dataFEANames$V2)]

## Step 2 - Filter data using Step1 -> Row 10.299 x Col 68
FilterNames <- c(as.character(subdataFEANames),"SUBJECT", "ACTIVITY")
Data <- subset(Data,select=FilterNames)

##Show variables
ncol(Data)
nrow(Data)

##Show data before
head(Data$ACTIVITY,1)

## ------------------------------------------------------------------------
## 3.Uses descriptive activity names to name the activities in the data set
ACTLabels <- read.table("./Data/UCI HAR Dataset/activity_labels.txt", header = FALSE) 
Data$ACTIVITY <- ACTLabels[Data$ACTIVITY,2]

##Show data after
head(Data$ACTIVITY,1)


##Show Before
names(Data)

## -------------------------------------------------------------------
## 4.Appropriately labels the data set with descriptive variable names.
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("tBody", "TimeBody", names(Data))
names(Data)<-gsub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-std()", "STD", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data)<-gsub('\\-|\\(|\\)', '', names(Data))

##Show After
names(Data)

## -------------------------------------------------------------------------------
## 5.From the data set in step 4, creates a second, independent tidy data set with
##the average of each variable for each activity and each subject.
##  Row = 180 x  Col = 68
library(plyr)
Data2 <- aggregate(.~ SUBJECT + ACTIVITY, Data, mean)
Data2 <- Data2[order(Data2$SUBJECT, Data2$ACTIVITY),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

##Show Results
nrow(Data2)
ncol(Data2)
head(Data2,3)
