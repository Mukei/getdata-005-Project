# README
July 27, 2014  

This repository was made for the project in the course __Getting and Cleaning Data__ of the Johns Hopkins Bloomberg School of Public Health available on Coursera at <https://class.coursera.org/getdata-005>.

This project makes use of data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained from: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>  
Original data available at: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.

---

### Purpose of the project

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive variable names. 
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 


### Repository file description

* __run_analysis.R__ goes through the above step 1. to 5. to eventually create 2 tidy version of the data. More details  on the process are available in the codebook.md file.
* __codebook.md__ describes the variables, the data, and any transformations or work that is performed to clean up the data.
* __dataSetCleanedMergedMeanStd.txt__ is a cleaned and merged version of the training and test data sets. It contains only the measurements on the mean and standard deviation for each measurement. (CSV format)
* __dataSetTidyAverage.txt__ is an independent tidy data set with the average of each variable for each activity and each subject. (CSV format)
