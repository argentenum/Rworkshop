setwd("C:/Users/DELL/Dropbox/Arjun/02-research/digital-humanities/workshops/Rworkshop/")
#https://map-rfun.library.duke.edu/01_georeference.html
#reading the data
lifeDF <- read.csv("./data/cleanoutput.csv", stringsAsFactors = FALSE)
library(sf)
library(mapview)
#converting data into spatial objects
birthLoc <- st_as_sf(lifeDF, coords = c("birthlon","birthlat"),
                     crs=4326)
deathLoc <- st_as_sf(lifeDF, coords = c("deathlon","deathlat"),
                     crs=4326)
#plotting the map
mapview(birthLoc)
mapview(list(birthLoc,deathLoc),col.regions=list("blue","red"),col=list("blue","red"),label=lifeDF$Name)