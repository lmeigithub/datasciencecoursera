The "run_analysis.R" script does five things to the test and train data in the "Human Activity Recognition Using Smartphones Dataset":
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To accomplish (1), the script first reads in the 'subject' train and test datasets, as well as 
the 'X' and 'Y' train and test datasets.

The 'X' datasets contain data on the 561 time and frequency domain variables gathered by the accelerometer and gyroscope.
The 'Y' datasets contain the activity number for each set of data.
The 'subject' datasets contain the subject number of the subject who performed the tests.

The script first merges these test and train of each of these datasets by combining them columns-wise.

To accomplish (2), the script first reads in the labels for the 561 time and frequency domain variables.
The script then searches for "mean" and "std" in the feature labels, and filters out the 
columns of the 'X' dataset to include only those that were records of a "mean" and "standard deviation".

The script then labels the "X" data set (task 4) by setting the column names of the dataset equal to the feature names. 

The script then accomplishes (3) by first reading in the activity names and matching the activity number to the label, 
and combining the activity column into the "X" dataframe. 

The script then creates a tidy data set (5) by first adding to the previous data frame a column with the subject numbers; 
then it groups the data set by subject and activity and summarizes the table by calculating the mean of each of the sets of data collected for each subject-activity. 