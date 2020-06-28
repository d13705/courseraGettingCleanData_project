# Code Book

## The data

The data that is use in this work is the Human Activity Recognition Using Smartphones Experiment 
([link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).

## The run_analysis script

1. The code in the R script read the datasets necessary for the process of clean data. Read the features.txt, activity_labels.txt, subject_test.txt,
X_test.txt, y_test.txt, subject_train.txt, X_train.txt and y_train.txt datasets. 

2. Take the feature datasets and transform the variable's names in a descriptive form with the mutate function and applying the gsub function. Example:
variable tBodyAcc-mean()-X is change by  TimeBodyAccelerometerMeanX.

3. Bind the X_test, X_train, y_test, y_train, subjects_test and subjects_train datasets to create one dataset using the bind_rows and bind_cols functions.

4. Extracts only the measurements on the mean (Mean) and standard deviation (STD) for each measurement with the use of select and contains functions.

5. Rename the activities with a appropiate descriptive name.

6. Summary the measurements by activity and subjects with the function mean.




