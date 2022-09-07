setwd("~/anarchistScraping/")
library(magick)
#making a vector of all image files
Scans <- list.files(pattern = "*.png")
text <- NULL
for (SAY in 1:length(Scans))
{
folio <- image_read(Scans[SAY])
#cropping image "width X height + xmin +ymin"
#have to set crop limits for each book
cropLeft <- image_crop(folio, "1180x1860+140+140",repage=TRUE)
image_write(cropLeft, paste("seq",((SAY*2)-1),".png",sep=""))
cropRight <- image_crop(folio, "1300x1860+1225+140",repage=TRUE)
image_write(cropRight, paste("seq",((SAY*2)),".png",sep=""))
library(tesseract)
#merging engines for english and bangla
bengali <- tesseract("ben+eng")
#reading left image
textLeft <- tesseract::ocr(cropLeft, engine = bengali)
#reading right image
textRight <- tesseract::ocr(cropRight, engine = bengali)
#merging left and right pages
text <- paste(text,textLeft,textRight, sep = "$$$\n")
print(SAY)
cropLeft <- NULL
cropRight <- NULL
gc()
}
writeLines(text, "RocrOutput.txt")
