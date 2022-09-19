#regular expressions
pnpWords[42]
#substr
substr(pnpWords[42],1,9)
#strsplit
strsplit(pnpWords[42], split = "r")
strsplit("these are a few of my favourite things", split = " ")
str(strsplit("these are a few of my favourite things", split = " "))
unlist(strsplit("these are a few of my favourite things", split = " "))
#readlines
pnpText <- readLines("https://web.iitd.ac.in/~arjunghosh/RworkshopFiles/pnp.txt")
#parse sentences
strsplit(pnpText, "\\.")
#read sonnets
sonnets <- readLines("https://www.gutenberg.org/files/1041/1041-0.txt")
sonnets[328:341]
#trim white space
trimws(sonnets[328:341])
sonnets <- trimws(sonnets)
#grep
grep("Shall I compare", sonnets)
#sprintf()
i <- 8
sprintf("the square of %d is %d",i,i^2)
#regexpr ???
regexpr("uat","Equator")
#gregexpr
gregexpr("iss", "Mississipi")
#from sonnets identify sonnet lines and create a list with each sonnet as one column of the list
