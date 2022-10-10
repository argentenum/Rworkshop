library(pdftools)
#reading the filenames
file.vector <- list.files(path = "./data/fancyCVs/")
#setting up loop to read each pdf and process
allCVs <- NULL
for (ton in 1:length(file.vector)){
  cvtxt <- pdf_text(paste0("./data/fancyCVs/",file.vector[ton]))  #reading text from pdf
  #older versions of R could use the package "tabulizer" to extract tables from PDF files
  cvLines <- unlist(strsplit(cvtxt, split = "\\n")) #parsing text in lines
  #reading single line elements
  cvName <- substring(cvLines[grep("Name",cvLines)],25,nchar(cvLines[grep("Name",cvLines)]))
  cvPhone <- substring(cvLines[grep("Phone",cvLines)],25,nchar(cvLines[grep("Phone",cvLines)]))
  cvEmail <- substring(cvLines[grep("Email",cvLines)],25,nchar(cvLines[grep("Email",cvLines)]))
  cvDoB <- substring(cvLines[grep("Date of Birth",cvLines)],25,nchar(cvLines[grep("Date of Birth",cvLines)]))
  cvNation <- substring(cvLines[grep("Nationality",cvLines)],25,nchar(cvLines[grep("Nationality",cvLines)]))
  #reading single entry multiple line elements
  addressStartPos <- grep("Address",cvLines)
  addressEndPos <- grep("Phone",cvLines) - 1
  cvAddress <- NULL
  for (ad in 1:((addressEndPos-addressStartPos)+1)){
    cvAddress[ad] <- substring(cvLines[addressStartPos+ad-1],25,nchar(cvLines[addressStartPos+ad-1]))
  }
  #reading multiple entry and multiple line elements
  experStartPos <- grep("Experience",cvLines) + 1
  experEndPos <- length(cvLines)
  #identifying experience phases
  experPhasePos <- which(substring(cvLines[experStartPos:experEndPos],1,1)!=" ")
  experPhases <-  trimws(substring(cvLines[experPhasePos + experStartPos -1],1,24))
  experDetails <- substring(cvLines[experStartPos:experEndPos],25,nchar(cvLines[experStartPos:experEndPos]))
  #extracting lines for each phase
  experLines <- NULL
  experStops <- c(experPhasePos,(length(experLines)+1)) #because we need to define the final line as one before the next
  for (exp in 1:length(experPhases)){
    experLines[exp] <- paste(experDetails[experStops[exp]:(experStops[exp+1]-1)], collapse = " ")
  }
  experList <- list(experPhases,experLines)
  cvList <- list(cvName,cvAddress,cvPhone,cvEmail,cvDoB,cvNation, experList)
  names(cvList) <- c("Name","Address","Phone","Email","Date of Birth","Nationality","Experience")
  allCVs[[cvName]] <- cvList
}