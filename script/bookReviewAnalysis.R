setwd("~/Downloads")
reviewsDF <- read.csv("bookreviewData.csv", stringsAsFactors = FALSE)
reviewsDF$Year <- as.numeric(substr(reviewsDF$Year,12,15))
bookCount <- NULL
minYear <- NULL
meanPrice <- NULL
for (pub in 1:length(uniquePub))
{
  pubDF <- reviewsDF[which(reviewsDF$Publisher == uniquePub[pub]),]
  uniquePub[pub] <- substr(uniquePub[pub],17,(nchar(uniquePub[pub])))
  bookCount[pub] <- length(pubDF$Publisher)
  minYear[pub] <- min(pubDF$Year, na.rm = TRUE)
  meanPrice[pub] <- mean(as.numeric(substr(reviewsDF$Price[pub],12,nchar(reviewsDF$Price[pub]))), na.rm = TRUE)
}
reviewSummary <- data.frame(uniquePub,bookCount,minYear,meanPrice)
names(reviewSummary) <- c("Publisher","No. of Books","Earliest Year","Average Price")
reviewSummary

#dplyr
library(dplyr)
"books" %>% nchar
c(5,8,11) %>% mean
c(5,8,11) %>% min
result <- NULL
reviewsDF %>% select(Publisher,Year,Price) %>% filter(Year == 1988) %>% assign("result", ., inherits = TRUE)
