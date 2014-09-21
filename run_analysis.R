library(reshape2)


### Read and combine the testing data

# Read the testing sensor data
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
names(X_test) <- features$V2

# Read the testing subject labels
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject_test)[1] <- "Subject"

# Read the testing activity labels
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
names(activity_test)[1] <- "activity_id"

# Combine the testing subject, activity, and sensor data into one dataframe
test_df <- cbind(subject_test, activity_test, X_test)


### Read and combine the training data

# Read the training sensor data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
names(X_train) <- features$V2

# Read the training subject labels
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subject_train)[1] <- "Subject"

# Read the training activity labels
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
names(activity_train)[1] <- "activity_id"

# Combine the training subject, activity, and sensor data into one dataframe
train_df <- cbind(subject_train, activity_train, X_train)



### Combine training and testing data frames
combined_df <- rbind(test_df, train_df)

### Toss out the non-mean and non-std measurements
combined_df <- combined_df[,grepl("std|mean|activity_id|Subject", names(combined_df)) ]
        
### Set activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("activity_id", "Activity")
combined_df <- merge(combined_df, activity_labels, by="activity_id")


# Group and average
melted <- melt(combined_df, id = c("Subject", "Activity"))
tidy_df <- dcast(melted, Subject + Activity ~ variable, mean)

# Remove activity_id column
tidy_df <- tidy_df[, c(1:2, 4:82)]

### Write data to file
write.table(tidy_df, "Tidy.csv", sep=",")
