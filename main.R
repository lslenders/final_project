## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015


#Import libraries
library(raster)
library(sp)
library(rgdal)
library(bfastSpatial)


setwd('jasondavis/final_project/')
# Files-------------------------------------------------------

dirin <- '/media/jasondavis/old_harddrive/data/California/'
dirout <- '/media/jasondavis/old_harddrive/output/California/'  # 
# if directories do not exist.. create
srdir <- dirout <- file.path(dirname(rasterTmpFile()), 'calitemp') #temporary dir creation


## Defining global variables (user can edit to specifications based on LANDSAT data)-------------------
UTM_11_crs <- '+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0' #from proj4
UTM_34_crs <- '+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0'
WGS_latlon_crs <- '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0'
Sequoia_National_Forest_Lat_Long <- cbind(-118.5941435, 36.478473)

## Generate coordinate points from a city name --------------------------------------------------------
source('R/genCityCoords.R') ## returns a 2 column by 1 row matrix with lat, long pair
location <- geoCode('Amsterdam') 


## Make buffer around coordinate points ---------------------------------------------------------------
source('R/createCircleExtent.R')  ## returns a circular polygon to be used for extent/crop
circle_buffer <- createCircleExtent(Sequoia_National_Forest_Lat_Long, width=500, WGS_latlon_crs) 

# Create list of input tar LANDSAT data files
input_tar_file_paths <- list.files(path=dirin, pattern = glob2rx('*tar.gz'), full.names=TRUE)

## Process LANDSAT files by creating Vegetation indexes -----------------------------------------------
processLandsatBatch(x=dirin, pattern=glob2rx('*.tar.gz'), 
                    outdir=dirout, srdir=srdir, delete=TRUE, vi='ndvi', 
                  mask='fmask', keep=0, overwrite=TRUE)

## Create list path names to .grd VI files created in previous step -----------------------------------
ndvi_path_list <- list.files('/home/jasondavis/Desktop/calitemp', pattern=glob2rx('*.grd'), full.names=TRUE)

circle_buffer <- createCircleExtent(Sequoia_National_Forest_Lat_Long, width = 3000, WGS_latlon_crs)

## Crop raster files ---------------------------------------------------------------------------------
source('R/cropRasters.R')
cropped <- cropRasters(ndvi_path_list, circle_buffer)


# Create a new subdirectory in the temporary directory ------------------------------------------------
dirout <- file.path(dirname(rasterTmpFile()), 'stack')
dir.create(dirout, showWarnings=FALSE)

# Generate a file name for the output stack -----------------------------------------------------------
stackName <- file.path(dirout, 'stackTest.grd')

## Create list path names to .grd VI files created in previous step -----------------------------------
ndvi_path_list_cropped <- list.files(dirout, pattern=glob2rx('*.grd'), full.names=TRUE)

dirout
# Stack the layers ------------------------------------------------------------------------------------
s <- timeStack(x=ndvi_path_list_cropped, filename=stackName, datatype='INT2S', overwrite=TRUE)

## To remove from 'stacked'  the NA-files ---------------------------------------------------------------
source('R/removeNAs.R')
s <- removeNAs(s)

# plot(r) # uncomment to plot result of removing NA's
s <- r # rename s bacck to s from r

plot(bfm)
# # show the layer names ------------------------------------------------------------------------------
names(s) ## check names in s
s_df <- getSceneinfo(names(s))  # create data frame from raster brick
 
# Add a column for years and plot # of scenes per year ------------------------------------------------
s_df$year <- as.numeric(substr(s_df$date, 1, 4)) ## add year column
hist(s_df$year, breaks=c(min(s_df$year): max(s_df$year)), main="p170r55: Scenes per Year", 
     xlab="year", ylab="# of scenes")


## Summary Statistics: summaryBrick() and annualSummary() ---------------------------------------------
meanVI <- summaryBrick(s, fun=mean, na.rm=TRUE) # na.rm=FALSE by default
plot(meanVI)

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
t2 <- system.time(
  bfm <- bfmSpatial(s, start=c(2011, 1), order=1, mc.cores=2)
)
plot(bfm)
# compare processing time with previous run
t1 - t2