#setwd("C:/Users/DELL/Dropbox/Arjun/02-research/digital-humanities/workshops/Rworkshop/")
library(tm)
src <- DirSource("./data/corpus")
docs <- Corpus(src)
#inspect(docs)
#docs$content
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, c(stopwords("english")))
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming (reduces words to their root form)
# Remove additional stopwords
docs <- tm_map(docs, removeWords, c("disco0", "disco1", "disco2"))
library(SnowballC)
docs <- tm_map(docs, stemDocument)
#creating document term matrix
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
# Generate the WordCloud
library(wordcloud)
#contains library(RColorBrewer)
# http://applied-r.com/rcolorbrewer-palettes/#
#par(bg="white")
#png(file="WordCloud.png",width=1000,height=700, bg="grey30")
#wordcloud(d$word, d$freq, col=terrain.colors(length(d$word), alpha=0.9), random.order=FALSE, rot.per=0.3 )
wordcloud(words = d$word, 
          freq = d$freq,
          min.freq = 1, 
          max.words = 200,
          random.order = FALSE, 
          rot.per = 0.35, 
          colors = brewer.pal(8, "Dark2"))
#title(main = "Opening Lines of Pride and Prejudice", font.main = 1, col.main = "cornsilk3", cex.main = 1.5)
#dev.off()
