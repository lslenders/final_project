## Team Puma
## Jason Davis & Lieven Slenders. 
## January 01-25-2015
#------------------------
# creates a circular 5km buffer extent around point.

# load the sp and rgdal packages
library(sp)
library(rgdal)
library(rgeos)

createCircleExtent <- function(coordinates, width=5000, prj_string_extent) {
  prj_string_WGS <- CRS("+proj=longlat +datum=WGS84")
  SNP <- SpatialPoints(coordinates, proj4string=prj_string_WGS)# make spatial points object
  prj_string_extent <- '+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0' # define CRS object for UTM projection
  SNP_reproject <- spTransform(SNP, prj_string_extent) # perform the coordinate transformation from WGS84 to RD
  
  # build polygonset & buffer for 1km diameter
  extent_circle <- gBuffer(SNP_reproject,
                           width=width,
                           quadsegs=100)
  return(extent_circle)
}
