## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

bind_helper <- function(activity_labels,features,x_set,y_set,subject){
  x_set <- x_set[,features]
  
  # Load activity labels
  y_set[,2] = activity_labels[y_set[,1]]
  names(y_set) = c("Activity_ID", "Activity_Label")
  names(subject) = "subject"
  
  # Bind x and y data 
  data <- cbind(as.data.table(subject), y_set, x_set)
  
  data
  
}

run_analysis <- function(){
  
  if (!require("data.table")) {
    install.packages("data.table")
  }
  
  if (!require("reshape2")) {
    install.packages("reshape2")
  }
  
  require("data.table")
  require("reshape2")
  
  # Load activity labels and features
  activity_labels <- read.table("./Dataset/UCI HAR Dataset/activity_labels.txt")[,2]
  features <- read.table("./Dataset/UCI HAR Dataset/features.txt")[,2]
  
  # Extract mean and standard deviation for each measurement.
  ext_features <- grepl("mean|std", features)
  
  # Load data from testing set.
  X_test <- read.table("./Dataset/UCI HAR Dataset/test/X_test.txt")
  Y_test <- read.table("./Dataset/UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("./Dataset/UCI HAR Dataset/test/subject_test.txt")
  
  #Apply extracted features to testing set
  names(X_test) <- features
  
  test_data <- bind_helper(activity_labels,ext_features,
                           X_test,Y_test,subject_test)
  
  ### Repeat above for training set
  
  X_train <- read.table("./Dataset/UCI HAR Dataset/train/X_train.txt")
  Y_train <- read.table("./Dataset/UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("./Dataset/UCI HAR Dataset/train/subject_train.txt")
  
  names(X_train) <- features
 
  # Bind x and y data from training set
  train_data <- bind_helper(activity_labels,ext_features, 
                            X_train, Y_train,subject_train)
  
  # Merge test and train data
  merged_data <- rbind(test_data, train_data)
  id_labels <- c("subject", "Activity_ID", "Activity_Label")
  data_labels <- setdiff(colnames(data), id_labels)
  melted_data <- melt(merged_data, id = id_labels, measure.vars = data_labels)
  
  # Tidy the dataset
  tidy_data <- dcast(melted_data, subject + Activity_Label ~ variable, mean)
  
  #Write tidied data to file
  if(!dir.exists("./Dataset/Tidy")){
    dir.create("./Dataset/Tidy")
  }
  write.table(tidy_data, file = "./Dataset/Tidy/tidy_data.txt",row.names = FALSE)
}