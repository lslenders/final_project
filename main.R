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

#--------------------------------------------------------------
#unzip raster files
source('R/unzipFile.R')
unzipFile('data/LANDSAT_8_98131.kmz', 'data')




