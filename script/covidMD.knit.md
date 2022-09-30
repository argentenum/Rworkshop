---
title: "covid daily statewise"
author: "arjun"
date: "2022-09-30"
output: html_document
---



## Preparing data table for plotting daily covid cases Statewise

We access the data containing details of each covid cases in India.


```r
covidRaw <- read.csv("https://web.iitd.ac.in/~arjunghosh/RworkshopFiles/covidData.csv")
```

The read.csv function imports the .csv file and structures it in a data.frame format.

Let us look at what are the various data headers in the dataset.


```r
names(covidRaw)
```

```
##  [1] "Patient.Number"                           
##  [2] "State.Patient.Number"                     
##  [3] "Date.Announced"                           
##  [4] "Age.Bracket"                              
##  [5] "Gender"                                   
##  [6] "Detected.City"                            
##  [7] "Detected.District"                        
##  [8] "Detected.State"                           
##  [9] "Current.Status"                           
## [10] "Notes"                                    
## [11] "Contracted.from.which.Patient..Suspected."
## [12] "Nationality"                              
## [13] "Type.of.transmission"                     
## [14] "Status.Change.Date"                       
## [15] "Source_1"                                 
## [16] "Source_2"                                 
## [17] "Source_3"                                 
## [18] "Backup.Notes"
```

We want to plot a chart showing the daily case number reported from each state. To do so we need to reorganise the covidRaw dataframe to a new dataframe that has all the states as rows and all the dates as columns. In fine, we want our dataset to look like this:

![](images/Screenshot%20(1).png)

As you can see for this exercise we only need the data from two columns - "Date.Announced" and "Detected.State". First let us develop the list of states.


```r
unique(covidRaw$Detected.State)
```

```
##  [1] "Kerala"                      "Delhi"                      
##  [3] "Telangana"                   "Rajasthan"                  
##  [5] "Haryana"                     "Uttar Pradesh"              
##  [7] "Ladakh"                      "Tamil Nadu"                 
##  [9] "Jammu and Kashmir"           "Karnataka"                  
## [11] "Maharashtra"                 "Punjab"                     
## [13] "Andhra Pradesh"              "Uttarakhand"                
## [15] "Odisha"                      "Puducherry"                 
## [17] "West Bengal"                 "Chandigarh"                 
## [19] "Chhattisgarh"                "Gujarat"                    
## [21] "Himachal Pradesh"            "Madhya Pradesh"             
## [23] "Bihar"                       "Manipur"                    
## [25] "Mizoram"                     "Goa"                        
## [27] "Andaman and Nicobar Islands" "Jharkhand"                  
## [29] "Assam"
```

Let us sort the names of the states alphabetically and assign them to a vector.


```r
statesList <- sort(unique(covidRaw$Detected.State))
```

Now let us take a closer look at the dates.


```r
unique(covidRaw$Date.Announced)
```

```
##  [1] "30/01/2020" "02/02/2020" "03/02/2020" "02/03/2020" "03/03/2020"
##  [6] "04/03/2020" "05/03/2020" "06/03/2020" "07/03/2020" "08/03/2020"
## [11] "09/03/2020" "10/03/2020" "11/03/2020" "12/03/2020" "13/03/2020"
## [16] "14/03/2020" "15/03/2020" "16/03/2020" "17/03/2020" "18/03/2020"
## [21] "19/03/2020" "20/03/2020" "21/03/2020" "22/03/2020" "23/03/2020"
## [26] "24/03/2020" "25/03/2020" "26/03/2020" "27/03/2020" "28/03/2020"
## [31] "29/03/2020" "30/03/2020" "31/03/2020" "01/04/2020"
```

```r
str(covidRaw$Date.Announced)
```

```
##  chr [1:1750] "30/01/2020" "02/02/2020" "03/02/2020" "02/03/2020" ...
```

As we can see, the dates - at least at the beginning of the covid onset were not continuous. If plotted it would give a false impression that the rise was continuous. So we need to ensure that continuity of time is maintained. The dates are formatted as characters. We need to convert them to dates. And then we need to create a date vector for the full range of dates.


```r
datesFormatted <- as.Date(covidRaw$Date.Announced, tryFormats = "%d/%m/%Y")
datesFullRange <- as.Date(min(datesFormatted):max(datesFormatted), origin = "1970-01-01")
datesFullRange
```

```
##  [1] "2020-01-30" "2020-01-31" "2020-02-01" "2020-02-02" "2020-02-03"
##  [6] "2020-02-04" "2020-02-05" "2020-02-06" "2020-02-07" "2020-02-08"
## [11] "2020-02-09" "2020-02-10" "2020-02-11" "2020-02-12" "2020-02-13"
## [16] "2020-02-14" "2020-02-15" "2020-02-16" "2020-02-17" "2020-02-18"
## [21] "2020-02-19" "2020-02-20" "2020-02-21" "2020-02-22" "2020-02-23"
## [26] "2020-02-24" "2020-02-25" "2020-02-26" "2020-02-27" "2020-02-28"
## [31] "2020-02-29" "2020-03-01" "2020-03-02" "2020-03-03" "2020-03-04"
## [36] "2020-03-05" "2020-03-06" "2020-03-07" "2020-03-08" "2020-03-09"
## [41] "2020-03-10" "2020-03-11" "2020-03-12" "2020-03-13" "2020-03-14"
## [46] "2020-03-15" "2020-03-16" "2020-03-17" "2020-03-18" "2020-03-19"
## [51] "2020-03-20" "2020-03-21" "2020-03-22" "2020-03-23" "2020-03-24"
## [56] "2020-03-25" "2020-03-26" "2020-03-27" "2020-03-28" "2020-03-29"
## [61] "2020-03-30" "2020-03-31" "2020-04-01"
```

Now we see that all dates for the entire range of two months are represented even those dates that are not there in the covidRaw since no cases were reported on those days. In reality the covid count for all states on these dates would be zero.

Let us now write the dates and states to a new dataframe.


```r
covidDaily <- data.frame("Date" = datesFormatted, "State" = covidRaw$Detected.State)
```

## Preparing empty dataframe

We need to prepare an empty dataframe with the dates as columns and states as rows. At present all values will be zero. Later we will populate the each value after calculating the number of values that we find in each intersection of row and column name. To do this we follow these steps:

-   create a vector with zero values for length(statesList)\*length(datesFullRange)

-   convert the vector to a matrix of the number of columns equal to the number of days and the number of rows matching the number of states

-   convert the matrix to a dataframe


```r
BlankVec <- NULL
BlankVec[1:(length(statesList)*length(datesFullRange))] <- 0
BlankMatrix <- matrix(BlankVec, nrow= length(statesList), ncol = length(datesFullRange))
#transforming BlankMatrix to dataframe
BlankDF <- as.data.frame(BlankMatrix)
#naming the rows as states and columns as dates
names(BlankDF) <- datesFullRange
rownames(BlankDF) <- statesList
head(BlankDF)
```

```
##                             2020-01-30 2020-01-31 2020-02-01 2020-02-02
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-02-03 2020-02-04 2020-02-05 2020-02-06
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-02-07 2020-02-08 2020-02-09 2020-02-10
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-02-11 2020-02-12 2020-02-13 2020-02-14
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-02-15 2020-02-16 2020-02-17 2020-02-18
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-02-19 2020-02-20 2020-02-21 2020-02-22
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-02-23 2020-02-24 2020-02-25 2020-02-26
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-02-27 2020-02-28 2020-02-29 2020-03-01
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-03-02 2020-03-03 2020-03-04 2020-03-05
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-03-06 2020-03-07 2020-03-08 2020-03-09
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-03-10 2020-03-11 2020-03-12 2020-03-13
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-03-14 2020-03-15 2020-03-16 2020-03-17
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-03-18 2020-03-19 2020-03-20 2020-03-21
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-03-22 2020-03-23 2020-03-24 2020-03-25
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-03-26 2020-03-27 2020-03-28 2020-03-29
## Andaman and Nicobar Islands          0          0          0          0
## Andhra Pradesh                       0          0          0          0
## Assam                                0          0          0          0
## Bihar                                0          0          0          0
## Chandigarh                           0          0          0          0
## Chhattisgarh                         0          0          0          0
##                             2020-03-30 2020-03-31 2020-04-01
## Andaman and Nicobar Islands          0          0          0
## Andhra Pradesh                       0          0          0
## Assam                                0          0          0
## Bihar                                0          0          0
## Chandigarh                           0          0          0
## Chhattisgarh                         0          0          0
```

## Looping the loop

Now we will replace the zeros with the count of rows from covidRaw where the "Dates" match the column name (datesFullRange) and "States" match the rowname (statesList).


```r
for (DIN in 1:length(datesFullRange)) {
  for (RAJ in 1:length(statesList)){
    Ginti <- sum(covidDaily$Date == as.Date(datesFullRange[DIN], tryFormats = "%Y-%m-%d", "1970-01-01") & 
                   covidDaily$State == statesList[RAJ])
    BlankDF[RAJ,DIN] <- Ginti
  }
}
```

What did we do here?

-   We created two loops

    -   Outer loop: The variable DIN loops through the indices of the datesFullRange

    -   Inner loop: The variable RAJ loops through the indices of the statesList

    -   In the inner core of the two loops "Ginti" fetches the count of rows where **covidDaily\$Date == as.Date(datesFullRange[DIN]** and **covidDaily\$State == statesList[RAJ]**

Note each time we have to call the function **as.Date** as R stores dates as a numeric value.

Now that BlankDF is not blank anymore, should we rename it?

## 
