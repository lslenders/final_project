## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015

#Import libraries
library(raster)
library(sp)
library(rgdal)
library(bfastSpatial)

# Files-------------------------------------------------------
dirin <- '/home/jasondavis/final_project/data'
dirout <- '/home/jasondavis/final_project/output'

# if directories do not exist.. create
dir.create('R/')
dir.create('dirout/')
srdir <- file.path(dirname(rasterTmpFile()), 'tempdir') #temporary dir creation

## Create project extent
source('R/createProjectExtent.R')
project_extent <- createProjectExtent()

# Get list of test data files
source('R/createFileList.R')
input_tar_file_paths <- createFileList(dirin, '*tar.gz', full.names=TRUE)

# Generate NDVI for the first archive file 
source('R/calculateNDVI.R')
NDVI_list <- lapply(input_tar_file_paths, calculateNDVI)



# Generate a file name for the output stack---------------------------------------------------------
stackName <- file.path(dirout, 'stackTest.grd')

# Stack the layers
s <- timeStack(x=list, filename=stackName, datatype='INT2S', overwrite=TRUE)

# Visualize both layers (They are the same for the reason stated above)
plot(s)





