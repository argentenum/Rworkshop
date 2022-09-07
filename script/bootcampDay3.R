#loops
for (n in 1:100)
{
  print(n)
}
titanicDF <- data.frame(Titanic)
titanicAdults <- subset(titanicDF,titanicDF$Age=="Adult")
i <- 2
i^2
titanicAdults$Freq
titanicAdults$Freq^2
max(titanicAdults$Freq)
log(max(titanicAdults$Freq))
#pipes
#install.packages('magrittr')
library(magrittr)
titanicMax <- titanicAdults$Freq %>% max() %>% log()
titanicDF %>% 
  subset(titanicDF$Freq>100) %>% 
  unlist() %>% 
  max()
#input data
workshopPage <- readLines("https://web.iitd.ac.in/~arjunghosh/RworkshopFiles/")
#string manipulation
library(stringr)
sonnets <- readLines("https://www.gutenberg.org/cache/epub/1041/pg1041.txt")
sonnets[327:340]
grep("Shall I compare",sonnets)
sonnets[grep("Shall I compare", sonnets):(grep("Shall I compare",sonnets)+13)]
nchar(328)
paste("I will give you",grep("Shall I compare",sonnets),"bags","full on",Sys.time())
which(nchar(unlist(strsplit(sonnets[327], split = " ")))>0)
pnpPara <- readLines("https://web.iitd.ac.in/~arjunghosh/RworkshopFiles/pnp.txt")
sort(table(unlist(strsplit(pnpPara, split = " "))), decreasing =  TRUE)
strsplit(pnpPara, split ="\\.")
plot(sort(table(unlist(strsplit(pnpPara, split = " "))), decreasing =  TRUE))
