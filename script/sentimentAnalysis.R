#generating custom functions
funcofx <- function(x){x+1}
funcofx(10)
funcofy <- function(y){
  paste(y, "is the phrase", sep = " ")
}
funcofy("expecto petronum")
library(sentimentr)
sentiment("The queen is dead. Long live the king")
extract_sentiment_terms("The queen is dead. Long live the king")
emotion("The queen is dead. Long live the king")
sampleText <- readLines("./data/corpus/1836MrPickwickChristmas.txt")
senti <- sentiment(get_sentences(sampleText))
senti <- subset(senti,senti$sentiment!=0) #get rid of emotions non-existent in the text
densitySentiments <- density(senti$sentiment) #get statistics on the sentiments
plot(densitySentiments,main='Density of sentiments')
polygon(densitySentiments,col='dark green')
#creating a function of the above steps
makeSentiPlot <- function(txt){
  senti <- sentiment(get_sentences(txt))
  senti <- subset(senti,senti$sentiment!=0)
  densitySentiments <- density(senti$sentiment) 
  plot(densitySentiments,main='Density of sentiments')
  polygon(densitySentiments,col='dark green')
}
makeSentiPlot(sampleText)
#plotting emotions
emoti <- emotion_by(get_sentences(sampleText), drop.unused.emotions=TRUE)
plot(emoti) #gives variations of individual emotions in a given piece of text
#make a barplot of different emotions 
library(dplyr)
sampleText %>%
  get_sentences() %>%
  emotion_by(drop.unused.emotions=TRUE) %>%
  group_by(emotion_type)  %>%
  summarise(ave_emotion=mean(ave_emotion)) -> txtSummary
barplot(txtSummary$ave_emotion,
        names.arg = txtSummary$emotion_type, las=2, col='red')
