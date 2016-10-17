# Data Science
# Getting and Cleaning Data
# Final Project

#   *****
#   *****   1. Merge training and test data sets to create one data set
#   *****
# first set the path for the training and data files
# then load in the data sets
core_path = "/users/apine/documents/datacourse/cleaningdata/uci_dataset/"
fname <- paste(core_path,"train/X_train.txt",sep="")
wearable_set <- read.table(fname, colClasses = "character") # this is just the training set for now but it will hold the entire set
fname <- paste(core_path,"test/X_test.txt",sep="")
test_set <- read.table(fname,colClasses = "character")
# now combine the data sets into one dataframe
wearable_set <- rbind(wearable_set,test_set)
# 1 is complete. both data sets are combined into one large data set of 561 columns

#   *****
#   *****   2. extracts only the measurments on the mean and std dev
#   *****       for each measurement
#   *****
#   first, we need the column names
#   these are in the features.txt file
fname <- paste(core_path,"features.txt",sep="")
features = read.table(fname)
# may as well add actual column names to the data set
colnames(wearable_set)=features$V2
# now a list of columns that contains "mean" or "std"
col_list <- grep("mean|std",features$V2)
pruned_data <- wearable_set[,col_list]
#   2: pruned_data has only the measurments on the mean and std dev for each measurement



