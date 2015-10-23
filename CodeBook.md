---
title: "Tidy Data Set Codebook"
author: "John Mitchell"
date: "October 23rd, 2015"
output:
  html_document:
    keep_md: yes
---

## Project Description
This project was to take a large set of data (used to match the sensor signals from a smartphone accerlerometer and gyroscope to physical activities) and condense that data to just averages of certain variables (only those related to mean() or std()) by subject and activity.

##Study design and data processing (from original source)
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

###Collection of the raw data (from original source)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

###Notes on the original (raw) data 
The original feature list was not in alignment with tidy data principles and contained errors. In addition to condensing the data to just values of means and standard deviations (std) I have cleaned the variable names to match tidy data principles.

##Creating the tidy datafile

###Guide to create the tidy data file
1. download the data
2.  set the working directory to be the "UCI HAR Dataset" folder.
3.  Run the run_analysis.R file, which will clean the data and produce the .txt file of the tidy data

###Cleaning of the data
1. The cleaning file does the following:
2. Reads in the feature names
3. Reads in the data for the activity labels, the subjects, and feature data
4. Binds together the 3 sets (subject, activity, and measurements)
5. Binds together the test and train sets of data
6. Subsets only measurements that include mean or std measurements
7. Applies names to activities (like "walking", "laying", etc)
8. Cleans up measurement labels
9. Groups and summarizes all measurements by Subject (1 - 6) and activity


. [link to the readme document that describes the code in greater detail]()

##Description of the variables in the tiny_data.txt file

###Variable 1
The subject whose movement was tracked. This is an integer between 1:30 identifying the individual.

###Variable 2
The label for the activity. This was created by matching data to a video of the subject. There are six possible activies. This variable is a character with one of the following values:
* Sitting
* Standing
* Walking
* Walking Upstairs
* Walking Downstairs
* Laying

### Variables 3-81
Variables 3-81 are averages of all values that included either a mean or standard deviation measurement. These averages are labeled descriptively according to their measurement (time or frequency, body or gravity, gyroscope or acceleromter, jerking or jerking magnitude)  and plane of measurement (x, y, or z).

These variables follow this convention:
- Features are normalized and bounded within [-1,1]. 
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2). 
- The gyroscope units are rad/seg. 


### List of all 81 variables
 [1] "subject"                                                    
 [2] "activities"                                                 
 [3] "timebodyaccelerometermeanx"                                 
 [4] "timebodyaccelerometermeany"                                 
 [5] "timebodyaccelerometermeanz"                                 
 [6] "timegravityaccelerometermeanx"                              
 [7] "timegravityaccelerometermeany"                              
 [8] "timegravityaccelerometermeanz"                              
 [9] "timebodyaccelerometerjerkingmeanx"                          
[10] "timebodyaccelerometerjerkingmeany"                          
[11] "timebodyaccelerometerjerkingmeanz"                          
[12] "timebodygyroscopemeanx"                                     
[13] "timebodygyroscopemeany"                                     
[14] "timebodygyroscopemeanz"                                     
[15] "timebodygyroscopejerkingmeanx"                              
[16] "timebodygyroscopejerkingmeany"                              
[17] "timebodygyroscopejerkingmeanz"                              
[18] "timebodyaccelerometermagnitudemean"                         
[19] "timegravityaccelerometermagnitudemean"                      
[20] "timebodyaccelerometerjerkingmagnitudemean"                  
[21] "timebodygyroscopemagnitudemean"                             
[22] "timebodygyroscopejerkingmagnitudemean"                      
[23] "frequencybodyaccelerometermeanx"                            
[24] "frequencybodyaccelerometermeany"                            
[25] "frequencybodyaccelerometermeanz"                            
[26] "frequencybodyaccelerometermeanfrequencyx"                   
[27] "frequencybodyaccelerometermeanfrequencyy"                   
[28] "frequencybodyaccelerometermeanfrequencyz"                   
[29] "frequencybodyaccelerometerjerkingmeanx"                     
[30] "frequencybodyaccelerometerjerkingmeany"                     
[31] "frequencybodyaccelerometerjerkingmeanz"                     
[32] "frequencybodyaccelerometerjerkingmeanfrequencyx"            
[33] "frequencybodyaccelerometerjerkingmeanfrequencyy"            
[34] "frequencybodyaccelerometerjerkingmeanfrequencyz"            
[35] "frequencybodygyroscopemeanx"                                
[36] "frequencybodygyroscopemeany"                                
[37] "frequencybodygyroscopemeanz"                                
[38] "frequencybodygyroscopemeanfrequencyx"                       
[39] "frequencybodygyroscopemeanfrequencyy"                       
[40] "frequencybodygyroscopemeanfrequencyz"                       
[41] "frequencybodyaccelerometermagnitudemean"                    
[42] "frequencybodyaccelerometermagnitudemeanfrequency"           
[43] "frequencybodyaccelerometerjerkingmagnitudemean"             
[44] "frequencybodyaccelerometerjerkingmagnitudemeanfrequency"    
[45] "frequencybodygyroscopemagnitudemean"                        
[46] "frequencybodygyroscopemagnitudemeanfrequency"               
[47] "frequencybodygyroscopejerkingmagnitudemean"                 
[48] "frequencybodygyroscopejerkingmagnitudemeanfrequency"        
[49] "timebodyaccelerometerstandarddeviationx"                    
[50] "timebodyaccelerometerstandarddeviationy"                    
[51] "timebodyaccelerometerstandarddeviationz"                    
[52] "timegravityaccelerometerstandarddeviationx"                 
[53] "timegravityaccelerometerstandarddeviationy"                 
[54] "timegravityaccelerometerstandarddeviationz"                 
[55] "timebodyaccelerometerjerkingstandarddeviationx"             
[56] "timebodyaccelerometerjerkingstandarddeviationy"             
[57] "timebodyaccelerometerjerkingstandarddeviationz"             
[58] "timebodygyroscopestandarddeviationx"                        
[59] "timebodygyroscopestandarddeviationy"                        
[60] "timebodygyroscopestandarddeviationz"                        
[61] "timebodygyroscopejerkingstandarddeviationx"                 
[62] "timebodygyroscopejerkingstandarddeviationy"                 
[63] "timebodygyroscopejerkingstandarddeviationz"                 
[64] "timebodyaccelerometermagnitudestandarddeviation"            
[65] "timegravityaccelerometermagnitudestandarddeviation"         
[66] "timebodyaccelerometerjerkingmagnitudestandarddeviation"     
[67] "timebodygyroscopemagnitudestandarddeviation"                
[68] "timebodygyroscopejerkingmagnitudestandarddeviation"         
[69] "frequencybodyaccelerometerstandarddeviationx"               
[70] "frequencybodyaccelerometerstandarddeviationy"               
[71] "frequencybodyaccelerometerstandarddeviationz"               
[72] "frequencybodyaccelerometerjerkingstandarddeviationx"        
[73] "frequencybodyaccelerometerjerkingstandarddeviationy"        
[74] "frequencybodyaccelerometerjerkingstandarddeviationz"        
[75] "frequencybodygyroscopestandarddeviationx"                   
[76] "frequencybodygyroscopestandarddeviationy"                   
[77] "frequencybodygyroscopestandarddeviationz"                   
[78] "frequencybodyaccelerometermagnitudestandarddeviation"       
[79] "frequencybodyaccelerometerjerkingmagnitudestandarddeviation"
[80] "frequencybodygyroscopemagnitudestandarddeviation"           
[81] "frequencybodygyroscopejerkingmagnitudestandarddeviation"   

##Sources
Data comes from UCI website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Codebook template is from Joris Schut: https://gist.githubusercontent.com/JorisSchut/dbc1fc0402f28cad9b41/raw/a6a85a5a9bbdbc48609cd74dd25e3178a087e4e1/gistfile1.rmd
