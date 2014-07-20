# getdata-005 Course Project
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/UCI HAR Dataset.zip", method="curl")
unzip("./data/UCI HAR Dataset.zip", exdir ="./data/")

# Loading labels used in common for the train and test data set
features <- read.table("./data/UCI HAR Dataset/features.txt", head=FALSE, sep=" ", col.names=c("featureId", "featureDescription"))
activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt", head=FALSE, sep=" ", col.names=c("activityId", "activityLabel"))

# Loading the train and test set
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", head=FALSE, sep="", col.names = features[,2])
test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", head=FALSE, sep="", col.names = features[,2])

# Loading Subject Id of train and test set
trainSubjectId <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", head=FALSE, sep=" ", col.names="subjectId")
testSubjectId <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", head=FALSE, sep=" ", col.names="subjectId")

# Loading Subject Activity Id of train and test set
trainSubjectActivityId <- read.table("./data/UCI HAR Dataset/train/y_train.txt", head=FALSE, sep=" ", col.names="activityId")
testSubjectActivityId <- read.table("./data/UCI HAR Dataset/test/y_test.txt", head=FALSE, sep=" ", col.names="activityId")

# Binding the train and test set
dataSet <- cbind(rbind(trainSubjectId,testSubjectId), rbind(trainSubjectActivityId,testSubjectActivityId),rbind(train, test))

# Merging ActivityLabels to the dataSet by the subjectActivityId given by 
dataSet = merge(dataSet, activity, by.x="activityId")

