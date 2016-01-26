## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015

# Files-------------------------------------------------------
dirin <- '/home/jasondavis/Wageningen/geoscripting/final_project/data'
dirout <- '/home/jasondavis/Wageningen/geoscripting/final_project/output'

# if directories do not exist.. create
dir.create('R/')
dir.create('dirout/')

# Create a temporary directory to store the output files.
srdir <- dirout <- file.path(dirname(rasterTmpFile()), 'bfmspatial')
dir.create(dirout, showWarning=FALSE)

#---------------------------------------------------------------------------
#Import libraries
library(raster)
library(sp)
library(rgdal)
library(bfastSpatial)

# Get list of test data files
list <- list.files(path=dirin, pattern = glob2rx('*.tar.gz'), full.names=TRUE)

# Generate NDVI for the first archive file 
processLandsat(e=sps, x=list[1], vi='ndvi', outdir=dirout, srdir=srdir, delete=TRUE, keep=0, overwrite=TRUE)

# create list of NDVI files created
NDVI_list <- list.files(dirout, pattern=glob2rx('*.grd'), full.names=TRUE)


# Create a new subdirectory in the temporary directory
dirout <- file.path(dirname(rasterTmpFile()), 'stack')
dir.create(dirout, showWarnings=FALSE)








# Generate a file name for the output stack---------------------------------------------------------
stackName <- file.path(dirout, 'stackTest.grd')

# Stack the layers
s <- timeStack(x=list, filename=stackName, datatype='INT2S', overwrite=TRUE)

# Visualize both layers (They are the same for the reason stated above)
plot(s)





