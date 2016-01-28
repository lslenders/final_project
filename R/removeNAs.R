removeNAs <- function(timeStack){
  a <- list()               # empty list
  for (i in 1:length(s@data@names)) {
    if (!all(is.na(values(s[[i]])))) {  #not all NA's are stored in a (what you want to keep)
      a <- c(a, c=i)
    }
  }
  r <- subset(s, a) # (make a subset from dataset)
  return(r)
}