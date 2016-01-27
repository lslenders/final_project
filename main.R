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
#



# Files-------------------------------------------------------
dirin <- '/data/Hungary'
dirout <- '/home/jasondavis/final_project/output/Hungary'  # 
# if directories do not exist.. create
srdir <- file.path(dirname(rasterTmpFile()), 'tempdir') #temporary dir creation



# defining global variables
source('R/genCityCoords.R')
location <- geoCode('Debrecen') ## define location #names(location) <- c("lat","lon","location_type", "forAddress")
middlepoint <- cbind(as.numeric(location[2]),as.numeric(location[1])) # Long/Lat Coords- from googlemaps

source('R/createCircleExtent.R')
project_string_extent <- '+proj=utm +zone=34 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0' #from proj4
project_extent <- createCircleExtent(middlepoint, width=20000, project_string_extent)


# extrat data ----------------------------------------------------------------

# Get list of test data files
source('R/createFileList.R')
input_tar_file_paths <- createFileList(dirin, '*tar.gz', full.names=TRUE)

# Generate NDVI for the first archive file 
source('R/calculateNDVI.R')
sapply(input_tar_file_paths, calculateNDVI, extent=project_extent)

processLandsatBatch(e=project_extent, x=dirin, pattern=glob2rx('*.tar.gz'), outdir=dirout, srdir=srdir, delete=TRUE, vi='ndvi', mask=project_en, keep=0, overwrite=TRUE)

# Creating a multi-temporal raster object- Generate a file name for the output stack------


## calc VI -----------------------------
## crop to extent-------------------
## apply cloud mask ---------------------
## create spatio temporal objcts------------


