
path = 'D:/R workspace/UCI HAR Dataset/'

test_path = paste0(path,'test/')
train_path = paste0(path,'train/')


# reading features (column names)
features = read.table(paste0(path, 'features.txt'))
features = features[,2]
# reading activities id-s and names
activities = read.table(paste0(path, 'activity_labels.txt'), col.names = c('id', 'activity'))

# reading test and train datasets, activity_id's and subject_id's for each measurement
df_test_data = read.table(paste0(test_path, 'X_test.txt'))
# COURSE PROJECT POINT 4: setting variable name
colnames(df_test_data) = features
df_test_subject = read.table(paste0(test_path, 'subject_test.txt'), col.names = 'subject_id')
df_test_activity = read.table(paste0(test_path, 'y_test.txt'), col.names = 'activity_id')

df_train_data = read.table(paste0(train_path, 'X_train.txt'))
# COURSE PROJECT POINT 4: setting variable names
colnames(df_train_data) = features
df_train_subject = read.table(paste0(train_path, 'subject_train.txt'), col.names = 'subject_id')
df_train_activity = read.table(paste0(train_path, 'y_train.txt'), col.names = 'activity_id')

# COURSE PROJECT POINT 1: binding the dataframes into one big dataframe
df_data = rbind(df_test_data, df_train_data)
df_subject = rbind(df_test_subject, df_train_subject)
df_activity = rbind(df_test_activity, df_train_activity)

df = cbind(df_data, df_subject, df_activity)

# finding column names (features) regarding mean() or std()
subset_column_names = c(grep("mean\\(\\)|std\\(\\)", features, value = T), 'subject_id','activity_id')

# COURSE PROJECT POINT 2: subsetting the mean() and std() values from dataframe 
df = df[subset_column_names]

# COURSE PROJECT POINT 3: merging activity_id with activity names
df_merged = merge(df, activities, by.x = 'activity_id', by.y = 'id', all.x = T)
df_merged = df_merged[, !colnames(df_merged) %in% c("activity_id")]

# COURSE PROJECT POINT 5: aggregating values for each subject_id and Activity pair
aggregate_columns = !(colnames(df_merged) %in% c("activity", "subject_id"))
df_mean = aggregate(x = df_merged[, aggregate_columns], by = list(df_merged$activity, df_merged$subject_id), FUN = mean)

# renaming column names after aggregation
colnames(df_mean)[colnames(df_mean) == "Group.1"] = 'Activity'
colnames(df_mean)[colnames(df_mean) == "Group.2"] = 'subject_id'


# writing to file 
write.table(df_mean, 'tidy_dataset.txt', row.names = F)
