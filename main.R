## Team Puma
## Jason Davis & Lieven Slenders. 
## January 12-1-2015
# -------------------------------------------------------
indir <- '~/Wageningen/geoscripting/final_proj_R/data'
outdir <- '~/Wageningen/geoscripting/final_proj_R/output'

## setting working directory
getwd()
setwd("~/Wageningen/geoscripting/final_proj_R")

#
dir.create('R/')
dir.create('output/')
#---------------------------------------------------------------------------
#Import libraries
library(raster)
library(sp)
library(rgdal)
library(bfastSpatial)

#--------------------------------------------------------------
#unzip raster files
source('R/unzipFile.R')
unzipFile('data/LANDSAT_8_98157.zip', 'data')
unzipFile('data/LANDSAT_8_98131.kmz', 'data')

# Set the location of output and intermediary directories (everything in tmpdir in that case)
# We use dirname(rasterTmpFile()) instead of rasterOptions()$tmpdir to reduce verbose
srdir <- dirout <- file.path(dirname(rasterTmpFile()), 'bfmspatial')
dir.create(dirout, showWarning=FALSE)

# Get list of test data files
list <- list.files(system.file('external', package='bfastSpatial'), full.names=TRUE)

# Generate (or extract, depending on whether the layer is already in the archive or not) NDVI for the first archive file
processLandsat(x=list[1], vi='ndvi', outdir=dirout, srdir=srdir, delete=TRUE, mask='fmask', keep=0, overwrite=TRUE)


##----------------------------------
# Visualize one of the layers produced
list <- list.files(dirout, pattern=glob2rx('*.grd'), full.names=TRUE)
plot(r <- raster(list[1]))
##---------------------------------------------------------------------------------------------

# Create a temporary directory to store the output files.
srdir <- dirout <- file.path(dirname(rasterTmpFile()), 'bfmspatial_batch')
dir.create(dirout, showWarning=FALSE)

# Get the directory where the Landsat archives are stored
dir <- system.file('external', package='bfastSpatial')

# Run the batch line
processLandsatBatch(x=dir, pattern=glob2rx('*.zip'), outdir=dirout, srdir=srdir, delete=TRUE, vi='ndvi', mask='fmask', keep=0, overwrite=TRUE)


# Visualize one of the layers produced
list <- list.files(dirout, pattern=glob2rx('*.grd'), full.names=TRUE)
plot(r <- raster(list[2]))
plot(r <- raster(list[1]))





