
# read the test data
test.labels <- read.table("test/y_test.txt", col.names="label")
test.subjects <- read.table("test/subject_test.txt", col.names="subject")
test.data <- read.table("test/X_test.txt")
# read the training data
train.labels <- read.table("train/y_train.txt", col.names="label")
train.subjects <- read.table("train/subject_train.txt", col.names="subject")
train.data <- read.table("train/X_train.txt")

# merge the data together 
data <- rbind(cbind(test.subjects, test.labels, test.data),
              cbind(train.subjects, train.labels, train.data))


# read the features file
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
# get the  features of mean and standard deviation
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

# select  the means and standard deviations from data

data.mean.std <- data[, c(1, 2, features.mean.std$V1+2)]


# read the labels (activities)
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
# replace labels in data with label names
data.mean.std$label <- labels[data.mean.std$label, 2]


# first make a list of the current column names and feature names
good.colnames <- c("subject", "label", features.mean.std$V2)

# removing every non-alphabetic character and converting to lowercase
good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames))
# then use the list as column names for data
colnames(data.mean.std) <- good.colnames


# find the mean for each combination of subject and label
aggr.data <- aggregate(data.mean.std[, 3:ncol(data.mean.std)],
                       by=list(subject = data.mean.std$subject, 
                               label = data.mean.std$label),
                       mean)


# write the data for upload
write.table(format(aggr.data, scientific=TRUE), "tidy.txt",
            row.names=FALSE, col.names=FALSE, quote=2)
