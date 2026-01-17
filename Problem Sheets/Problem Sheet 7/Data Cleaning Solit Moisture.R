library(ncdf4)
library(ggplot2)
library(sf)
library(dplyr)
library(lubridate)

## Load an extract data
temp <- nc_open("C:/Users/cr777/Desktop/Teaching 2024-2025/MA22019/Problem Sheets/Problem Sheet 7/SoilMoisture01072022.nc")
longitude <- ncvar_get(temp,"lon") 
latitude  <- ncvar_get(temp,"lat")
sm        <- ncvar_get(temp,"sm")

## Store variables as vectors
#lon <- rep(longitude, each = length(latitude))
#lat <- rep(latitude, times = length(longitude))
soil <- melt(sm)
coord_df <- expand.grid(Longitude = longitude, Latitude = latitude)

# Combine the coordinates with the soil moisture values
plot_data <- cbind(coord_df, Soil_Moisture = soil$value)
plot_data <- plot_data %>%
  filter( between(Longitude,-10,2.5 ) ) %>%
  filter( between(Latitude,36.2,44) )


# Step 5: Plot the data using ggplot2
ggplot(plot_data, aes(x = Longitude, y = Latitude, fill = Soil_Moisture)) +
  geom_tile() +
  scale_fill_viridis_c() +  # Use a color scale for continuous data
  theme_minimal() +
  labs(title = "Soil Moisture Plot", x = "Longitude", y = "Latitude", fill = "Soil Moisture") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # Rotate x-axis labels if needed


library(sp)
library(gstat)
SM_gamma <- plot_data %>% na.omit()
coordinates( SM_gamma ) <- ~Longitude+Latitude
gamma_hat <- variogram( Soil_Moisture~1, SM_gamma, width=0.1, cutoff=7  )
ggplot( gamma_hat, aes( x=dist, y=gamma/2 ) ) + geom_point( size=2 ) + 
  theme_bw() + labs( x="Distance", y="Semi-variogram" )

## Only keep data within certain boundaries
#ind_lon <- which( lon<10 & lon>-10 )
#ind_lat <- which( lat>50 & lat<70 )
#ind <- intersect( ind_lon, ind_lat )
#lon_UK <- lon[ind]
#lat_UK <- lat[ind]
#soil_UK <- soil[ind]

soil <- data.frame( Longitude = lon,
                    Latitude = lat,
                    Soil_Moisture = soil) 

soil_UK_spain <- st_as_sf( plot_data, coords=c("Longitude", "Latitude"), 
                           crs="WGS84" )

ggplot( soil_UK_spain ) + geom_sf( aes(color=Soil_Moisture) ) + theme_bw()

