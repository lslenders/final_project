## Jason & Lieven Team Puma
## January 27 2016
#--------------------------------------------------------
# Water Band Index (WBI)


##  Args:
##      900nm = x
##      970nm = y
## Output: 
##      The common range of values for green vegetation is 0.8 to 1.2.

calcWBI <- function( x, y) {
  WBI = x / y
  return(WBI)
}


# ------------extra info-------------
# The WBI is a reflectance measurement that is sensitive to 
# changes in canopy water content. As the water content of vegetation
# canopies increases, the strength of absorption around 970nm increases
# related to that of 900nm. Applications of the WBI include canopy stress
# analysis, productivity prediction and modeling, fire hazard condition analysis, 
# cropland management, and studies of ecosystem physiology.