library(spatstat)
library(rgeos)
## you can choose your own country here
height <- raster::getData(country='USA', mask=TRUE) ## SRTM 90m height data
usa <- raster::getData('GADM', country='USA', level=2)

california <- usa[usa$NAME_1 == "California",]

head(california)
plot(california, add=TRUE)
plot(sps, add=TRUE)
crs(california)
crs(band_list)
