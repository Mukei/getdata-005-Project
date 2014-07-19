# getdata-005 Course Project
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/UCI HAR Dataset.zip", method="curl")
unzip("./data/UCI HAR Dataset.zip", exdir ="./data/")

directory = "./data/UCI HAR Dataset/test"
files_list <- list.files(directory, full.names=TRUE, recursive = TRUE) #creates a list of files 
df_test <- data.frame() #creates an empty data frame
#for (i in files_list) { #loops through the files, rbinding them together
#  test <- rbind(test, read.csv(i, header=FALSE))
#}

features <- read.table("./data/UCI HAR Dataset/features.txt", head=FALSE, sep=" ", col.names=c("feature_id", "feature_description"))

df_test$subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", head=FALSE, sep=" ")


#rep(c("mean","std","mad","max","min","sma","energy","iqr","entropy","arCoeff","correlation","maxInds","meanFreq","skewness","kurtosis","bandsEnergy","angle"))



