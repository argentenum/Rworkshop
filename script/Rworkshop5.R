#while loop
i <- 1
while(i <= 10) i <- i+4
#while loop 2
while(TRUE) {
  i <- i + 4
  if (i > 10) break
}
#for loop
disco <- c(4,3,2,1)
for (n in disco)
{
  print(n)
}
#second way
for (n in 1:100)
{
  print(n)
}
#sequence
for (n in seq(5,100, by = 5))
{
  print(n)
}
#by length
age <- NULL
for (n in 1:length(disco)) {
  print(disco[n])
  age[n] <- disco[n]*2
}
#read.csv pnp
BioDF <- read.csv("https://web.iitd.ac.in/~arjunghosh/RworkshopFiles/cleanoutput.csv")
#print names of all personalities who were born in an even number year
#add a column giving age at death
#scan and exercise
pnpWords <- scan("https://web.iitd.ac.in/~arjunghosh/RworkshopFiles/pnp.txt"," ")
#pnpSentences <- scan("https://web.iitd.ac.in/~arjunghosh/RworkshopFiles/pnp.txt","\\.")
pnpWords[1]
nchar(pnpWords[1])
nchar(pnpWords)
#do the same thing with a loop
wordLen <- NULL
for (n in 1:length(pnpWords)) {
  wordLen[n] <- nchar(pnpWords[n])
}
pnpDF <- data.frame(pnpWords, wordLen, stringsAsFactors = FALSE)
#additional commands
unique(pnpWords)
#asnumeric
as.numeric("12345")
#ascharacter
as.character(12345)
#asdate
as.Date("08-03-2022", "%d-%m-%y%y")
as.Date(18329, origin = "1970-01-01")
#check presence
"truth" %in% pnpWords
#deduplicate
duplicated(pnpDF)
which(duplicated(pnpDF))
pnpDF[duplicated(pnpDF),]
pnpDF[!duplicated(pnpDF),]
#frequency
table(pnpWords)
sort(table(pnpWords))
sort(table(pnpWords), decreasing = TRUE)
