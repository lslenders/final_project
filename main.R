# hungary

## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015

setwd('/home/user/final_project/')
#Import libraries
library(raster)
library(sp)
library(rgdal)
library(bfastSpatial)



# Files-------------------------------------------------------


dirin <- '/home/user/final_project/data/Hungary/'
dirout <- '/home/user/final_project/output/Hungary'  # 
# if directories do not exist.. create
srdir <- dirout <- file.path(dirname(rasterTmpFile()), 'tempdir') #temporary dir creation



# defining global variables
source('R/genCityCoords.R')
location <- geoCode('Debrecen') ## define location #names(location) <- c("lat","lon","location_type", "forAddress")
middlepoint <- cbind(as.numeric(location[2]),as.numeric(location[1])) # Long/Lat Coords- from googlemaps

source('R/createCircleExtent.R')
project_string_extent <- '+proj=utm +zone=34 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0' #from proj4
project_extent <- createCircleExtent(middlepoint, width=50000, project_string_extent)


# image aquisition ----------------------------------------------------------------

# Get list of test data files
input_tar_file_paths <- list.files(path=dirin, pattern = glob2rx('*tar.gz'), full.names=TRUE)


processLandsatBatch(x=dirin, pattern=glob2rx('*.tar.gz'), 
                    outdir=dirout, srdir=srdir, delete=TRUE, vi='ndvi', mask='fmask', keep=0, overwrite=TRUE)

# Creating a multi-temporal raster object- Generate a file name for the output stack------

# preprocessing ----------------
## calc VI -----------------------------
## crop to extent-------------------
## apply cloud mask ---------------------

# Create a new subdirectory in the temporary directory
dirout <- file.path(dirname(rasterTmpFile()), 'stack')
dir.create(dirout, showWarnings=FALSE)
# TSA --- 
## create spatio temporal objcts------------



# Generate a file name for the output stack
stackName <- file.path(dirout, 'stackTest.grd')
list <- list.files(srdir, pattern=glob2rx('*.grd'), full.names=TRUE)
list[]
# Stack the layers
s <- timeStack(x=list, filename=stackName, datatype='INT2S', overwrite=TRUE)

# show the layer names
names(s)
s <- getSceneinfo(names(s))

# add a column for years and plot # of scenes per year
s$year <- as.numeric(substr(s$date, 1, 4))
hist(s$year, breaks=c(1999:2015), main="Scenes per Year", 
     xlab="year", ylab="# of scenes")


