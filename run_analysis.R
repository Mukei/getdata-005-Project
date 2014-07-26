# getdata-005 Course Project
if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/UCI HAR Dataset.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = "./data/UCI HAR Dataset.zip", method="curl")
  unzip("./data/UCI HAR Dataset.zip", exdir ="./data/")
}

## Q1. Merges the training and the test sets to create one data set.
# Load labels used in common in the train and test data set
features <- read.table("./data/UCI HAR Dataset/features.txt", head=FALSE, sep=" ", col.names=c("featureId", "featureDescription"))
activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt", head=FALSE, sep=" ", col.names=c("activityId", "activityLabel"))

## Q3. Uses descriptive activity names to name the activities in the data set
# Change activity labels ("WALKING_UPSTAIRS"...) to camel case (""walkingUpstairs"...)
activity$activityLabel <- gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", activity$activityLabel, perl=TRUE)
activity$activityLabel <- gsub("(\\w)(\\w*)_(\\w)(\\w*)", "\\U\\1\\L\\2\\U\\3\\L\\4", activity$activityLabel, perl=TRUE)

# Load the train and test set
# Use features$featureDescription as column name
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", head=FALSE, sep="", col.names = features[,2])
test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", head=FALSE, sep="", col.names = features[,2])

# Load Subject Id of train and test set
trainSubjectId <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", head=FALSE, sep=" ", col.names="subjectId")
testSubjectId <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", head=FALSE, sep=" ", col.names="subjectId")

# Load Subject Activity Id of train and test set
trainSubjectActivityId <- read.table("./data/UCI HAR Dataset/train/y_train.txt", head=FALSE, sep=" ", col.names="activityId")
testSubjectActivityId <- read.table("./data/UCI HAR Dataset/test/y_test.txt", head=FALSE, sep=" ", col.names="activityId")

# Bind the train and test set and their associated Subject and Activity Id.
dataSet <- cbind(rbind(trainSubjectId,testSubjectId), rbind(trainSubjectActivityId,testSubjectActivityId),rbind(train, test))

# Merge activity to dataSet by the common column activityId
dataSet = merge(dataSet, activity, by.x="activityId")


## Q2. Extracts only the measurements on the mean and standard deviation (std) for each measurement.
# Extract only mean and standard deviation (std) measurement from the dataSet
meanStdDataSet <- dataSet[,grep("subjectId|activityLabel|mean[^Freq]|std",names(dataSet))] # meanFreq excluded

## Q4. Appropriately labels the data set with descriptive variable names.
# clean column names and use camel case for readability purpose
names(meanStdDataSet) <- gsub("\\.", "", names(meanStdDataSet))
names(meanStdDataSet) <- gsub("mean", "Mean", names(meanStdDataSet))
names(meanStdDataSet) <- gsub("std", "Std", names(meanStdDataSet))
names(meanStdDataSet) <- gsub("^t", "timeDomain", names(meanStdDataSet))
names(meanStdDataSet) <- gsub("^f", "frequencyDomain", names(meanStdDataSet)) # Fast Fourier Transformed (FFT) data -> in the frequencyDomain
names(meanStdDataSet) <- gsub("([Bb]ody){2}", "Body", names(meanStdDataSet))
names(meanStdDataSet) <- gsub("Gyro", "AngularVelocity", names(meanStdDataSet))
names(meanStdDataSet) <- gsub("Acc", "LinearAcceleration", names(meanStdDataSet))
names(meanStdDataSet) <- gsub("Mag", "Magnitude", names(meanStdDataSet))
names(meanStdDataSet) <- gsub("Freq", "Frequency", names(meanStdDataSet))

# Reorder columns (subjectId, activityLabel, measurements...)
idCols <- c("subjectId", "activityLabel")
measurementCols = setdiff(colnames(meanStdDataSet), idCols) # Column that are not Id but measurements
meanStdDataSet <- meanStdDataSet[,c(idCols, names(meanStdDataSet)[-which(names(meanStdDataSet) %in% idCols)])]

write.table(dataSetTidyAverage, file="./dataSetTidyAverage.txt", row.names=FALSE) # Create tidy dataSet file

## Q5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# Create tidy data
library(reshape2)
dataSetMolten <- melt(meanStdDataSet, id=idCols ,measure.vars= measurementCols)
dataSetTidyAverage <- dcast(dataSetMolten, activityLabel + subjectId ~ measurementCols, mean)
write.table(dataSetTidyAverage, file="./dataSetTidyAverage.txt", row.names=FALSE) # Create tidy dataSet file

