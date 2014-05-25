library(dplyr)
library(magrittr)

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

## Test
testid <- read.table("UCI HAR Dataset/test/subject_test.txt",
                      col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(x_test) <- colnames

y_test <- read.table("UCI HAR Dataset/test/y_test.txt",
                     col.names = "y")
test <- cbind(testid, x_test, y_test)


## Binding training and testing
data <- rbind(train, test)

## Get only mean and std
meas <- grep("mean\\(|std\\(", names(data), value = TRUE)
data <- data[, c("subject", "y", meas)]

## Merge the data and label
data <- inner_join(data, label)

## Remove "y" and reorder columns
data <- data[, c("subject", "activity", meas)]

cnames <- names(data)[-(1:2)]
cnames <- gsub("\\-|\\(|\\)", "", cnames) ## remove parenthesis
cnames <- gsub("^t", "timedomain", cnames) ## replace "t" by "timedomain"
cnames <- gsub("^f", "freqdomain", cnames) ## replace "f" by "freqdomain"
cnames <- gsub("Gyro", "gyroscope", cnames) ## replace "Gyro" by "gyroscope"
cnames <- gsub("Acc", "accelerometer", cnames) ## replace "Acc" by "accelerometer"
cnames <- gsub("Mag", "magnitude", cnames) ## replace "Mag" by "magnitude"
cnames <- gsub("BodyBody", "body", cnames) ## Remove duplicate body
cnames <- gsub("(.+)(std|mean)(X$|Y$|Z$)", "\\1\\3\\2", cnames) ## Put std or mean at the end
cnames <- tolower(cnames)
names(data)[-(1:2)] <- cnames

## Create the final aggregated data sets
data_agg <- data %>%
    group_by(subject, activity) %>%
        summarise_each(funs(mean))

## Save the tidy datasets
write.table(data_agg, "tidydata.tsv", row.names = FALSE)






