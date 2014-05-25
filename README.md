
# Instruction

## Goal

This is the second project for the Getting and Cleaning data science from Coursera.
The goal of this project is to turn a raw dataset to a "tidy" data.

## Data source

The data used for this exercice represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

## Run the code

You will find in this repository a R script called `run_analysis.R` that does the following : 
-   Merges the training and the test sets to create one data set.
-   Extracts only the measurements on the mean and standard deviation for each measurement.
-   Uses descriptive activity names to name the activities in the data set
-   Appropriately labels the data set with descriptive activity names.
-   Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Dependencies

You will need the `dplyr` and `magrittr` packages to run the `run_analysis.R` script :

```R
library(devtools)
install_github("hadley/dplyr")
install_github("hadley/magrittr")
```
