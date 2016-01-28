## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015

# define a function that takes a vector as an argument
checkThresh <- function(x){
  # first, get rid of NA's
  x <- x[!is.na(x)]
  # if there still values left, count how many are above the threshold
  # otherwise, return a 0
  if(length(x) > 0){
    y <- length(x[x > 7000])
  } else {
    y <- 0
  }
  # return the value
  return(y)
}
# pass this functino to summaryBrick
customStat <- summaryBrick(tura, fun=checkThresh)
plot(customStat, main = "# of observations where NDVI > 0.7")