library(openair)
library(lubridate)
library(dplyr)
library(ggplot2)

meta <- importMeta(source = "aurn")
temp <- importAURN( year = 2005:2023, pollutant = "o3", 
                    data_type = "monthly", site = meta$code )
temp <- temp %>% select( date, code, o3 )


meta_red <- temp %>% 
  group_by(code) %>% 
  summarise( Missing = sum(is.na(o3)) ) %>%
  ungroup() %>%
  filter( Missing == 0 )

temp_red <- filter( temp, code %in% meta_red$code )
meta_red <- filter( meta, code %in% meta_red$code )

temp_red <- temp_red %>%
  group_by( code, Month=month(date) ) %>%
  mutate( Scaled_O3 = (o3-mean( o3, na.rm = TRUE)) / sd(o3, na.rm=TRUE) ) %>%
  ungroup()


library(tidyr)
temp_PCA <- temp_red %>%
  select( -Month, -o3 ) %>%
  pivot_wider( names_from = code, values_from = Scaled_O3 ) %>%
  select( -HAR, -CHBO)

A_matrix <- as.matrix( temp_PCA[,-1] )
PCA      <- prcomp( A_matrix )




data("meuse")

Meuse_coord <- RDHtoLatLong::RDHtoLatLong(meuse$x, meuse$y)

Meuse <- meuse %>% 
  select( x, y, zinc ) %>%
  mutate( Lon = Meuse_coord[156:310], Lat=Meuse_coord[1:155], Zinc=log(zinc) )

write.csv(Meuse, "Meuse.csv", row.names = FALSE)




```{r}
write.csv(Wind_long, "Temperature Germany.csv", row.names = FALSE )
write.csv(Cities_coord, "Sites Germany.csv", row.names = FALSE )
```

```{r}
library(lubridate)
sites <- c("Angermunde", "Arkona", "Berlin", "Bremen", 
           "Cuxhaven", "Dusseldorf", "Emden", "Fehmarn",
           "Greifswald", "Hamburg", "Hannover", "Kiel",
           "Magdeburg", "Munster","Norderney", "Potsdam",
           "Rostock", "Schwerin", "Schleswig", "Sylt" )
```

```{r}
Cities_coord <- data.frame( Site = rep(0,length(sites) ),
                            Longitude = rep(0,length(sites) ),
                            Latitude = rep(0,length(sites) ) )
```

```{r}
Site <- read.table( paste("DWD Data/",sites[1],"Site.txt",sep=""), 
                    sep=";", header = TRUE )
Cities_coord[1,] <- c( sites[1], Site[1,c(4,3)] )

Obs <- read.table( paste("DWD Data/",sites[1],".txt",sep=""), 
                   sep=";", header = TRUE )
Wind <- data.frame( Date = as_date( as.character(Obs$MESS_DATUM_BEGINN),
                                    format="%Y%m%d"), 
                    x = Obs$MX_TX )
names(Wind)[2] <- sites[1] 
```


```{r}
for( j in 2:length(sites) ){
  Site <- read.table( paste("DWD Data/",sites[j],"Site.txt",sep=""), 
                      sep=";", header = TRUE )
  Cities_coord[j,] <- c( sites[j], Site[1,c(4,3)] )
  
  Obs <- read.table( paste("DWD Data/",sites[j],".txt",sep=""), 
                     sep=";", header = TRUE )
  Obs$Date <- as_date( as.character(Obs$MESS_DATUM_BEGINN), format="%Y%m%d")
  Obs <- select( Obs, Date, MX_TX )
  
  Wind <- Wind %>% full_join( Obs, by="Date" )
  
  names(Wind)[j+1] <- sites[j] 
  
}
```

```{r}
Wind_final <- Wind %>% 
  filter( Date > as_date("31/12/1999", format="%d/%m/%Y") )
```

```{r}
for( j in 2:21 ){
  Wind_final[,j] <- na_if(Wind_final[,j], -999 )
}
```

```{r}
Wind_long <- Wind_final %>%
  pivot_longer( cols=Angermunde:Sylt, 
                values_to = "Temperature", names_to = "Site" )
```


```{r}
Wind_long <- Wind_long %>%
  group_by( Site, Month=month(Date) ) %>%
  mutate( Wind_scaled = ( Wind - mean(Wind, na.rm = TRUE)) / sd(Wind, na.rm=TRUE) ) %>%
  ungroup()
```

```{r}
Wind_wide <- Wind_long %>%
  select( Date, Site, Wind_scaled ) %>%
  pivot_wider( names_from = Site, values_from = Wind_scaled)
```

```{r}
Wind_PCA <- prcomp( na.omit(Wind_wide[,-c(1)]), scale. = TRUE )
cumsum(Wind_PCA$sdev^2) / sum(Wind_PCA$sdev^2)
```



