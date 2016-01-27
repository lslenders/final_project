## Jason & Lieven Team Puma
## January 27 2016
#--------------------------------------------------------
# Enhanced Vegetation Index (EVI)


## Args: NIR band raster layer, Red band raster layer, Blue band raster layer
## Output: EVI raster, values between 0 and 1.

calcEVI <- function(NIR, RED, BLUE) {
  EVI = 2.5*((NIR - RED) / ((NIR) + (6*RED) - (7.5*BLUE) + 1))
  return(EVI)
}


# ------------extra info-------------
#   In areas of dense canopy where the leaf area index (LAI) is high,
# the NDVI values can be improved by leveraging information in the blue wavelength.
# Information in this portion of the spectrum can help correct 
# for soil background signals and atmospheric influences.
# 
# The range of values for the EVI is -1 to 1,
# where healthy vegetation generally falls between values of 0.20 to 0.80.