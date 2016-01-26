## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015

#Import libraries
library(raster)
library(sp)
library(rgdal)
library(bfastSpatial)
## defining global variables
Sequoia_National_Forest_Lat_Long <- cbind(-118.501435, 36.478473) #Sequoia Long/Lat Coords- from googlemaps

project_string_extent <- '+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0' #from proj4



# Files-------------------------------------------------------
dirin <- '/home/jasondavis/final_project/data'
dirout <- '/home/jasondavis/final_project/output'

# if directories do not exist.. create
dir.create('R/')
dir.create('dirout/')
srdir <- file.path(dirname(rasterTmpFile()), 'tempdir') #temporary dir creation

## Create project extent
source('R/createCircleExtent.R')
project_extent <- createCircleExtent(Sequoia_National_Forest_Lat_Long, width=20, prj_string_extent)

# Get list of test data files
source('R/createFileList.R')
input_tar_file_paths <- createFileList(dirin, '*tar.gz', full.names=TRUE)

# Generate NDVI for the first archive file 
source('R/calculateNDVI.R')
sapply(input_tar_file_paths, calculateNDVI, extent=project_extent)

processLandsatBatch(e=project_extent, x=dirin, pattern=glob2rx('*.tar.gz'), outdir=dirout, srdir=srdir, delete=TRUE, vi='ndvi', mask=project_en, keep=0, overwrite=TRUE)

# Creating a multi-temporal raster object- Generate a file name for the output stack------


