# run_analysis.R
# Assume data extracted to working directory
library(dplyr)
# load activity and feature tables
file <- "./UCI HAR Dataset/activity_labels.txt"
activity_labels <- read.table(file, colClasses = c("integer", "character"))
names(activity_labels) <- c("activity_code", "activity")
file <- "./UCI HAR Dataset/features.txt"
features <- read.table(file, colClasses = c("integer", "character"))
names(features) <- c("column_number", "feature_name")
# load training and test data sets then merge
file <- "./UCI HAR Dataset/test/X_test.txt"
X_test <- read.table(file, colClasses = "numeric")
file <- "./UCI HAR Dataset/train/X_train.txt"
X_train <- read.table(file, colClasses = "numeric")
X <- rbind(X_test, X_train)
names(X) <- features[, "feature_name"]
rm(X_test, X_train)
# load training and test activity sets then merge
file <- "./UCI HAR Dataset/test/y_test.txt"
y_test <- read.table(file, colClasses = "integer")
names(y_test) <- c("activity_code")
file <- "./UCI HAR Dataset/train/y_train.txt"
y_train <- read.table(file, colClasses = "integer")
names(y_train) <- c("activity_code")
y <- rbind(y_test, y_train)
rm(y_test, y_train)
# load training and test subject sets then merge
file <- "./UCI HAR Dataset/test/subject_test.txt"
subject_test <- read.table(file, colClasses = "integer")
names(subject_test) <- c("subject")
file <- "./UCI HAR Dataset/train/subject_train.txt"
subject_train <- read.table(file, colClasses = "integer")
names(subject_train) <- c("subject")
subject <- rbind(subject_test, subject_train)
rm(subject_test, subject_train)
# Identify and select only mean and standard deviation measurement columns
means <- features[grep("mean()", features$feature_name, fixed = TRUE),]
stds <- features[grep("std()", features$feature_name, fixed = TRUE),]
extract <- rbind(means, stds)
rm(features, means, stds)
extract <- arrange(extract, column_number)
data_set <- X[, extract[, "column_number"]]
rm(X, extract)
# Bind subjects and activies to data set
data_set <- cbind(subject, y, data_set)
rm(subject, y)
# Insert descriptive activity names
data_set <- merge(activity_labels, data_set, by = "activity_code")
data_set$activity_code <- NULL
rm(activity_labels)
# Reorder and save data set
data_set <- arrange(data_set, subject, activity)
data_set <- data_set[, c(2,1,3:68)]
file <- "./data_set.txt"
write.table(data_set, file, row.name = FALSE)
tidy_data <- data_set %>% group_by(subject, activity) %>% summarise_each(funs(mean))
tidy_data <- arrange(tidy_data, subject, activity)
file <- "./tidy_data.txt"
write.table(tidy_data, file, row.name = FALSE)