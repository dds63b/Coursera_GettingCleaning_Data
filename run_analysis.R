# Download file
data <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
local.data <- './ds_project1.zip'

if (! file.exists(local.data)) {
        download.file(data,
                      destfile = local.data, method = 'curl')
        }

# Unzip local data
if (! file.exists(local.data)) {
        unzip(local.data)
}

# Set new wd
setwd('./UCI HAR Dataset')


# Part 1:
# Merge the training and the test sets to create one data set
trainX <- read.table("train/X_train.txt")
trainY <- read.table("train/y_train.txt")
subject <- read.table("train/subject_train.txt")
testX <- read.table("test/X_test.txt")
testY <- read.table("test/y_test.txt")
subjectTest <- read.table("test/subject_test.txt")

# Merge X train and test
MergedX <- rbind(trainX, testX)
# Merge Y train and test
MergedY <- rbind(trainY, testY)
# Merge subject train and test
subject_data <- rbind(subject, subjectTest)


# Part 2:
# Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table("features.txt")
# get only columns with mean or SD in their names
mean_sd <- grep("-(mean|std)\\(\\)", features[, 2])
# subset the needed columns
MergedX <- MergedX[, mean_sd]
# correct column names
names(MergedX) <- features[mean_sd, 2]


# Part 3:
# Use descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
# update values with correct activity names
MergedY[, 1] <- activities[MergedY[, 1], 2]
# correct column name
names(MergedY) <- "activity"


# Part 4:
# Appropriately label the data set with descriptive variable names

# correct column name
names(subject_data) <- "subject"
# bind all the data in a single data set
all_data <- cbind(MergedX, MergedY, subject_data)

# Step 5:
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject

library(plyr)
averages <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages, "averages_data.txt", row.name=FALSE)