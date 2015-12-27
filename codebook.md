#Code Book
This code book describes the data and processes used to generate tidy.csv

##Overview
The UCI HAR data is comprised of smartphone accelerometer data collected by 30 volunteers performing different activities. The volunteers performed 6 different motions while wearing the Samsung Galaxy S Smartphone

## Files
The following are files used in the analysis. Files found in the Intertial Signals directory have been ignored. 

### Features
* features.txt: Names of the 561 features.

### Training Set

* X_train.txt: 7352 observations of the 561 features, for 21 of the 30 volunteers.
* subject_train.txt: A vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in X_train.txt.
* y_train.txt: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in X_train.txt.

### Testing Set
* X_test.txt: 2947 observations of the 561 features, for 9 of the 30 volunteers.
* subject_test.txt: A vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in X_test.txt.
* y_test.txt: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in X_test.txt.

## Procedure
1. Read all relevant files into data frames 
2. Add appropriate column headers
3. Remove feature columns that do not contain the exact string "mean()" or "std()". Result is 66 feature columns, plus subjectID and activity columns.
4. Convert activity column from integer to factor, using labels describing the activities.
5. Merge data intp tidy data set that contains the mean of each feature for each subject and activity. Each row contains the mean value for each of the 66 features for that subject/activity combination. There are 30 subjects, therefore there are a total of 180 rows.
