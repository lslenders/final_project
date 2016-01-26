# load the sp and rgdal packages
library(sp)
library(rgdal)
library(rgeos)

project_extent_string <- '+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'
# coordinates of two points identified in Google Earth, for example:
NEcorn <- cbind(397815, 3871485)
SEcorn <- cbind(163185, 3871485)
SWcorn <- cbind(163185, 4110615)
NWcorn <- cbind(397815, 4110615)
NEcorn1 <- cbind(397815, 3871485)

## bind points together to make polygon
coords <- rbind(NEcorn, SEcorn, SWcorn, NWcorn, NEcorn1)

#build polygon
p = Polygon(coords)
ps = Polygons(list(p),1)
project_extent = SpatialPolygons(list(ps))
proj4string(project_extent) <- crs(project_extent_area) ## give polygon same spatial extent as LANDSAT rasters

