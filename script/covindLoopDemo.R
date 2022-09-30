covidRaw <- read.csv("https://web.iitd.ac.in/~arjunghosh/RworkshopFiles/covidData.csv")
datesFormatted <- as.Date(covidRaw$Date.Announced, tryFormats = "%d/%m/%Y")
datesFullRange <- as.Date(min(datesFormatted):max(datesFormatted), origin = "1970-01-01")
statesList <- sort(unique(covidRaw$Detected.State))
covidDaily <- data.frame("Date" = datesFormatted, "State" = covidRaw$Detected.State)
#creating an empty dataframe with states as rows and dates as columns
#creating a vector with zero values for length(statesList)*length(datesFullRange)
BlankVec <- NULL
BlankVec[1:(length(statesList)*length(datesFullRange))] <- 0
BlankMatrix <- matrix(BlankVec, nrow= length(statesList), ncol = length(datesFullRange))
#transforming BlankMatrix to dataframe
BlankDF <- as.data.frame(BlankMatrix)
#naming the rows as states and columns as dates
names(BlankDF) <- datesFullRange
rownames(BlankDF) <- statesList
for (DIN in 1:length(datesFullRange)) {
  for (RAJ in 1:length(statesList)){
    Ginti <- sum(covidDaily$Date == as.Date(datesFullRange[DIN], tryFormats = "%Y-%m-%d", "1970-01-01") & 
                   covidDaily$State == statesList[RAJ])
    BlankDF[RAJ,DIN] <- Ginti
  }
}
