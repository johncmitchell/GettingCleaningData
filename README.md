---
title: "GCD Project"
author: "John Mitchell"
date: "October 23, 2015"
output: html_document
---
## Purpose:
The purpose of this project is to simplifiy  the UCI HAR Dataset (which contains 561 measurements from smartphone gyroscope and accelerometer data that are matched to subjects and corresponding activites, verified by video review). The data needs to be imported and fitted together, properly labeled, subsetted, and then averaged to create the required tidy data set. This readme will explain the code in the run_analysis.R file that accomplished this transformation.

## Presteps: 
Before running the script, the UCI data needs to be downloaded and unzipped. There are a number of subfolders within this dataset, including a test set and train set, a features list, etc. The working directory should be set to the UCI HAR Dataset folder.

## Steps:
The dplyr and car libraries are loaded, to be able to use their functionality:
```{r}
library(dplyr)
library(car)
```

The feature names are read in from the features.txt file, since they include a column of numbers, just the second column is used.
```{r}
features <- read.table("./features.txt")
features <- features[,2]
```
For both the test and train set, the measurements, along with the subjects and activity labels are loaded into the environment and bound together into a data table. The feature names from above are applied to the column names for the measurements. The subjects and activities labels are named accordingly.

```{r}
test_subjects <- read.table("./test/subject_test.txt", col.names = c("Subject"))
xtest <- read.table("./test/X_test.txt", col.names = features)
ytest <- read.table("./test/y_test.txt", col.names = c("Activities"))
test <- cbind(xtest, test_subjects, ytest)

train_subjects <- read.table("./train/subject_train.txt", col.names = c("Subject"))
xtrain <- read.table("./train/X_train.txt", col.names = features)
ytrain <- read.table("./train/y_train.txt", col.names = c("Activities"))
train <- cbind(xtrain, train_subjects, ytrain)
```
There are now two distinct data sets: a test set and a train set. The script will row bind them together to make one complete data set. 
(step one in the instructions)
```{r}
data <- rbind(test, train)
```

There is now one data set. This set has 10,299 observations of 563 variables. The assignment is only interested in the measurements that involve means and standard definitions. In the feature names, there are features that include "mean()" and also features that include "meanfreq". It wasn't 100% clear whether the meanfreq values are truely a mean value but to be on the safe side, it is included in the tidy set.

The subject and activity column names are going to be preserved for use in filtering
```{r}
other <- c("Subject", "Activities")
```

The grep function is used to collect any column names that include the phrase "mean" or "std", in respective objects. The Subject and Activity columns are also collected using the "other" list.
```{r}
data_std <- data[grep("std()", names(data))]
data_mean <- data[grep("mean()", names(data))]
data_other <- data[, other]
```

The three sets of columns are now bound together to make a second data set with just the desired features. 
(step two in the instructions)
```{r}
data2 <- cbind(data_std, data_mean, data_other)
```

The activity numbers are now replaced with descriptive names (from the activity_labels.txt file ).
(step three in the instructions)
```{r}
data2$Activities <- recode(data2$Activities, "1 = 'WALKING'; 2 = 'WALKING_UPSTAIRS'; 
3 = 'WALKING_DOWNSTAIRS'; 4 = 'SITTING'; 5 = 'STANDING'; 6 = 'LAYING'")
```

The feature names provided in the features.txt file don't follow the standard for tidy data. The script thus transforms the labels, eliminating upper case character, periods, parenthesis, and dashes. The script also replaces partial words with complete word labels. 
(step four in the instructions)
```{r}
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
```

The script now uses dplyr to group and summarize the cleaned data2 data set so that a tidy data set is produced with the average of each variable for each activity and each subject.
(step 5 in the instructions)
```{r}
tidy <- data2 %>% group_by(subject, activities) %>% 
summarise_each(funs(mean), matches("mean()"), matches("standarddeviation()"))
```

Finally, the script writes the table to a file. Although the .txt file is difficult to read. There is a .csv file in the GitHub so that the reader can quickly get a clear view of the tidy table.
```{r}
write.table(tidy, file = "./tidy.txt", row.names = FALSE)
write.csv(tidy, file = "./tidy.csv", row.names = FALSE)
```

The resulting table, tidy, is a tidy data set. There are descriptive variable labels, there is one row for each measurement, one column for each variable. With a cube of data, there are potentially other ways of formatting the data (wide vs long, a set of tables for each subject, etc) but this presentation is the easiest for the reader to quickly and clearly see the required values. 

