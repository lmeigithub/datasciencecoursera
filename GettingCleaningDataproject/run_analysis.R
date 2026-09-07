#This script does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

library(dplyr)
library(stringr)

## 1. Merge the training and the test sets to create one data set.
#read in all test sets
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

#read in all training sets
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

#merge test and training sets
subject_comb <- rbind(subject_test, subject_train)
X_comb <- rbind(X_test, X_train)
Y_comb <- rbind(Y_test, Y_train)

## 2. Extract only the measurements on the mean and standard deviation for each measurement.
#extract the feature labels
feature_labels <- read.table("UCI HAR Dataset/features.txt")
meanstd_cols <- str_detect(feature_labels[,2], ("mean|std"))
features_filtered <- feature_labels[meanstd_cols,] 

X_filtered <- X_comb[, features_filtered[,1]]

# 4. Appropriately labels the data set with descriptive variable names. 
colnames(X_filtered) <- features_filtered[,2]

## 3. Use descriptive activity names to name the activities in the data set
#extract the activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

filtered_data <- data.frame(Y_comb, X_filtered)

activity_labeled_data <- filtered_data %>% mutate(activity=activity_labels[V1,2], .before=1) %>%
        select(-V1)

## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
labeled_data <- activity_labeled_data %>% mutate(subject=subject_comb$V1, .before=1) 

tidy_data <- labeled_data %>% group_by(subject, activity) %>% summarize(across(everything(), mean))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
