CodeBook

The file that I have uploaded is tidyfile.txt and it can be read in using read.table("tidyfile.txt") so long as R has the appropriate working directory set.

For reference, all raw data was sourced from
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

This data set uses the raw data from the above. It is however a processed data set. It has grouped the data by activity and subject; that is that are unique combinations of activity and subject for which the averages of the data were calculated.

activity
  This is the descriptive name of the activity as defined by activity_labels
subject
  Refers to the subject from the data. Source data is from subject_train.txt and subject_test.txt raw data
List of averageed data:
