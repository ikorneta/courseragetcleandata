##Codebook for the "ikorneta_summary_data.txt" file (copied from README.md).
There are 20 variables in this file:
* subject - identifies the subject/user who was tested in the experiment. Originally in the "subject_test.txt"/"subject_train.txt" files;
* activity - identifies the activity, originally in the "y_test.txt"/"y_train.txt" files;
* 18 variables with the format "avg_"X. These are average values of the original variables for the subject in the subject column and the activity in the activity column.

The variable names have been normalised in accordance with the rules set in http://handsondatascience.com/StyleO.pdf : all lowercase, with underscores. Apart from the normalisation, I chose to retain the original names. That's for a very good reason, in that I'm not a physics person, and they don't mean very much to me either way. So, apart from the avg_ at the beginning, other parts of the explanation of the variable names follow directly from the original codebook.

So, a variable name such as "avg_t_body_acc_mag_std" can be decoded as average (avg_; added by me) of the measurements of the standard deviations (_std) of the body acceleration (_body_acc_) magnitude (calculated using the Euclidean norm) (_mag_), which is a measurement that belongs to the time (_t_) domain. And, well, it's not directional, given the lack of -X,-Y or -Z at the end.
