courseragetcleandata
====================
This file is the README for my entry into the Course Project of the Coursera "Getting and Cleaning Data" course, Aug 2014 edition. In accordance with the project requirements, it explains how the data in the tidy set in the main directory of the master branch of this repo ("ikorneta_summary_data.txt") were obtained using the script also available in said directory ("run_analysis.R").

##Initial data
* The initial data were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
* The codebook for the initial data is at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
* Citation: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


##The script
The script has comments throughout it, so I hope that you can follow the code. :-)
* It reads the "features.txt" file to get the column names. Using grep, it selects only the column names we are interested in - those that describe the means and standard deviations for each measurement (=end in -mean() or -std()). I'm not sure about the directional measurements, but if it turns out they are needed, it's a matter of altering the grep statement.
* It opens the train and test datasets and extracts only the columns we want, using the "widths" variable of the read.fwf function.
* It opens the files containing data on subjects and activities, and adds their contents to the extracted train and test datasets. Then, it combines the extracted train and test datasets.
* It then does some housekeeping using the rattle and plyr/dplyr libraries:
  * normalises variable names inside the dataset to be lowercase and with underscores (_) instead of periods (.);
  * rearranges the data in the order of the "subjects" (the identifiers in the "subject" variable);
  * relabels the activity levels.
* Finally, it creates the summary file: a second, independent tidy data set with the average of each variable for each activity and each subject.


##The codebook for the "ikorneta_summary_data.txt" file.
There are 20 variables in this file:
* subject - identifies the subject/user who was tested in the experiment. Originally in the "subject_test.txt"/"subject_train.txt" files;
* activity - identifies the activity, originally in the "y_test.txt"/"y_train.txt" files;
* 18 variables with the format "avg_"X. These are average values of the original variables for the subject in the subject column and the activity in the activity column.

The variable names have been normalised in accordance with the rules set in http://handsondatascience.com/StyleO.pdf : all lowercase, with underscores. Apart from the normalisation, I chose to retain the original names. That's for a very good reason, in that I'm not a physics person, and they don't mean very much to me either way. So, apart from the avg_ at the beginning, other parts of the explanation of the variable names follow directly from the original codebook.

So, a variable name such as "avg_t_body_acc_mag_std" can be decoded as average (avg_; added by me) of the measurements of the standard deviations (_std) of the body acceleration (_body_acc_) magnitude (calculated using the Euclidean norm) (_mag_), which is a measurement that belongs to the time (_t_) domain. And, well, it's not directional, given the lack of -X,-Y or -Z at the end.
