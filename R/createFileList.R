## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015

## This function will search the data folder and create a list of all the tar file pathnames that will need extraction for calculation of the NDVI in the following step (during the lapply loop).

# Get list of test data files
createFileList <- function(path, pattern, full.names=TRUE) {
  list.files(path=dirin, pattern = glob2rx('*.tar.gz'), full.names=TRUE)
}
