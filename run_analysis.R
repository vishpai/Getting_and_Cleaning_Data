#This R file downloads the wearable computing data from specified website
#loads into data frames, merges and mashes up and tidies the data
#finally data is loaded into the file


#include library
library(stringr)
library(reshape2)

#download the zip file and unzip it if folder does not exist already
if (!file.exists("./data/Getting and Cleaning Data/Project/UCI HAR Dataset")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "data/Getting and Cleaning Data/Project/UCI HAR Dataset.zip", mode = "wb")
        unzip("./data/Getting and Cleaning Data/Project/UCI HAR Dataset.zip", exdir ="data/Getting and Cleaning Data/Project")
}

##Load the data files to the data frame
#load x test file
x_test <- read.table ("data/Getting and Cleaning Data/Project/UCI HAR Dataset/test/X_test.txt")
#load y test file
y_test <- read.table ("data/Getting and Cleaning Data/Project/UCI HAR Dataset/test/y_test.txt")
#load subject test file
subject_test<-read.table ("data/Getting and Cleaning Data/Project/UCI HAR Dataset/test/subject_test.txt")
#load x train file
x_train <- read.table ("data/Getting and Cleaning Data/Project/UCI HAR Dataset/train/x_train.txt")
#load y train file
y_train <- read.table ("data/Getting and Cleaning Data/Project/UCI HAR Dataset/train/y_train.txt")
#load subject train file
subject_train <- read.table ("data/Getting and Cleaning Data/Project/UCI HAR Dataset/train/subject_train.txt")
#load features file
features <- read.table ("data/Getting and Cleaning Data/Project/UCI HAR Dataset/features.txt")
#load activities file
activities <- read.table ("data/Getting and Cleaning Data/Project/UCI HAR Dataset/activity_labels.txt")

##1.Merges the training and the test sets to create one data set.

#merge the x test and x train
mergedx<-rbind(x_test, x_train)
#associate the column names to merged X file as available in features data frame
colnames(mergedx)<-features$V2

##2.Extracts only the measurements on the mean and standard deviation for each measurement. 

#obtain the subset of merged X file consisting of 'mean' columns
meanx <- mergedx[,grepl('mean',colnames(mergedx))]
#obtain the subset of merged X file consisting of 'standard deviation' columns
stdx <- mergedx[,grepl('std',colnames(mergedx))]
#merge mean and standard deviation column subsets to create new data frame
meanstdx<-cbind(meanx, stdx)

#merge y test and y train data frames
mergedy<-rbind(y_test, y_train)
#add column name to merged y data frame
colnames(mergedy) <-"activity"
#merge subject test and train data frames
mergedsubject<-rbind(subject_test, subject_train)
#add column name to merged subject data frame
colnames(mergedsubject)<-"subject"

#merge all 3 data frames constituting x, y and subject into one data frame
allmerged<-cbind(mergedsubject, mergedy,meanstdx)

##3.Uses descriptive activity names to name the activities in the data set

#replace activity information with descriptive data from activity data frame/file
allmerged$activity <- factor(allmerged$activity,labels=activities$V2)

##4.Appropriately labels the data set with descriptive variable names. 
#Clean up column names in the merged data set

#remove -
colnames(allmerged)<-str_replace_all(colnames(allmerged), "-", ".") 

#replace starting letter f and t with frequency and time
colnames(allmerged)<-str_replace_all(colnames(allmerged), "^f", "frequency.")
colnames(allmerged)<-str_replace_all(colnames(allmerged), "^t", "time.")

#remove () parenthesis 
colnames(allmerged)<-str_replace_all(colnames(allmerged), "\\(\\)", "")

#standardize the column names for readability
colnames(allmerged)<-gsub("Body", "body.", colnames(allmerged))           #change Body to body.
colnames(allmerged)<-gsub("Gyro", "gyro.", colnames(allmerged))           #change Gyro to gyro.
colnames(allmerged)<-gsub("Jerk", "jerk.", colnames(allmerged))           #change Jerk to jerk.
colnames(allmerged)<-gsub("Gravity", "gravity.", colnames(allmerged))     #change Gravity to gravity.
colnames(allmerged)<-gsub("Acc", "Acceleration.", colnames(allmerged))    # standardize Acc as Acceleration.
colnames(allmerged)<-gsub("Mag", "Magnitude.", colnames(allmerged))       # standardize Mag as Magnitude
colnames(allmerged)<-gsub("std", "sd", colnames(allmerged))               # renamed std as sd to correspond to standard deviation
colnames(allmerged)<-gsub("meanFreq", "mean.freq", colnames(allmerged))   #break meanFreq as mean.freq

#remove redudant dots 
colnames(allmerged)<-gsub("\\.\\.", ".", colnames(allmerged)) #replace double dots .. with single dot .

#replace column names to lower case
colnames(allmerged)<-tolower(names(allmerged))

#make data set lean by melting all measurements data using keys-subject and activity  
meltallmerged<-melt(allmerged, id=c("subject", "activity"))

#obtian the mean of all measrurements for unique set of subject and activity
meltallmergedavg<-dcast(meltallmerged, subject + activity ~ variable, mean)

#create the lean tidy data by melting all avg measurements based on subject and activity
tidydata<-melt(avgmeltallmerged, id=c("subject", "activity"))

#export the tidy data into flat file
write.table(meltallmerged, file="data/Getting and Cleaning Data/Project/UCI HAR Dataset/tidydata.txt")
