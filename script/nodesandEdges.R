#http://humnviz.blogs.bucknell.edu/files/2015/11/Data-Preparation-for-Gephi.pdf
#https://gephi.org/tutorials/gephi-tutorial-quick_start.pdf
#https://seinecle.github.io/gephi-tutorials/generated-html/simple-project-from-a-to-z-en.html#_download_a_network_file
#https://libguides.brown.edu/gephi/home
#https://mdl.library.utoronto.ca/technology/tutorials/visualizing-network-dataset-using-gephi
imdbRaw <- readxl::read_xlsx("./data/imdbfilm.xlsx")
library(stringr)
#converting relevant values from character to numeric
ratingNum <- as.numeric(imdbRaw$rating)
#for rated by we need to watch out for figures like 1K 2K
ratedbyNum <- NULL
for (n in 1:nrow(imdbRaw)){
  if(is.na(regexpr("K",imdbRaw$`rated by`[n])[1])) {
    ratedbyNum[n] <- as.numeric(imdbRaw$`rated by`[n])
  }
  else {
    if((regexpr("K",imdbRaw$`rated by`[n])[1])>0){
      ratedbyNum[n] <- as.numeric(str_extract_all(imdbRaw$`rated by`[n],"[0-9.]+"))*1000
    }
    else {ratedbyNum[n] <- as.numeric(imdbRaw$`rated by`[n])}
  }
}
#same to be repeated for review count
reviewCountNum <- NULL
for (n in 1:nrow(imdbRaw)){
  if(is.na(regexpr("K",imdbRaw$`review count`[n])[1])) {
    reviewCountNum[n] <- as.numeric(imdbRaw$`review count`[n])
  }
  else {
    if((regexpr("K",imdbRaw$`review count`[n])[1])>0){
      reviewCountNum[n] <- as.numeric(str_extract_all(imdbRaw$`review count`[n],"[0-9.]+"))*1000
    }
    else {reviewCountNum[n] <- as.numeric(imdbRaw$`review count`[n])}
  }
}
countryofRelease <- unlist(str_extract_all(imdbRaw$`release date`,"(\\(.*?\\))"))
countryofRelease <- unlist(str_extract_all(countryofRelease,"(\\w)+(\\s)?(\\w)+(\\s)?(\\w)+"))
#countryofRelease <- unlist(str_extract_all(countryofRelease,"[a-zA-Z]{2,}"))
yearofRelease <- substr(imdbRaw$`release date`,1,(sapply(gregexpr("\\(",imdbRaw$`release date`), "[[", 1)-2))
yearofRelease <- as.numeric(substr(yearofRelease,(nchar(yearofRelease)-3),nchar(yearofRelease)))
library(readr)
grossNum <- parse_number(unlist(str_extract_all(imdbRaw$`gross worldwide`,"[0-9,]+")))
budgetCurrency <- substr(imdbRaw$budget,1,1)
budget <- parse_number(imdbRaw$budget)
imdbRaw <- data.frame(imdbRaw$`film link`,imdbRaw$`film link-href`,ratingNum,ratedbyNum,imdbRaw$runtime,imdbRaw$director,imdbRaw$`director-href`,
                    imdbRaw$writers,imdbRaw$`top cast`, imdbRaw$`top cast-href`, imdbRaw$genres, reviewCountNum,
                    yearofRelease,countryofRelease,imdbRaw$`production companies`,budgetCurrency,budget,grossNum)
names(imdbRaw) <- c("film link","film link-href","rating","rated by","runtime","director","director-href",
                    "writers","top cast","top cast-href","genres","review count",
                    "year of release","country of release","production companies","budget currency","budget","gross worldwide")
#this structure works for Palladio
write.csv(imdbRaw, file = "./output/imdb4palladio.csv", row.names = FALSE)
#preparing unique set of directors and director IDs
directorDF <- data.frame(imdbRaw[7],imdbRaw[6])
directorDF$director.href <- as.numeric(unlist(str_extract_all(directorDF$director.href,"[0-9]+")))
directorDF <- unique(directorDF)
directorDF <- na.omit(directorDF)
names(directorDF) <- c("Id","Label")
#preparing unique set of cast and cast IDs
castDF <- data.frame(imdbRaw[10],imdbRaw[9])
castDF$top.cast.href <- as.numeric(unlist(str_extract_all(substring(castDF$top.cast.href,1,45),"[0-9]+")))
castDF <- unique(castDF)
castDF <- na.omit(castDF)
names(castDF) <- c("Id","Label")
#preparing nodes table for Gephi
nodesDF <- rbind(directorDF,castDF)
#removing duplicate nodes arising from directors acting in their own films
nodesDF <- unique(nodesDF)
write.csv(nodesDF, file = "./output/nodes4gephi.csv", row.names = FALSE)
#preparing edges table for Gephi
#using looping the loop
edgesDF <- data.frame(matrix(ncol = 4, nrow = 0))
names(edgesDF) <- c("Source","Target","Type","Weight")
for (DIR in 1:nrow(directorDF)){
  edgeCount <- NULL
  for (CAST in 1:nrow(castDF)){
    edgeCount <- length(which(imdbRaw$director==directorDF$Label[DIR] & imdbRaw$`top cast`==castDF$Label[CAST]))
    if(edgeCount>0) {edgesDF <- rbind(edgesDF,c(directorDF$Id[DIR],castDF$Id[CAST],"Directed",edgeCount))}
  }
  print(DIR)
}
names(edgesDF) <- c("Source","Target","Type","Weight")
write.csv(edgesDF, file = "./output/edges4gephi.csv", row.names = FALSE)
#preparing enriched nodesDF for Gephi for better segmentation
#writing the average score of rating, rated by and gross worldwide for all nodes by average of all the films mentioned
#before that replace all NAs in ratingNum, ratedbyNum and groassNum with zero so that it does not affect the mean
for (m in 1:nrow(imdbRaw)){
  if(is.na(ratingNum[m])){ratingNum[n]<-0}
  if(is.na(ratedbyNum[m])){ratedbyNum<-0}
  if(is.na(grossNum[m])){grossNum<-0}
}
ratingAvg <- NULL
ratedbyAvg <- NULL
grossAvg <- NULL
for (NODE in 1:nrow(nodesDF)){
  ratingAvg[NODE] <- mean(ratingNum[which(imdbRaw$director==nodesDF$Label[NODE] | imdbRaw$`top cast`==nodesDF$Label[NODE])])
  ratedbyAvg[NODE] <- mean(ratedbyNum[which(imdbRaw$director==nodesDF$Label[NODE] | imdbRaw$`top cast`==nodesDF$Label[NODE])])
  grossAvg[NODE] <- mean(grossNum[which(imdbRaw$director==nodesDF$Label[NODE] | imdbRaw$`top cast`==nodesDF$Label[NODE])])
}
#again replace all NAs with zero
#appending additional info to nodesDF
for (m in 1:nrow(nodesDF)){
  if(is.na(ratingAvg[m])){ratingAvg[m]<-0}
  if(is.na(ratedbyAvg[m])){ratedbyAvg[m]<-0}
  if(is.na(grossAvg[m])){grossAvg[m]<-0}
}
nodesLoadedDF <- cbind(nodesDF,ratingAvg,ratedbyAvg,grossAvg)
write.csv(nodesLoadedDF, file = "./output/nodesLoaded4gephi.csv", row.names = FALSE)
