library(dplyr)

#Loading label data
activity_labels <- 
        as.character(read.table("./data/UCI HAR Dataset/activity_labels.txt")[,2])
features <- 
        as.character(read.table("./data/UCI HAR Dataset/features.txt")[,2])

#Loading test and train data
test_subject <- 
        as.integer(read.table("./data/UCI HAR Dataset/test/subject_test.txt")[,1])
test_X <- 
        read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = features)
test_y <- 
        as.factor(read.table("./data/UCI HAR Dataset/test/y_test.txt")[,1])
train_subject <- 
        as.integer(read.table("./data/UCI HAR Dataset/train/subject_train.txt")[,1])
train_X <- 
        read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = features)
train_y <- 
        as.factor(read.table("./data/UCI HAR Dataset/train/y_train.txt")[,1])

#Narrows test and training sets to just mean/std values
featureslogical <- grepl(pattern = ("mean()|std()"), features)
test_X <- test_X[,featureslogical]
train_X <- train_X[,featureslogical]

#Replaces numeric activity identifiers with descriptive activity labels (Walking, etc.)
test_y <- sapply(test_y, function(x) x = activity_labels[x])
train_y <- sapply(train_y, function(x) x = activity_labels[x])

#Consolidates components of test and training sets
test <- tbl_df(cbind(test_subject,test_y,test_X))
train <- tbl_df(cbind(train_subject, train_y, train_X))

#Renames variables to more descriptive names
test <- rename(test, Subject = test_subject, Action = test_y)
train <- rename(train, Subject = train_subject, Action = train_y)

#Combines test and training set
fulldataset <- bind_rows(test,train)

#Creates summary set
groupedmeans <-
        fulldataset %>%
        group_by(Subject, Action) %>%
        summarise_all(mean)

#Saves the tidy data in a new folder
if(dir.exists("./data/UCI HAR Dataset/tidy") == FALSE) {
        dir.create("./data/UCI HAR Dataset/tidy")}
write.table(fulldataset, file = "./data/UCI HAR Dataset/tidy/full.txt", row.names = FALSE)
write.table(groupedmeans, file = "./data/UCI HAR Dataset/tidy/means.txt", row.names = FALSE)
