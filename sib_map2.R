
require(ggmap)
require(raster)
#### load data set 252.944 records
bigtable<-read.csv(file="data/sib_bigtable.csv",header=T,encoding = "windows-1252")

#get poligon Colombia
co<-getData("GADM",country="CO",level=1,download=TRUE)
col_depto <- fortify(co,region="NAME_1") # make compatible to ggplot2

locat=as.vector(bbox(co))
ncmap = get_map(location=locat,source="stamen",maptype="toner",zoom=6)
#ggmap(ncmap) not nice

mapbase<- ggplot(col_depto, aes(long,lat,group=group)) + geom_polygon(fill="grey60") + coord_equal() +
  geom_path(color="grey") 

mapbase2<- ggplot(col_depto, aes(long,lat,group=group)) + geom_polygon(fill="White ") + coord_equal() +
  geom_path(color="grey") 

map1<-mapbase2 + geom_point(aes(x = lon, y = lat, group = TRUE), 
                    data = bigtable, size = 1.5,
                    alpha = 1/20) +
                    theme(legend.position = "right") +
                    guides(guide_legend((title = NULL)))

map2<-mapbase + geom_point(aes(x = lon, y = lat, group = FALSE), size=1, 
                    data = bigtable,alpha=I(0.25),colour="steelblue") + 
                    stat_binhex(aes(x = lon, y = lat, group = FALSE),
                    size = .5, binwidth = c(.5,.5), 
                    alpha = 2/4,data =bigtable)

map3<-mapbase + geom_point(aes(x = lon, y = lat, group = TRUE,
                     colour = factor(institution)), 
                     data = bigtable, size = 2,
                     alpha=1/2) + 
                     theme(legend.position = "right") 

map4<-mapbase + geom_point(aes(x = lon, y = lat, group = FALSE), 
                    size=0.5, 
                    data = bigtable,colour="red") + 
                    facet_wrap(~ institution, ncol = 6)
  
map1
map2
map3
map4
