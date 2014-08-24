run_analysis <- function(){
    # check if data are existed, and download data if not existed
    checkdata <- function(filepath){
        download_url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
        if (!file.exists(filepath)){
            print("A file was not found. Your data may be corrupted! Downloading all data again ...")
            download.file(download_url, 'data_downloaded.zip')
            unzip('data_downloaded.zip')
        }
    }
    list_file <- c('UCI HAR Dataset/test/subject_test.txt','UCI HAR Dataset/test/X_test.txt','UCI HAR Dataset/test/y_test.txt','UCI HAR Dataset/train/subject_train.txt','UCI HAR Dataset/train/X_train.txt','UCI HAR Dataset/train/y_train.txt','UCI HAR Dataset/features.txt','UCI HAR Dataset/activity_labels.txt')
    sapply(list_file, checkdata)
    
    #read test data and merge it all to test data
    subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
    X_test <- read.table('UCI HAR Dataset/test/X_test.txt')
    y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
    test_data <- cbind(subject_test, y_test, X_test)
    
    #read train data and merge it all to train data
    subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')
    X_train <- read.table('UCI HAR Dataset/train/X_train.txt')
    y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
    train_data <- cbind(subject_train, y_train, X_train)
    
    # merge all test data and train data to raw data
    raw_data <- rbind(test_data, train_data)
    
    # read features and acitivity_labels
    features <- read.table('UCI HAR Dataset/features.txt')
    activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')
    
    # change the variables' name for raw_data
    colnames(raw_data)[1] <- "subject"
    colnames(raw_data)[2] <- "activity"
    colnames(raw_data)[3:563] <- as.vector(features[,2])
    
    # Extracts only the measurements on the mean and standard deviation for each measurement.
    filtered <- as.vector(features[grepl("mean()",features[,"V2"],fixed=TRUE) | grepl("std()",features[,"V2"],fixed=TRUE),][,2])
    filtered <- c("subject","activity",filtered)
    raw_data <- raw_data[,filtered] # finished collecting raw data
    print("recording raw data to raw_data.txt ...")
    write.table(raw_data, file="raw_data.txt")
    
    # get average for each activity
    activity_result <- vector()
    for(i in 1:6){
        activity_result <- rbind(activity_result, sapply(raw_data[which(raw_data$activity == i),][,3:68], mean))
    }
    rownames(activity_result) <- as.vector(activity_labels[,2])
    print("recording activity_result to activity_result.txt ...")
    write.table(activity_result, file="activity_result.txt")
    
    # get average for each subject
    subject_result <- vector()
    for(i in 1:30){
        subject_result <- rbind(subject_result, sapply(raw_data[which(raw_data$subject == i),][,3:68], mean))
    }
    print("recording subject_result to subject_result.txt ...")
    write.table(subject_result, file="subject_result.txt")
    
    # merge all to a tidy data set
    tidy_data <- rbind(activity_result, subject_result)
    print("recording tidy data to final_result.txt ...")
    write.table(tidy_data, file="final_result.txt", row.name=FALSE)
}