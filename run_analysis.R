# GCD Project Script
# This script assumes that the UCI data has been downloaded. For brevity sake,
# the working directory is the "UCI HAR Dataset" folder

library(dplyr)
library(car)
# Read in the column names, these will be assigned as the 
# descriptive variable names
features <- read.table("./features.txt")
features <- features[,2]

# Read in the three sets of data (subjects, values, and labels) for both test
# and train sets.
test_subjects <- read.table("./test/subject_test.txt", col.names = c("Subject"))
xtest <- read.table("./test/X_test.txt", col.names = features)
ytest <- read.table("./test/y_test.txt", col.names = c("Activities"))
test <- cbind(xtest, test_subjects, ytest)

train_subjects <- read.table("./train/subject_train.txt", col.names = c("Subject"))
xtrain <- read.table("./train/X_train.txt", col.names = features)
ytrain <- read.table("./train/y_train.txt", col.names = c("Activities"))
train <- cbind(xtrain, train_subjects, ytrain)

# Merges the training and the test sets to create one data set.
data <- rbind(test, train)

other <- c("Subject", "Activities")

# Extracts only the measurements on the mean and standard deviation for 
# each measurement. 
data_std <- data[grep("std()", names(data))]
data_mean <- data[grep("mean()", names(data))]
data_other <- data[, other]

data2 <- cbind(data_std, data_mean, data_other)

#Uses descriptive activity names to name the activities in the data set
data2$Activities <- recode(data2$Activities, "1 = 'WALKING'; 2 = 'WALKING_UPSTAIRS'; 3 = 'WALKING_DOWNSTAIRS'; 4 = 'SITTING'; 5 = 'STANDING'; 6 = 'LAYING'")

# Appropriately labels the data set with descriptive variable names. 
# Transforming the given names. 
names(data2) <- tolower(names(data2))
names(data2) <- gsub("\\.", "", names(data2))
names(data2) <- gsub("freq", "frequency", names(data2))
names(data2) <- gsub("acc", "accelerometer", names(data2))
names(data2) <- gsub("^t", "time", names(data2))
names(data2) <- gsub("^f", "frequency", names(data2))
names(data2) <- gsub("gyro", "gyroscope", names(data2))
names(data2) <- gsub("bodybody", "body", names(data2))
names(data2) <- gsub("jerk", "jerking", names(data2))
names(data2) <- gsub("mag", "magnitude", names(data2))
names(data2) <- gsub("std", "standarddeviation", names(data2))

#From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
tidy <- data2 %>% group_by(subject, activities) %>% summarise_each(funs(mean), matches("mean()"), matches("standarddeviation()"))

# Write the file to a table
write.table(tidy, file = "./tidy.txt", row.names = FALSE)
write.csv(tidy, file = "./tidy.csv", row.names = FALSE)
