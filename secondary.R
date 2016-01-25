
dir.create('data/LANDSAT/bands')


list <- list.files(path='data', pattern = glob2rx('*.tar.gz'), full.names=TRUE)
list[1]

untar(list[1], exdir= 'data/LANDSAT/bands')

band4 <- list.files(path='data/LANDSAT', pattern = glob2rx('*band4*'))
band5 <- list.files(path='data/LANDSAT', pattern = glob2rx('*band5*'))


untar(list[1], exdir= 'data/LANDSAT', files = glob2rx('.tif$'))

c <- c('*band4*', '*band5*')
class(c)


untar('list[1]', exdir='data/LANDSAT')  # unzip data
band4 <- list.files(path='data/LANDSAT/bands',pattern = '+band4.tif$', full.names=TRUE) # list NDVIraster
band5 <- list.files(path='data/LANDSAT/bands',pattern = '+band5.tif$', full.names=TRUE)
band_list
band_list <- stack(band4,band5) # NDVI rasters
plot(band_list)
