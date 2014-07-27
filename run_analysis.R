# getdata-005 Course Project
if(!file.exists("./data")){
 message("Creating a 'data' folder")
 dir.create("./data")
}
if(!file.exists("./data/UCI HAR Dataset.zip")){
 message("Downloading the data file and unzipping it")
 fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 download.file(fileUrl, destfile = "./data/UCI HAR Dataset.zip", method = "curl")
 unzip("./data/UCI HAR Dataset.zip", exdir = "./data/")
}

## Q1. Merges the training and the test sets to create one data set.
# Load labels used in common in the train and test data set
message("Reading the data files")
features <- read.table("./data/UCI HAR Dataset/features.txt", head = FALSE, sep = " ", col.names = c("featureId", "featureDescription"))
activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt", head = FALSE, sep = " ", col.names = c("activityId", "activityLabel"))

## Q3. Uses descriptive activity names to name the activities in the data set
# Change activity labels ("WALKING_UPSTAIRS"...) to camel case (""walkingUpstairs"...)
activity$activityLabel <- gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", activity$activityLabel, perl = TRUE)
activity$activityLabel <- gsub("(\\w)(\\w*)_(\\w)(\\w*)", "\\U\\1\\L\\2\\U\\3\\L\\4", activity$activityLabel, perl = TRUE)

# Load the train and test data set
# Use features$featureDescription as column name
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", head = FALSE, sep = "", col.names = features[,2])
test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", head = FALSE, sep = "", col.names = features[,2])

# Load Subject Id of train and test set
trainSubjectId <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", head = FALSE, sep = " ", col.names = "subjectId")
testSubjectId <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", head = FALSE, sep = " ", col.names = "subjectId")

# Load Subject Activity Id of train and test set
trainSubjectActivityId <- read.table("./data/UCI HAR Dataset/train/y_train.txt", head = FALSE, sep = " ", col.names = "activityId")
testSubjectActivityId <- read.table("./data/UCI HAR Dataset/test/y_test.txt", head = FALSE, sep = " ", col.names = "activityId")

message("Merging the data")
# Bind the train and test set and their associated Subject and Activity Id.
dataSet <- cbind(rbind(trainSubjectId,testSubjectId), rbind(trainSubjectActivityId,testSubjectActivityId),rbind(train, test))

# Merge activity to dataSet by the common column activityId
dataSet = merge(dataSet, activity, by.x = "activityId")

## Q2. Extracts only the measurements on the mean and standard deviation (std) for each measurement.
message("Extracting and cleaning 'mean' and 'standard deviation (std)' data")
# Extract only mean and standard deviation (std) measurement from the dataSet
dataSetMeanStd <- dataSet[,grep("subjectId|activityLabel|mean[^Freq]|std",names(dataSet))] # meanFreq excluded

## Q4. Appropriately labels the data set with descriptive variable names.
# clean column names and use camel case for readability purpose
names(dataSetMeanStd) <- gsub("\\.", "", names(dataSetMeanStd))
names(dataSetMeanStd) <- gsub("mean", "Mean", names(dataSetMeanStd))
names(dataSetMeanStd) <- gsub("std", "Std", names(dataSetMeanStd))
names(dataSetMeanStd) <- gsub("^t", "timeDomain", names(dataSetMeanStd))
names(dataSetMeanStd) <- gsub("^f", "frequencyDomain", names(dataSetMeanStd)) # Fast Fourier Transformed (FFT) data -> in the frequencyDomain
names(dataSetMeanStd) <- gsub("([Bb]ody){2}", "Body", names(dataSetMeanStd))
names(dataSetMeanStd) <- gsub("Gyro", "AngularVelocity", names(dataSetMeanStd))
names(dataSetMeanStd) <- gsub("Acc", "LinearAcceleration", names(dataSetMeanStd))
names(dataSetMeanStd) <- gsub("Mag", "Magnitude", names(dataSetMeanStd))
names(dataSetMeanStd) <- gsub("Freq", "Frequency", names(dataSetMeanStd))

# Reorder columns (subjectId, activityLabel, measurements...)
idCols <- c("subjectId", "activityLabel")
measurementCols = setdiff(colnames(dataSetMeanStd), idCols) # Column names that are not Id but measurements
dataSetMeanStd <- dataSetMeanStd[,c(idCols, names(dataSetMeanStd)[-which(names(dataSetMeanStd) %in% idCols)])]

message("Writing the data set to 'dataSetCleanedMergedMeanStd.txt'")
write.table(dataSetMeanStd, file = "./dataSetCleanedMergedMeanStd.txt", row.names = FALSE, sep = ",") # Create tidy dataSet file

## Q5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# Create tidy data
library(reshape2)
message("Tidying the data")
dataSetMolten <- melt(dataSetMeanStd, id = idCols, measure.vars = measurementCols)
dataSetTidyAverage <- dcast(dataSetMolten,  subjectId + activityLabel ~ measurementCols, mean)

message("Writing the tidy data set to 'dataSetTidyAverage.txt'")
write.table(dataSetTidyAverage, file = "./dataSetTidyAverage.txt", row.names = FALSE, sep = ",") # Create tidy dataSet file
