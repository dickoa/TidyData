
# Instruction

You should create one R script called `run_analysis.R` that does the following : 
-   Merges the training and the test sets to create one data set.
-   Extracts only the measurements on the mean and standard deviation for each measurement.
-   Uses descriptive activity names to name the activities in the data set
-   Appropriately labels the data set with descriptive activity names.
-   Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Run the code

## Dependencies

You will need the \`dplyr\` package \`magrittr\` to run the \`run<sub>analysis.R</sub>\` script

```R
library(devtools)
install_github("hadley/dplyr")
install_github("hadley/magrittr")
```
