transform_metadata_to_df <- function(stations_metadata){
  stations_metadata[[1]] |> 
    map(as_tibble) |> 
    list_rbind() |> 
    mutate(latestData = map_chr(latestData, 1, .default = ""))  |> 
    mutate(latestData = as_datetime(latestData, tz = "UTC"))  |> 
    mutate(location = map(location, unlist)) |>  
    mutate(
      lat = map_dbl(location, "latLon.lat"),
      lon = map_dbl(location, "latLon.lon")
    ) %>% 
    select(-location)
}


to_iso8601 <- function(date_time_variable, offset){
  format_ISO8601(date_time_variable+days(offset),usetz = "Z")
}



transform_volumes <- function(value){
  value[[1]][[1]][[1]][[1]] %>%
    map(as_tibble) %>%
    list_rbind() %>%
    mutate(node = map(node,unlist)) %>% 
    mutate(volume = map_int(node, "volumeNumbers.volume", .default = NA_integer_)) %>% 
    mutate(from = map_chr(node,"node.from", .default = NA_character_)) %>% 
    mutate(to = map_chr(node, "to", .default = NA_character_)) #%>% 
#    select(-node)
}
  
    
#was not able to make it into a complete data frame, for some reason the the values in
# in the from and to column will not work. Some attempts underneath but not sure how
# to solve this.

#    mutate(from = map_chr(node, 1, .default = NA_character_))    
#    mutate(from = map_chr(node, "node.from", 1, .default = "")) %>% 
#    mutate(from = as_datetime(from, tz = "UTC")) %>% 
#    mutate(to = map_chr(node, "node.to", 1, .default = "")) %>% 
#    mutate(to = as_datetime(to, tz = "UTC")) #%>% 
    #mutate(node = map(node,unlist)) %>% 
    #mutate(volume = map_int(node, "volumeNumbers.volume"))
#  value[[1]][[1]][[1]][[1]][[1:length(value)]] %>%
#    map(as_tibble) %>% 
#    list_rbind() %>% 
#    mutate(from = map_chr(from, 1, .default = "")) #%>%
#    mutate(from = as_datetime(from, tz = "UTC")) %>% 
#    mutate(to = map_chr(node, "node.to", 1, .default = "")) %>% 
#    mutate(to = as_datetime(to, tz = "UTC")) %>% 
#    mutate(node = map(node, unlist)) %>% 
#    select(-node) %>% 
#    mutate(
#     from = map_chr(node, "node.from"),
#      to = map_chr(node, "node-to")
#      )
