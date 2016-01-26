## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015


## this function will take the NDVI from a list of tar files which is created by searching using the regular expression command. The calculated NDVI's will be saved in the output folder.

calculateNDVI <- function(file, extent = project_extent, outdir=dirout) {
  processLandsat(e=project_extent, x=file, vi='ndvi', outdir=dirout, srdir=srdir, delete=TRUE, keep=0, overwrite=TRUE)
}