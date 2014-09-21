GettingDataProject
==================

- This script operates on the "UCI HAR Dataset" and assumes "UCI HAR Dataset" will be in the current working directory.

- run_analysis.R first takes the test directory sensor data, activity numbers, and subject numbers and combines them into a single dataframe.i The script then does the same for the training data.

- Columns are named according to the file "UCI HAR Dataset/features.txt".  The activity id's are replaced with activity labels found "UCI HAR Dataset/activity_labels.txt".

- All columns are discarded except for Subject, Activity, and columns containing a "std" or "mean". The data is summarized by Subject and Activity. Means of all numeric columns are calculated. The tidy dataset is written to "Tidy.txt". 
