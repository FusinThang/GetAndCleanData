GetAndCleanData Course Project

===============

HOW TO USE ? 
  - Open your Terminal and go to your working directory, then clone this reposity by command: git clone git@github.com:FusinThang/GetAndCleanData.git

  - Go to the folder you just finish cloning, set that as your working directory in your R machine.

  - Download the data from here: "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"

  - Extract the data to your working directory.

  - Open R machine and load the "run_analysis.R" script into R and run it.

WHAT DO THE SCRIPTS DO ?
  - It should check for the data in your working directory and download file if needed. It may take a several minutes...

  - After checking for data existing, it will read all the needed data from "test data set" and "train data set". Then merge them together to make raw data.

  - Change the variables' name

  - Filtering out the variables that was not the measurements on the mean and standard deviation. Save the raw data to "raw_data.txt"

  - Get average for each activity. Save the result to "activity_result.txt"

  - Get average for each subject. Save the result to "subject_result.txt"

  - Merge all results together and make the tidy data set. Save the tidy data to "final_result.txt"

  That all!
  I'm not very sure about this project and have less time on it, so if there are anything wrong here, please feel free to comment on the evaluation/feedback.
  Thanks for reviewing it!