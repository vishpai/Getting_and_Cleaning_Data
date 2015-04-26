#ABOUT THE Data AND EXPERIEMENT
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.


##For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###Reference: README.txt from the UCI HAR Dataset which is described in detail next section/s

#GETTING THE DATA
Data for this particular assignment was obtained from the location mentioned below: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Zip file contains many files but files of our interest are listed below.  

* 'README.txt': mainly reference text used to understand the experiment and dataset
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt' and 'test/subject_test.txt’: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Last 8 data sets are contains the data that are used in the program. 

#ABOUT THE DATA
###Reference: features_info.txt from the UCI HAR Dataset 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. Time and frequency domain signals were captured for various subjects during various exercising methods using electronic/smart wearables. All the measurements were made in 3 dimensions - XYZ for the following:
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Data also contains number of calculated variables but for the purpose of this project we are considering only 2 variables - mean and standard deviation which are denoted by mean and std respectively.

#OBSERVATION ABOUT THE DATA
It was observed that data lot of noise/data quality issues such as:
 * not easily understandable column names
 * abbreviated column names
 * special characters
 * some files do not have proper headers

More over data set is captured distinctly and remain separately. Many inferences could be deduced by clubbing this data set in meaningful fashion. 

Next section describes the various processing and manipulations that are performed to reach at the tidy data set.

#LOADING/TRANSFORMATIONS/TIDYING OF THE DATA
Note: This section discusses the data manipulation/tidying at high level. Detailed documentation is included in the program itself. Please refer to run_analysis.R file for more details.

1) individual files are loaded into corresponding data frame.  Related data sets from test and train are carefully merged into single data frame. For example: x_test and x_train data sets were merged together into one data frame.

2) merged data sets are associated with proper header/column names (which were supplied in the .zip file)

3) Since we are only interested in mean and standard deviation variables, merged data set is filtered accordingly

4) all 3 major data sets x (measurements), y(activities) and subject (volunteer data) information are merged

5) various rules were applied to massage the column names in the merged data set such as "-" were placed ".", "()" were removed to list some as example. (details are documented in run_analysis.R file)

6) data set was made lean by "melting" all measurements based on subject and activity

7) lean data set was averaged for each measurement and another lean data set was created for easier readability and analytics

8) at the last step, tidy data set was export out to text file by name tidydata.txt

#DATA DICTIONARY OF Human Activity Recognition Using Smartphones Dataset

No.	Column Name	Details 						Values
1	subject		identifies volunteer who was involved in the experiment	range  between 1 thru 30			
2	activity	exercising activities performed by volunteer		1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS 4 SITTING 5 STANDING 6 LAYING
3	variables	denotes the name and axis of the measurements 		There are 80 measurements corresponding for XYZ axis
4	value		stores the values for various measurements performed 
