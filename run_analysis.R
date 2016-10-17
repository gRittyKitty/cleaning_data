# Data Science
# Getting and Cleaning Data
# Final Project

library(readr)
library(dplyr)

#   *****
#   *****   1. Merge training and test data sets to create one data set
#   *****
# first set the path 
# then load in the data sets

# First load in all data associated with training
# I use fname as a temporary variable for the file name of what is read in
core_path = "/users/apine/documents/datacourse/cleaningdata/uci_dataset/"
fname <- paste(core_path,"train/X_train.txt",sep="")
train_set <- read.table(fname) # this is just the training set for now but it will hold the entire set
fname <- paste(core_path,"test/X_test.txt",sep="")
test_set <- read.table(fname)
# now combine the data sets into one dataframe
wearable_set <- rbind(train_set,test_set)
# lets now add in the activity data
fname <- paste(core_path,"train/y_train.txt",sep="")
train_activity_set <- read.table(fname)
fname <- paste(core_path,"test/y_test.txt",sep="")
test_activity_set <- read.table(fname)
activity_set <- rbind(train_activity_set,test_activity_set)
colnames(activity_set)="activity"
wearable_set = cbind(wearable_set,activity_set)
# lets now add in the subject data
fname <- paste(core_path,"train/subject_train.txt",sep="")
train_subject_set <- read.table(fname)
fname <- paste(core_path,"test/subject_test.txt",sep="")
test_subject_set <- read.table(fname)
subject_set = rbind(train_subject_set,test_subject_set)
colnames(subject_set)="subject"
wearable_set = cbind(wearable_set,subject_set)
# 1 is complete. all data sets are combined into one large data set 
# named wearable_set

#   *****
#   *****   2. extracts only the measurments on the mean and std dev
#   *****       for each measurement
#   *****
#   first, we need the column names
#   these are in the features.txt file
fname <- paste(core_path,"features.txt",sep="")
features = read.table(fname)
# may as well add actual column names to the data set
# NOTE that this is actually most of #4
colnames(wearable_set)=features$V2
# now a list of columns that contains "mean" or "std"
col_list <- grep("mean|std",features$V2)
pruned_data <- wearable_set[,col_list]
#   2: pruned_data has only the measurments on the mean and std dev for each measurement
# but we eliminated the columns for activity and subject
pruned_data <- cbind(pruned_data, activity_set, subject_set)


#   *****
#   *****   3. Use descriptive activity names to name activities in data set
#   *****
#   first get labels
fname <- paste(core_path,"activity_labels.txt",sep="")
labels <- read.table(fname)
colnames(labels)[1]="activity"  # this is done to have an appropriate merge
labeled_set <- merge(pruned_data,labels)
# labeled_set is the data set and now contains the activities as descriptive names

#   *****
#   *****   4. Appropriately labels the data set with descriptive variable names
#   *****
#  Nearly all of this has already been done in the preceding steps
# The one 'v' column has the descriptive labels that we just added
labeled_set <- labeled_set[,-1] # have to get rid of the columnn of numbers
colnames(labeled_set)[81] = "activity"

# ****
# labeled_set is the data set that has the data for #4
# ****
tidy_set = labeled_set %>% group_by(activity,subject) %>% summarise_each(funs(mean))
fname = paste(core_path,"tidyfile.txt",sep="")
write.table(tidy_set,fname)

