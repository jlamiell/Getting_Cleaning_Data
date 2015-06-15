# Code Book

30 volunteers performed 6 activities while wearing a smartphone. The smartphone captured movement data.

## Original data files:

* features.txt: 561 feature names
* activity_labels.txt: IDs and names for the 6 activities
* X_train.txt: 7352 observations of the 561 features for 21 of the 30 volunteers
* subject_train.txt: 7352 integer volunteer IDs for each of the X_train.txt observations
* y_train.txt: 7352 integer activity IDs for each of the X_train.txt observations
* X_test.txt: 2947 observations of the 561 features for 9 of the 30 volunteers
* subject_test.txt: 2947 integer volunteer IDs for each of the X_train.txt observations
* y_test.txt: 2947 integer activity IDs for each of the X_train.txt observations

Analysis was performed using only the files above, so the data files in the "Inertial Signals" folders were ignored.

## Processing steps:

* Data files were read into data frames, column headers were added, and training and test sets were combined into one data set
* Feature columns that did not contain the exact string "mean()" or "std()" were removed, leaving 66 feature columns
* The tidy data set contains the mean of each of 66 features for each of 30 subjects and each of 6 activities
* The tidy data set was output to tidy_data.txt
