library(plyr)

## Data URL
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

isdatapres <- file.exists("UCI HAR Dataset")

if (!isdatapres) {
    download.file(url,
                  destfile = "dataset.zip",
                  method = "curl")

    unzip("dataset.zip")
    file.remove("dataset.zip")
}

## Merge training and testing set
label <- read.table("UCI HAR Dataset/activity_labels.txt",
                    stringsAsFactors = FALSE,
                    col.names = c("y", "activity"))

colnames <- read.table("UCI HAR Dataset/features.txt",
                       row.names = 1, stringsAsFactors = FALSE,
                       col.names = c("id", "fnames"))
colnames <- colnames$fnames

trainid <- read.table("UCI HAR Dataset/train/subject_train.txt",
                      col.names = "subject")

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
names(x_train) <- colnames

y_train <- read.table("UCI HAR Dataset/train/y_train.txt",
                      col.names = "y")

train <- cbind(trainid, x_train, y_train)
str(train)

## Test
testid <- read.table("UCI HAR Dataset/test/subject_test.txt",
                      col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(x_test) <- colnames

y_test <- read.table("UCI HAR Dataset/test/y_test.txt",
                     col.names = "y")
test <- cbind(testid, x_test, y_test)
str(test)

## Binding training and testing
data <- rbind(train, test)
str(data, max.level = 1)
names(data)


## get mean and std
meas <- grep("mean\\(|std\\(", names(data), value = TRUE)
data <- data[, c("subject", "y", meas)]
str(data)

## Merge the data and label
data <- join(data, label)
data <- data[, c("subject", "activity", meas)]
str(data)

cnames <- names(data)[-(1:2)]
cnames <- gsub("\\-|\\(|\\)", "", cnames) ## remove parenthesis
cnames <- gsub("^t", "TimeDomain", cnames) ## replace "t" by "TimeDomain"
cnames <- gsub("^f", "FreqDomain", cnames) ## replace "f" by "FreqDomain"
cnames <- gsub("Gyro", "Gyroscope", cnames) ## replace "Gyro" by "Gyroscope"
cnames <- gsub("Acc", "Accelerometer", cnames) ## replace "Acc" by "Accelerometer"
cnames <- gsub("Mag", "Magnitude", cnames) ## replace "Mag" by "Magnitude"
cnames <- gsub("BodyBody", "Body", cnames) ## Remove duplicate Body
cnames <- gsub("(.+)(std|mean)(X$|Y$|Z$)", "\\1\\3\\2", cnames) ## Put std or mean at the end
cnames <- gsub("std", "Std", cnames) ## Replace std by Std
cnames <- gsub("mean", "Mean", cnames) ## Replace mean by Mean
names(data)[-(1:2)] <- cnames

## Create the final aggregated data sets
data_agg <- ddply(data, .(subject, activity), numcolwise(mean))
str(data_agg)

## Save tidy datasets
write.table(data_agg, "tidydata.txt", row.names = FALSE)
