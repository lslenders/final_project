## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015

setwd('/home/user/final_project/')
#Import libraries
library(raster)
library(sp)
library(rgdal)
library(bfastSpatial)


# # Prepare the extrent of AreaOfInterest'
# source('R/genCityCoords.R')
# location <- geoCode('Debrecen') ## define location #names(location) <- c("lat","lon","location_type", "forAddress")
# middlepoint <- cbind(as.numeric(location[2]),as.numeric(location[1])) # Long/Lat Coords- from googlemaps
# 
# source('R/createCircleExtent.R')
# project_string_extent <- '+proj=utm +zone=34 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0' #from proj4
# project_extent <- createCircleExtent(middlepoint, width=50000, project_string_extent)

#LANDSAT

# Set files-------------------------------------------------------

dirin <- '/home/user/final_project/data/Hungary'
dirout <- '/home/user/final_project/output/Hungary'  # 
# if directories do not exist.. create
srdir <- dirout <- file.path(dirname(rasterTmpFile()), 'tempdir') #temporary dir creation




# image aquisition ----------------------------------------------------------------
## create spatio temporal rasterstack
listed_tars <- list.files(path=dirin, pattern = glob2rx('*tar.gz'), full.names=TRUE)
dir.create(dirout, showWarning=FALSE)

## process landsat for given VI
# source('R/processLandsatVI.R')
# processLandsatVI <- function(input, vi, fname){
#   #e=drawExtent(), ## want to know dimension of drawn extent -> AOI selection  
#   processLandsatBatch(x=input,vi=vi, 
#                       outdir=dirout, mask='fmask',
#                       pattern=glob2rx('*.tar.gz'), srdir=srdir, delete=TRUE,
#                       keep=0, overwrite=TRUE)
#   
#   list_batched <- list.files(dirout, pattern=glob2rx('*.grd'), full.names=TRUE) # plot(raster(list_batched[50]))
#   
#   stackName <- file.path(dirout, fname=fname)#  Generate 
#   
#   s <- timeStack(x=list_batched, filename=stackName, datatype='INT2S', overwrite=TRUE)
#   return(s)
# }


 #e=drawExtent(), ## want to know dimension of drawn extent -> AOI selection  
processLandsatBatch(x=listed_tars,vi='ndvi', 
                       outdir=dirout, mask='fmask',
                       pattern=glob2rx('*.tar.gz'), srdir=srdir, delete=TRUE,
                       keep=0, overwrite=TRUE)
   
list_batched <- list.files(dirout, pattern=glob2rx('*.grd'), full.names=TRUE) # plot(raster(list_batched[50]))
#stackName <- file.path(dirout, 'Hungary.grd')
stackName <- file.path('/home/user/final_project/output/Hungary', fname='Hungary.grd')#  Generate 

s <- timeStack(x=list_batched, filename=stackName, datatype='INT2S', overwrite=TRUE)



## To remove from 'stacked'  the NA-files
  a <- list()               # empty list
  for (i in 1:length(s@data@names)) {
    if (!all(is.na(values(s[[i]])))) {  #not all NA's are stored in a (what you want to keep)
      a <- c(a, c=i)
    }
  }
  r <- subset(s, a) # (make a subset from dataset)
  # plot(r)

  
# # adding Year, names and show Histogram  
# r_df <- getSceneinfo(names(r))
# r_df$year <- as.numeric(substr(r_df$date, 1, 4))              # add a column for years  
# hist(r_df$year, breaks=c(1999:2015), main="Scenes per Year", 
#       xlab="year", ylab="# of scenes")                        # hist for scenes per year




ndvi_hungary <- timeStack(x=list(r), filename=stackName, datatype='INT2S', overwrite=TRUE)  ## ! x not list of characters



# 
# ndvi_brick <- processLandsatVI(listed_tars, 'ndvi', 'Hungary.grd')
# evi_brick <- processLandsatVI(listed_tars, 'evi', 'Hungary.grd')



# #Summary Statistics: summaryBrick() and annualSummary()
# meanVI <- summaryBrick(s, fun=mean, na.rm=TRUE) # na.rm=FALSE by default
# plot(meanVI)
annualMed <- annualSummary(s, fun=median, sensor="ETM+", na.rm=TRUE)
head(annualMed)

library(animation)
?saveGIF
plot(annualMed) ## MAKE A GIFFFFFF

class(s)
head(s)

data(s)
# plot the 42nd layer
plot(s,150)
# run bfmPixel() in interactive mode with a monitoring period 
# starting @ the 1st day in 2009
bfm <- bfmPixel(tura, start=c(2009, 1), interactive=TRUE)

##Running bfast pixel
targcell <- 1000
bfm <- bfmPixel(s, cell=targetcell, start=c(2000, 2))
# inspect and plot the $bfm output
bfm$bfm
range(s_df$year)



#==================================
