#https://en.wikipedia.org/w/api.php
#Example of direct API query
library(httr)
#get contributions to Wikipedia by editor - latest 500 edits
UserContribsUrl <- "https://en.wikipedia.org/w/api.php?action=query&format=json&list=usercontribs&ucuser=WikiCleanerMan&uclimit=500&ucshow=!minor"
contribs1 <- GET(UserContribsUrl)
contribsContent1 <- content(contribs1, as = 'parsed')
#get info about a page 
PageInfo <- GET("https://en.wikipedia.org/w/api.php?action=query&format=json&prop=info&titles=Albert%Einstein")

library(WikipediaR)
startPage <- "Nupur_Sharma_(politician)" #getting start page from user
#edits of the start page - latest 500 edits
contribs <- contribs(page = startPage, domain = "en")
contribs$contribs$user
#pages edited by a user - latest 500 edits
UserContribs <- userContribs(user.name = "TrangaBellam", domain = "en", ucprop = "ids|title|timestamp|comment|sizediff|flags")
levelOneContribs <- as.character(unique(contribs$contribs$user)) #list of editors
InfoUser <- userInfo(user.name = "Calvin999", domain = "en")
#get all pages that link to a page
LinkBack <- backLinks(page = "Elizabeth_II", domain = "en")
#get all the links in a given wikipage
AllLinks <- links(page = "Elizabeth_II", domain = "en")

library(WikipediR)
PageContent <- page_content("en","wikipedia", page_name = "Mahatma Gandhi")
PageContent <- page_content("en","wikipedia", page_name = "Mahatma Gandhi", as_wikitext = TRUE)
#difference between two consequtive versions of a page
DiffPages <- revision_diff("en","wikipedia", revisions = 1105239780, direction = "next")


#rawScraping
RevisionsPage <- readLines("https://en.wikipedia.org/w/index.php?title=Mahatma_Gandhi&action=history")
library(rvest)
RevisionsStripped <- read_html("https://en.wikipedia.org/w/index.php?title=Mahatma_Gandhi&action=history")
RevisionsHtml <- RevisionsStripped %>% html_nodes("body") %>% html_text()
