library(dplyr)

#load in labels for numeric values in activity data
activity_labels <- read.csv(file.path("UCI HAR Dataset","activity_labels.txt"), 
                            header = FALSE, 
                            sep = " ", 
                            col.names = c("activity_code","activity_label"))


#load in list of features, and create an index list for mean and 
#standard deviation measurements
features <- read.csv(file.path("UCI HAR Dataset","features.txt"),
                     header = FALSE,
                     sep = " ",
                     col.names = c("index", "feature"))

mean_std_features <- grep("(std\\(\\)|mean\\(\\))", features$feature)

###################
##load in test data
###################
test_data <- read.csv(file.path("UCI HAR Dataset","test","X_test.txt"), 
                      header = FALSE, 
                      sep = "", 
                      col.names = features$feature,
                      check.names = FALSE)

#discard all but mean and standard deviation measurements
test_data <- test_data[ , mean_std_features]

#load in subject identifiers for test data
test_data_subjects <- read.csv(file.path("UCI HAR Dataset","test","subject_test.txt"),
                               header = FALSE,
                               col.names = "subject")

#load in activity classifications for test data
test_data_activity <- read.csv(file.path("UCI HAR Dataset","test","y_test.txt"), 
                               header = FALSE,
                               col.names = "activity_code")

#join in descriptive labels for activity classifications
test_data_activity <- left_join(test_data_activity, 
                                 activity_labels,
                                 by = "activity_code")

#join activity label and subject to data set
test_data <- cbind(test_data, 
                   activity = test_data_activity$activity_label,
                   test_data_subjects)

#######################
##load in training data
#######################
train_data <- read.csv(file.path("UCI HAR Dataset","train","X_train.txt"), 
                       header = FALSE, 
                       sep = "",
                       col.names = features$feature,
                       check.names = FALSE)

#discard all but mean and standard deviation measurements
train_data <- train_data[ , mean_std_features]

#load in subject identifiers for training data
train_data_subjects <- read.csv(file.path("UCI HAR Dataset","train","subject_train.txt"),
                               header = FALSE,
                               col.names = "subject")

#load in activity classifications for training data
train_data_activity <- read.csv(file.path("UCI HAR Dataset","train","y_train.txt"), 
                                header = FALSE,
                                col.names = "activity_code")

#join in descriptive labels for activity classifications
train_data_activity <- left_join(train_data_activity, 
                                 activity_labels,
                                 by = "activity_code")

#join activity label and subject to data set
train_data <- cbind(train_data, 
                    activity = train_data_activity$activity_label,
                    train_data_subjects)


#combine test and training data
combined_data <- rbind(test_data, train_data)

#generate averages for each variable for each activity and subject
tidy_data <- combined_data %>% group_by(activity, subject) %>% summarize_each(funs(mean))

#output new tidy data
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE, col.names = TRUE)



