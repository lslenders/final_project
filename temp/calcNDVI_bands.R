## Jason & Lieven Team Puma
## January 08 2016
#--------------------------------------------------------
# CalcNDVI function.
## Calculates the NDVI per pixel in a raster file.



## Args: NIR band raster layer, R band raster layer.
## Output: NDVI raster, values between 0 and 1.

calcNDVI <- function(Redband, NIRband) {
  ndvi <- (NIRband - Redband) / (Redband + NIRband)
  return(ndvi)
}


#--- extra intel -- 
## The NDVI normalizes green leaf scattering in the near-infrared wavelength
## and chlorophyll absorption in the red wavelength. 
## The value range of an NDVI is -1 to 1 where 
## healthy vegetation generally falls between values of 0.20 to 0.80.
