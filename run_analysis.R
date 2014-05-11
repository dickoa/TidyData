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

## Tidy data 1
data <- join(data, label)
data <- data[, c("subject", "activity", meas)]
str(data)

cnames <- names(data)[-(1:2)]
gsub("\\-|\\(|\\)", "", cnames)
cnames

## Tidy data 2
data_agg <- ddply(data, .(subject, activity), numcolwise(mean))
str(data_agg)
