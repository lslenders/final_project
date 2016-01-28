## Jason & Lieven Team Puma
## January 27 2016
#--------------------------------------------------------
# CalcSAVI function.

## 
## SAVI = NDVI + soil correction. normalizes green leaf scattering in the near-infrared wavelength..
## L=0; high veg dens, and in areas with no green vegetation, L=1. 
## Generally, an L=0.5 works well in most situations



## Args: NIR band raster layer, R band raster layer, L= soil brightness
## Output: SAVI raster, values between 0 and 1.

calcSAVI <- function(Red, NIR, L=0.5) {
  SAVI <- (NIR - Red) / (Red + NIR + L) *(1+L)
  return(SAVI)
}
