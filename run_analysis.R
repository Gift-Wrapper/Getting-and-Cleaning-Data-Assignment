##Open the dplyr package, it will be necessary later on

library(dplyr)

##Assigning variables to "training" and "test" .txt files

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

##Merging "training" and "test" data sets

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
MergeDF <- cbind(Subject, Y, X)

##Extracting Mean and Standard Deviation from each measurement

TidyDF <- MergeDF %>% select(subject, code, contains("mean"), contains("std"))

##Replacing code numbers with corresponding activity names

TidyDF$code <- activities[TidyDF$code, 2]

##Labeling data set with descriptive variable names

names(TidyDF)[2] = "activity"
names(TidyDF)<-gsub("Acc", "Accelerometer", names(TidyDF))
names(TidyDF)<-gsub("Gyro", "Gyroscope", names(TidyDF))
names(TidyDF)<-gsub("BodyBody", "Body", names(TidyDF))
names(TidyDF)<-gsub("Mag", "Magnitude", names(TidyDF))
names(TidyDF)<-gsub("^t", "Time", names(TidyDF))
names(TidyDF)<-gsub("^f", "Frequency", names(TidyDF))
names(TidyDF)<-gsub("tBody", "TimeBody", names(TidyDF))
names(TidyDF)<-gsub("-mean()", "Mean", names(TidyDF), ignore.case = TRUE)
names(TidyDF)<-gsub("-std()", "StandDev", names(TidyDF), ignore.case = TRUE)
names(TidyDF)<-gsub("-freq()", "Frequency", names(TidyDF), ignore.case = TRUE)
names(TidyDF)<-gsub("angle", "Angle", names(TidyDF))
names(TidyDF)<-gsub("gravity", "Gravity", names(TidyDF))

##Creating independent tidy data set

CompleteDF <- TidyDF %>%
  group_by(subject, activity)%>%
  summarise_all(funs(mean))
write.table(CompleteDF, "CompleteDF.txt", row.names = FALSE)