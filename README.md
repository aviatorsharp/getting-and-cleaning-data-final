##Human Activity Recognition Using Smartphones Dataset

There is only one script for analysis (run_analysis.R) and it works as follows

###Ordered list of operations performed on raw data (run_analysis.R):
1.      Data is imported into R
2.      A logical vector (featureslogical) is created that returns TRUE for columns 
        that have either "mean()" or "sd()" in their name. This vector is 
        applied to the columns of the test and train datasets.
3.      The integer values of test_y and train_y are replaced with the corresponding
        character values from the activity_labels character vector.
4.      Various components of test and train data (X, Y and subject) are merged
        to create single train and test data frames.
5.      subject and Y varibles in each set were renamed to more descriptive names.
6.      train and test sets are combined.
7.      A dataframe containing the means of each column for each subject and 
        activity is created.
8.      Both dataframes are saved to new "tidy" folder.

