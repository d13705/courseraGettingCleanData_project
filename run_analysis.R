library(readr)
library(dplyr)
library(purrr)
library(stringr)
library(tidyr)

# read data

features <- read_table("UCI HAR Dataset/features.txt", col_names = "variable") %>% 
        separate(variable, c("n", "variable"), sep = " ")
activity <- read_table("UCI HAR Dataset/activity_labels.txt", col_names = c("n", "activity"))
subject_test <- read_table("UCI HAR Dataset/test/subject_test.txt", col_names = "subject")
X_test <- read_table("UCI HAR Dataset/test/X_test.txt", col_names = FALSE) %>% 
        mutate(group = "test")
y_test <- read_table("UCI HAR Dataset/test/y_test.txt", col_names = "id") %>% 
        mutate(group = "test")
subject_train <- read_table("UCI HAR Dataset/train/subject_train.txt", col_names = "subject")
X_train <- read_table("UCI HAR Dataset/train/X_train.txt", col_names = FALSE) %>% 
        mutate(group = "train")
y_train <- read_table("UCI HAR Dataset/train/y_train.txt", col_names = "id") %>% 
        mutate(group = "train")

# Appropriately labels the data set with descriptive variable names. 

features <- features %>% 
        mutate(variable = gsub("[- | ()]", "", variable)) %>%
        mutate(variable = gsub("^t", "Time", variable)) %>%
        mutate(variable = gsub("^f", "Frequency", variable)) %>% 
        mutate(variable = gsub("mean", "Mean", variable)) %>% 
        mutate(variable = gsub("std", "STD", variable)) %>% 
        mutate(variable = gsub("Acc", "Accelerometer", variable)) %>%
        mutate(variable = gsub("Gyro", "Gyroscope", variable)) %>% 
        mutate(variable = gsub("Mag", "Magnitude", variable)) %>% 
        mutate(variable = gsub("angle", "Angle", variable)) %>% 
        mutate(variable = gsub("gravity", "Gravity", variable))
        

colnames(X_test) <- features$variable
colnames(X_train) <- features$variable

# Merges the training and the test sets to create one data set.

X_group <- bind_rows(X_test, X_train) 
y_group <- bind_rows(y_test, y_train) 
subjects <- bind_rows(subject_test, subject_train)
Data <- bind_cols(subjects, X_group, y_group)

# Extracts only the measurements on the mean and standard deviation for each measurement. 

Data.1 <- Data %>% 
        select(subject, id, contains("Mean"), contains("STD")) %>% 
        arrange(subject)

# Appropriately labels the data set with descriptive variable names. 

Data.1$id <- activity[Data.1$id, 2]

mean.Data <- Data.1 %>% rename(activity = id) %>% 
        group_by(subject, activity) %>% 
        summarise_all(funs(mean)) 

write_tsv(mean.Data, "tidyData.txt")
