Getting and Cleaning Data - Course Project
==========================================

Summary
-------

This project utilizes the UCI HAR Dataset available online at https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones to create a tidy dataset containing the average values of the mean and standard deviations of each feature for each activity type per test subject.

Included Files
--------------

* README.md - This file
* CodeBook.md - A detailed description of the data generated by `run_analysis.R`
* run_analysis.R - R script that completes all data processing

Details
-------

All data manipulation is done by the script `run_analysis.R`. The script should be run from a directory that contains the extracted directory `UCI HAR Dataset` that is included in the zip file available at the link provided above.

The script reads in the training and test datasets, combines the two, and then generates summary calculations which are written out to the file `tidy_data.txt` with descriptive column names and activity labels included. The output file included one row for each activity for each test subject, and the calculated mean for 66 different feature variables. Details on the exact features included can be found in `CodeBook.md`.

