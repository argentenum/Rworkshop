#creating list
marchList <- list(march, week)
#lists can have text and string vectors
#lists can have vectors of unequal lengths
str(marchList)
#finding length of list gives the number of columns
length(marchList)
#use unlist function to merge columns into single vector
unlist(marchList)
#index a vector
week[3]
week[2:4]
#index a list
marchList[1]
length(marchList)
length(marchList[1])
length(unlist(marchList))
#creating dataframe
marchFrame <- data.frame(march,week)
#vectors have to be of equal length
marchFrame <- data.frame(march[1:7],week)
str(marchFrame)
#indexing dataframe
marchFrame[2]
marchFrame$week
str(marchFrame[2])
length(marchFrame)
length(marchFrame[2])
length(marchFrame$week)
marchFrame[4,2]
names(marchFrame)
names(marchFrame) <- c("Order","Days of the Week")
rownames(marchFrame)
rownames(marchFrame) <- c("som","man","bud","gur",
                          "suk","sha","rav")
#Create a dataframe with the first column giving 
#the names of every month in a year and the second 
#column giving the corresponding number of days 
#in each month.