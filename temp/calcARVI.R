## Jason & Lieven Team Puma
## January 27 2016
#--------------------------------------------------------
# Atmospherically Resistant Vegetation Index (ARVI)


##  Args:
##      900nm = x
##      970nm = y
## Output: 
##      The range ARVI is -1 to 1. where green vegetation generally falls between values of 0.20 to 0.80

calcARVI <- function( BLUE, RED, NIR) {
  ARVI = ((NIR) - (2*RED - BLUE) / (NIR) + (2*RED - BLUE))
  return(ARVI)
}


# ------------extra info-------------
#The ARVI is an enhancement to the NDVI that 
# is relatively resistant to atmospheric factors such as aerosol. 
# It works by using reflectance measurements in the blue 
# wavelengths to correct for atmospheric scattering effects 
# that register in the red reflectance spectrum. The ARVI is
# most useful in regions of high atmospheric aerosol content.

