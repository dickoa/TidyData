
# Goal

This is the second project for the Getting and Cleaning data science from Coursera.
The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be easily used for further analysis. 

# Data source

The data used for this exercice represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

# How to run the code

You will find in this repository a R script called `run_analysis.R` that does the following : 
-   Bind the training and the test sets to create one data set.
-   Extracts only the measurements on the mean and standard deviation for each measurement.
-   Uses descriptive activity names to name the activities in the data set (columns name)
-   Appropriately labels the data set with descriptive activity names.
-   Creates the final tidy data set with the average of each variable for each activity and each subject.

You will need the latest version of the `dplyr` and `magrittr` packages to run the `run_analysis.R` script

```R
library(devtools)
install_github("hadley/dplyr")
install_github("hadley/magrittr")
```

# Submitted tidy data set

The final data submitted is a tabulated separated file (`tidata.tsv`) (data columns separated by tabulation).
A [codebook](https://github.com/dickoa/TidyData/blob/master/CodeBook.md) (`CodeBook.md`) is available and give a brief description of the tidy
data set columns.
