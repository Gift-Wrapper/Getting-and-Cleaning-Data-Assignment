`run_analysis.R` is a script that performs the preparation and cleaning
of data as instructed in the Week 4 Coursera Assignment. The data sets
for the assignment were installed and extracted manually to the
`UCI HAR Dataset` folder inside the working directory.

The steps taken by `run_analysis.R` are as follows:

1.  **Opening the `dplyr` package**

2.  **Assigning variables to the “training” and “test” data sets**

-   `features` &lt;- `features.txt`: 561 rows, 2 columns
-   `activities` &lt;- `activity_labels.txt`: 6 rows, 2 columns *The
    list of activities performed when the corresponding measurements
    were taken*
-   `subject_test` &lt;- `test/subject_test.txt`: 2947 rows, 1 column
    *contains test data of 9 of the 30 observed subjects*
-   `x_test` &lt;- `test/X_test.txt`: 2947 rows, 561 columns
-   `y_test` &lt;- `test/y_test.txt`: 2947 rows, 1 column
-   `subject_train` &lt;- `test/subject_train.txt`: 7352 rows, 1 column
    *contains train data of the other 21/30 observed subjects*
-   `x_train` &lt;- `test/X_train.txt`: 7352 rows, 561 columns
-   `y_train` &lt;- `test/y_train.txt`: 7352 rows, 1 column

1.  **Merging the “test” and “training” data sets**

-   `X` (10299 rows, 561 columns) made by merging `x_test` and `x_train`
    using *rbind()* function
-   `Y` (10299 rows, 1 column) made by merging `y_test` and `y_train`
    using *rbind()* function
-   `Subject` (10299 rows, 1 column) made by merging `subject_test` and
    `subject_train` using *rbind()* function
-   `MergeDF` (10299 rows, 563 columns) made by merging `Subject`, `X`,
    and `Y` using the *cbind()* function

1.  **Extracting the means and standard deviations of each measurement**

-   `TidyDF` is made by subsetting `MergeDF` and selecting only columns
    that had `subject`, `code`, and that contained `mean` or
    `std`(standard deviation)

1.  **Labelling data set with descriptive variable names**

-   `code` column renamed to `activities`
-   All `Acc` in column names substituted with `Accelerometer`
-   All `Gyro` in column names substituted with `Gyroscope`
-   All `BodyBody` in column names substituted with `Body`
-   All `Mag` in column names substituted with `Magnitude`
-   Anytime a column’s name started with `t` it was substituted by
    `Time`
-   Anytime a column’s name started with `f` it was substituted by
    `Frequency`

1.  **Creating an independent, tidy data set**

-   `CompleteDF` is made by summarizing `TidyDF`
-   `CompleteDF` is then exported to `CompleteDF.txt` text file
