library(leaflet)
library(AOI)
library(rgeos)

map <- leaflet() %>%  
  #addProviderTiles(providers$OpenStreetMap.DE)  %>% 
  addProviderTiles(providers$Stamen.TonerLite)  %>% 
  setView(lng=116.4074, lat=39.9042, zoom=11) %>% 
  addMarkers(lng=116.4074, lat=39.9042, popup="The birthplace of R")
map
 

#  setView(lng=116.4074, lat=39.9042, zoom=4)  

aoi_get(country = "China") %>% 
  aoi_map(returnMap = TRUE)

geocode('Beijing', pt = TRUE) %>% aoi_map(returnMap = TRUE)
aoi_get(list("Beijing", 13, 13)) %>% aoi_map(returnMap = T)

geocode('Beijing', pt = TRUE)
geocode_rev(c(39.90622, 116.3913))


library(mapboxer)

mapboxer(
  style = basemaps$Carto$positron,
  center = c(116.4074, 39.9042),
  zoom = 9,
  minZoom = 8
) %>% add_navigation_control(
  pos = "top-left",
  # Option passed to the 'NavigationControl'
  showCompass = FALSE
) %>%
  add_scale_control(
    pos = "bottom-left",
    # Option passed to the 'ScaleControl'
    unit = "nautical"
  ) %>%
  add_text_control(
    pos = "top-right",
    text = "mapboxer"
  )
  
