
cropRasters <- function(input_files, extent_object) {
  y <- crop(raster(input_files[1]), extent_object)
  for(i in 1:length(input_files)) {
    print(input_files[i])
    r <- crop(raster(input_files[i]), extent_object)
    resampled <- resample(r, y, filename=paste(dirout, basename(input_files[i]), 'cropped', sep=''), overwrite=TRUE)
  }
}