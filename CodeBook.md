## Code Book

This dataset is a cleaned and tidied version of the UCI HAR dataset:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original raw data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script performs the data gathering and cleaning in the following steps:
1. **Download the file**
    - Download the file and extract it.
2. **Read in the data**
    - Read in "activity_lables.txt", "features.txt", "subject_test.txt",
    "X_test.txt", "y_test.txt", "subject_train.txt", "X_train.txt", and "y_train.txt"
3. **Merge the training and test data to create one dataset**
    - Use the rbind function to merge the X_train with X_test, y_train with y_test, and
    subject_train with subject_test
    - merge all of the data with cbind
4. **Extract only the measurements on the mean and standard deviation for each measurement**
    - Select only the variables that include the mean and standard deviation, as well as the subject and class identifier
5. **Assign Descriptive Activity Names** 
    - Use the existing activities file as a codebook for the "class" variable. Convert the variable into a factor variable.
6. **Label the dataset with descriptive variable names in column names**
    - Capitalized "subject", "activities", "mean", "angle", and "gravity"
    - "Acc" replaced with "Accelerometer"
    - "Gyro" replaced with "Gyroscope" 
    - "t" replaced with "Time"
    - "f" and "Freq" replaced with "Frequency"
    - "Mag" replaced with "Magnitude"
    - "BodyBody" replaced with "Body"
    - "std" replaced with "StandardDeviation"
    - remove all "."
7. **Create a second, independent tidy data set with the average of each variable for each activity and each subject**
    - Group the means by sbuject and activity
    - Export the tidy dataset

######################################################
Variable Definitions

Subjects -- 1-30 different subjects from the original dataset
Activities -- 1-6 different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
X,Y,Z -- 3-axial directions for the signals
Time -- time domain signals
Frequency -- frequency domain signals

* Variable names are descriptive
