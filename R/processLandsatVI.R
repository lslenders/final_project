# Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-28-2015

# args:
#   input: landsat tars as list
#   vi : appliceable for '?processLandsatBatch' presets -> as a string
#   fname : a file name for the stacked -> as string 
#   
# Returns:
#   s: a rasterbrick of ladsat tars
# ---------------------------------------------------------


processLandsatVI <- function(input, vi, fname){
  #e=drawExtent(), ## want to know dimension of drawn extent -> AOI selection  
  processLandsatBatch(x=input,vi=vi, 
                      outdir=dirout, mask='fmask',
                      pattern=glob2rx('*.tar.gz'), srdir=srdir, delete=TRUE,
                      keep=0, overwrite=TRUE)
  
  list_batched <- list.files(dirout, pattern=glob2rx('*.grd'), full.names=TRUE) # plot(raster(list_batched[50]))
 
  stackName <- file.path(dirout, fname=fname)#  Generate 
  
  s <- timeStack(x=list_batched, filename=stackName, datatype='INT2S', overwrite=TRUE)
  return(s)
}

r <- processLandsatVI(listed_tars, 'ndvi', 'Hungary.grd')
