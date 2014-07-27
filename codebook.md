# CODEBOOK
July 27, 2014  
### About the data
Below is mainly taken and edited from the original data set README.txt

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walkingUpstairs, walkingDownstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the data captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain 

##### For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- Time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

##### Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

##### License

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


### run_analysis.R
Running the file 'run_analysis.R' will produce the following output:

```r
 source("run_analysis.R") 
```

```
## Creating a 'data' folder
## Downloading the data file and unzipping it
## Reading the data files
## Merging the data
## Extracting and cleaning 'mean' and 'standard deviation (std)' data
## Writing the data set to 'dataSetCleanedMergedMeanStd.txt'
## Tidying the data
## Writing the tidy data set to 'dataSetTidyAverage.txt'
```

##### 1. Merge the train and the test sets to one data set.
##### 2. Extract only the measurements on the mean and standard deviation for each measurement.

```r
  names(dataSetMeanStd)
```

```
##  [1] "subjectId"                                             
##  [2] "activityLabel"                                         
##  [3] "timeDomainBodyLinearAccelerationMeanX"                 
##  [4] "timeDomainBodyLinearAccelerationMeanY"                 
##  [5] "timeDomainBodyLinearAccelerationMeanZ"                 
##  [6] "timeDomainBodyLinearAccelerationStdX"                  
##  [7] "timeDomainBodyLinearAccelerationStdY"                  
##  [8] "timeDomainBodyLinearAccelerationStdZ"                  
##  [9] "timeDomainGravityLinearAccelerationMeanX"              
## [10] "timeDomainGravityLinearAccelerationMeanY"              
## [11] "timeDomainGravityLinearAccelerationMeanZ"              
## [12] "timeDomainGravityLinearAccelerationStdX"               
## [13] "timeDomainGravityLinearAccelerationStdY"               
## [14] "timeDomainGravityLinearAccelerationStdZ"               
## [15] "timeDomainBodyLinearAccelerationJerkMeanX"             
## [16] "timeDomainBodyLinearAccelerationJerkMeanY"             
## [17] "timeDomainBodyLinearAccelerationJerkMeanZ"             
## [18] "timeDomainBodyLinearAccelerationJerkStdX"              
## [19] "timeDomainBodyLinearAccelerationJerkStdY"              
## [20] "timeDomainBodyLinearAccelerationJerkStdZ"              
## [21] "timeDomainBodyAngularVelocityMeanX"                    
## [22] "timeDomainBodyAngularVelocityMeanY"                    
## [23] "timeDomainBodyAngularVelocityMeanZ"                    
## [24] "timeDomainBodyAngularVelocityStdX"                     
## [25] "timeDomainBodyAngularVelocityStdY"                     
## [26] "timeDomainBodyAngularVelocityStdZ"                     
## [27] "timeDomainBodyAngularVelocityJerkMeanX"                
## [28] "timeDomainBodyAngularVelocityJerkMeanY"                
## [29] "timeDomainBodyAngularVelocityJerkMeanZ"                
## [30] "timeDomainBodyAngularVelocityJerkStdX"                 
## [31] "timeDomainBodyAngularVelocityJerkStdY"                 
## [32] "timeDomainBodyAngularVelocityJerkStdZ"                 
## [33] "timeDomainBodyLinearAccelerationMagnitudeMean"         
## [34] "timeDomainBodyLinearAccelerationMagnitudeStd"          
## [35] "timeDomainGravityLinearAccelerationMagnitudeMean"      
## [36] "timeDomainGravityLinearAccelerationMagnitudeStd"       
## [37] "timeDomainBodyLinearAccelerationJerkMagnitudeMean"     
## [38] "timeDomainBodyLinearAccelerationJerkMagnitudeStd"      
## [39] "timeDomainBodyAngularVelocityMagnitudeMean"            
## [40] "timeDomainBodyAngularVelocityMagnitudeStd"             
## [41] "timeDomainBodyAngularVelocityJerkMagnitudeMean"        
## [42] "timeDomainBodyAngularVelocityJerkMagnitudeStd"         
## [43] "frequencyDomainBodyLinearAccelerationMeanX"            
## [44] "frequencyDomainBodyLinearAccelerationMeanY"            
## [45] "frequencyDomainBodyLinearAccelerationMeanZ"            
## [46] "frequencyDomainBodyLinearAccelerationStdX"             
## [47] "frequencyDomainBodyLinearAccelerationStdY"             
## [48] "frequencyDomainBodyLinearAccelerationStdZ"             
## [49] "frequencyDomainBodyLinearAccelerationJerkMeanX"        
## [50] "frequencyDomainBodyLinearAccelerationJerkMeanY"        
## [51] "frequencyDomainBodyLinearAccelerationJerkMeanZ"        
## [52] "frequencyDomainBodyLinearAccelerationJerkStdX"         
## [53] "frequencyDomainBodyLinearAccelerationJerkStdY"         
## [54] "frequencyDomainBodyLinearAccelerationJerkStdZ"         
## [55] "frequencyDomainBodyAngularVelocityMeanX"               
## [56] "frequencyDomainBodyAngularVelocityMeanY"               
## [57] "frequencyDomainBodyAngularVelocityMeanZ"               
## [58] "frequencyDomainBodyAngularVelocityStdX"                
## [59] "frequencyDomainBodyAngularVelocityStdY"                
## [60] "frequencyDomainBodyAngularVelocityStdZ"                
## [61] "frequencyDomainBodyLinearAccelerationMagnitudeMean"    
## [62] "frequencyDomainBodyLinearAccelerationMagnitudeStd"     
## [63] "frequencyDomainBodyLinearAccelerationJerkMagnitudeMean"
## [64] "frequencyDomainBodyLinearAccelerationJerkMagnitudeStd" 
## [65] "frequencyDomainBodyAngularVelocityMagnitudeMean"       
## [66] "frequencyDomainBodyAngularVelocityMagnitudeStd"        
## [67] "frequencyDomainBodyAngularVelocityJerkMagnitudeMean"   
## [68] "frequencyDomainBodyAngularVelocityJerkMagnitudeStd"
```
##### 3. Use descriptive activity names to name the activities in the data set.

```r
  unique(dataSetMeanStd$activityLabel)
```

```
## [1] "walking"           "walkingUpstairs"   "walkingDownstairs"
## [4] "sitting"           "standing"          "laying"
```

##### 4. Appropriately label the data set with descriptive variable names and create the file 'dataSetCleanedMergedMeanStd.txt'
##### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject and create the file 'dataSetTidyAverage.txt'
