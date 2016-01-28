## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015
#------------------------
# creates a circular 5km buffer extent around point.

# load the sp and rgdal packages
library(sp)
library(rgdal)
library(rgeos)


createCircleExtent <- function(geocoordinates, width=5000, prj_string_extent) {
  prj_string_WGS <- CRS("+proj=longlat +datum=WGS84")
  SNP <- SpatialPoints(geocoordinates, proj4string=prj_string_WGS)# make spatial points object
  SNP <- spTransform(SNP, UTM_11_crs) # perform the coordinate transformation from WGS84 to projected
  
  # build polygonset & buffer for 1km diameter
  circle_buffer <- gBuffer(SNP,
                           width=5000,
                           quadsegs=100)
  circle_buffer <- spTransform(circle_buffer, WGS_latlon_crs)
  return(circle_buffer)
}
