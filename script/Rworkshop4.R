#rbind
marchFrame <- rbind(marchFrame,c(8,"holiday"))
#cbind
marchFrame <- cbind(marchFrame,c(11,12,13,14,15,16,
                                 17,18))
names(marchFrame)[3] <- "attendance"
#merge
flowerPrice <- data.frame(c("marigold","petunia","jasmine","rose"),c(20,40,35,150))
names(flowerPrice) <- c("flower","price")
flowerColour <- data.frame(c("daffodil","rose","marigold"),c("pink","red","yellow"))
names(flowerColour) <- c("flower","colour")
jointFlower <- merge(flowerColour,flowerPrice, by = 'flower')
#subset
bigAttendance <- subset(marchFrame,marchFrame$attendance>15)
#write.csv
write.csv(jointFlower, file = "./output/jointFlower.csv")
paste("this","is","a","vector",sep = " word ")
Sys.Date()
Sys.time()
Sys.timezone()
paste("./output/jointFlower",Sys.Date(),".csv", sep = "")
write.csv(jointFlower,
          file = paste("./output/jointFlower",Sys.Date(),".csv", sep = ""))
#ifelse
if (r==4) { 
  s <- "yes"
} else {
    s <- "no"
    }
print(s)


