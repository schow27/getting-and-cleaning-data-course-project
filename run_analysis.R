if(!file.exists("data")) {
  dir.create("data")
}
# Load dataset
activity_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(activity_url, destfile = "./data/Dataset.zip")

unzip("./data/Dataset.zip")

library(dplyr)

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("class", "activity"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n", "feature"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("class"))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("class"))

# merge training and test
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, y_data, x_data)


# measurements on mean and standard deviation for each measurement
data_summary <- merged_data %>% 
  select(subject, class, contains("mean"), contains("std"))

# descriptive activity names
data_summary$class <- activities[data_summary$class, 2]
data_summary$class <- as.factor(data_summary$class)

# label data set with variable names
names(data_summary)[1] = "Subject"
names(data_summary)[2] = "Activity"
names(data_summary) <- gsub("Acc", "Accelerometer", names(data_summary))
names(data_summary) <- gsub("Gyro", "Gyroscope", names(data_summary))
names(data_summary) <- gsub("^t", "Time", names(data_summary))
names(data_summary) <- gsub("Freq", "Frequency", names(data_summary))
names(data_summary) <- gsub("^f", "Frequency", names(data_summary))
names(data_summary) <- gsub("Mag", "Magnitude", names(data_summary))
names(data_summary) <- gsub("tBody", "TimeBody", names(data_summary))
names(data_summary) <- gsub("BodyBody", "Body", names(data_summary))
names(data_summary) <- gsub("mean", "Mean", names(data_summary))
names(data_summary) <- gsub("std", "StandardDeviation", names(data_summary))
names(data_summary) <- gsub("\\.","", names(data_summary))
names(data_summary) <- gsub("angle", "Angle", names(data_summary))
names(data_summary) <- gsub("gravity", "Gravity", names(data_summary))


# create second, independent tidy data set with average
# of each variable for each activity and each subject

tidy_data <- data_summary %>% 
  group_by(Subject, Activity) %>% 
  summarize_all(list(mean))

write.table(tidy_data, "tidy_data.txt", row.names=FALSE)

