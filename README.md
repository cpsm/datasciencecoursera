Readme file to explain the code flow

step 1
Keep the files in the current working directory under test and train

Read the test file  into tables 
test.subject with column names "subject"
test.label with column name "label"
test.data 

Read the train files into tables
train.subject with column name "subject"
train.label   with column name "label"
train.data

step2
Add the test data using columan bind for test and train
Add the data into the row of data

step 3 
read the features file and get the mean and std
read label features and use this to replace  data labels
clean up label byremoving every non-alphabetic character
and converting to lowercase

step4
Get the mena for each subject and label from the data

wirte the data output to a file tidy.txt

