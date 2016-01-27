
# ## SRTM 90m height data
library(raster)
library(spatstat)
library(rgeos)
library(sp)
library(rgdal)
## you can choose your own country here
hungary <- raster::getData('GADM', country='HUN', level=2) ## administrative boundaries



hungary_UTM <- spTransform(hungary, "+proj=utm +zone=34 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")


Debrecen <- hungary_UTM[hungary_UTM$NAME_2 == 'Debrecen',]

plot(hungary_UTM)
plot(Debrecen, col='red', add=T)
