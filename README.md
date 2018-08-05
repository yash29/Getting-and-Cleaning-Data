# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data, Course 3 of the Data Science Specialization.
The R script, `run_analysis.R`, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the desired activity and feature info from the dataset
3. Loads both the training and test datasets, keeping only those columns which
   reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset
5. Merges the two datasets namey train and test
6. Converts the `activity` and `subject` columns into factors
7. Creates a tidy dataset consisting of the average (mean) value of each
   variable for each subject and activity pair.

The end result is stored in the file `tidy.txt`.
