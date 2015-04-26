#Getting the Data
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

#Loading/Transformations/Tidying of the Data
Note: This section discusses the data manipulation/tidying at high level. Detailed documentation is included in the program itself. Please refer to run_analysis.R file for more details.

1) individual files are loaded into corresponding data frame.  Related data sets from test and train are carefully merged into single data frame. For example: x_test and x_train data sets were merged together into one data frame.

2) merged data sets are associated with proper header/column names (which were supplied in the .zip file)

3) Since we are only interested in mean and standard deviation variables, merged data set is filtered accordingly

4) all 3 major data sets x (measurements), y(activities) and subject (volunteer data) information are merged

5) various rules were applied to massage the column names in the merged data set such as "-" were placed ".", "()" were removed to list some as example. (details are documented in run_analysis.R file)

6) data set was made lean by "melting" all measurements based on subject and activity

7) lean data set was averaged for each measurement and another lean data set was created for easier readability and analytics

8) at the last step, tidy data set was export out to text file by name tidydata.txt

#Data Dictionary

#####Column Name:subject	
Details:identifies volunteer who was involved in the experiment	range						
Values:between 1 thru 30

#####Column Name:activity		
Details:exercising activities performed by volunteer						
Values:1 WALKING 2 WALKING_UPSTAIRS 3 WALKING_DOWNSTAIRS 4 SITTING 5 STANDING 6 LAYING

#####Column Name:variables		
Details:denotes the name and axis of the measurements						
Values:There are 80 measurements corresponding for XYZ axis

#####Column Name:value			
Details:stores the values for various measurements performed						

* Please refer to Readme.md for additional information.