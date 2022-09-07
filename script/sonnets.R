library(magrittr)
#read the file
sonnets <- readLines("https://www.gutenberg.org/cache/epub/1041/pg1041.txt")
#remove header and footer
sonnets <- sonnets[(grep("START OF THE PROJECT", sonnets)+1):(grep("END OF THE PROJECT",sonnets)-1)]
#check shape of file
plot(nchar(sonnets))
#remove empty lines
sonnets <- sonnets[which(nchar(sonnets)>0)]
#removing white space
sonnets <- trimws(sonnets)
#making a vector of sonnet numbers
sonnetNumberPos <- which(nchar(sonnets)<11)
sonnetNumbers <- sonnets[sonnetNumberPos]
#preparing the dataframe
sonnetsDF <- NULL
for (n in 1:length(sonnetNumbers))
  {
    ifelse(n==154,m <- length(sonnets), m <- sonnetNumberPos[n+1]-1)
    sonnetsDF[[n]] <- sonnets[(sonnetNumberPos[n]+1):m]
    print(paste(n,": ",length(sonnetsDF[[n]])))
  }
#equalizing all sonnet vectors
for (t in 1:length(sonnetsDF))
{
  if (length(sonnetsDF[[t]])<15) 
    {sonnetsDF[[t]][(length(sonnetsDF[[t]])+1):15] <- ""}
}

sonnetsDF <- data.frame(sonnetsDF)
names(sonnetsDF) <- sonnetNumbers
