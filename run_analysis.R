###Define some paths
dir.name="./UCI HAR Dataset/"
test.name="test"
train.name="train"

###Read the column names and choose the ones we want to retain
feature.names <- read.csv(paste0(dir.name,"features.txt"), header=FALSE, sep=" ")
vars <- feature.names[,2]
vars.not.ignore <- grep("(mean|std)(..)$", vars)

###Open the huge datasets. We only want the columns with means or standard deviations 
###(I'm not sure about what the assignment thinks about the directional means, I chose not to extract them)
###Anyway, what columns we want to extract is defined by the col.widths parameter
###The file is a fixed-width file with width 16
###By putting "-16" for all columns apart from the ones we want, we tell R to skip these unwanted columns
col.widths <- c(rep(-16, 561))
col.widths[vars.not.ignore]=16
test.data <- read.fwf(paste0(dir.name,test.name,'/X_',test.name, '.txt'), header=FALSE, widths=col.widths, col.names=vars[vars.not.ignore])
train.data <- read.fwf(paste0(dir.name,train.name,'/X_',train.name, '.txt'), header=FALSE, widths=col.widths, col.names=vars[vars.not.ignore])

###Open the activity and subject files, to merge them with the test and train data sets
test.activity <- read.csv(paste0(dir.name,test.name,'/y_',test.name, '.txt'), col.names="activity", header=FALSE)
test.subject <- read.csv(paste0(dir.name,test.name,'/subject_',test.name, '.txt'), col.names="subject", header=FALSE)
train.activity <- read.csv(paste0(dir.name,train.name,'/y_',train.name, '.txt'), col.names="activity", header=FALSE)
train.subject <- read.csv(paste0(dir.name,train.name,'/subject_',train.name, '.txt'), col.names="subject", header=FALSE)

###In the darkness bind them... /it's a Lord of the Rings reference~~
test.data <- cbind(test.subject, test.activity, test.data)
train.data <- cbind(train.subject, train.activity, train.data)
full.data <- rbind(test.data, train.data)

###Normalise variable names
library(rattle)
colnames(full.data) <- normVarNames(colnames(full.data))

###Relabel activity levels
map <- c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "lying")
full.data[,2] <- factor(map[as.factor(full.data[,2])], levels=map)

###Order the full table
library(plyr)
library(dplyr)
full.data <- arrange(full.data, full.data[,1])

###Create the second data set, which is supposed to contain the average of each variable for each activity and each subject
###Honestly, at this point, I was already a bit too tired to do it elegantly
summary.data <- data.frame()
full.data[,1] <- as.factor(full.data[,1])
no=1
for (i in levels(full.data[,1])){
  for (j in levels(full.data[,2])){
   temp<-full.data[full.data[,1]==i&full.data[,2]==j,] 
   if (nrow(temp)>0){   
    summary.data[no,1]=i
    summary.data[no,2]=j
    for (k in 3:length(colnames(full.data))){
      summary.data[no, k]=mean(full.data[full.data[,1]==i&full.data[,2]==j,k], na.rm=TRUE)
    }    
    no=no+1
   }
  }  
}
colnames(summary.data)<-c("subject", "activity", paste0("avg_", colnames(full.data)[3:length(colnames(full.data))]))

###Write down the final summary file
write.csv(summary.data, "ikorneta_summary_data.txt", row.names=FALSE)