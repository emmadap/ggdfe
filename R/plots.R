iris %>%
  ggplot(aes(x=Species,y=Sepal.Length,fill=Species))+
  geom_col()+
  scale_fill_dfe()



data <- data.frame(murder = USArrests$Murder,
                   state = tolower(rownames(USArrests)))
map <- map_data("state")
ggplot(data, aes(fill=murder))+
  geom_map(aes(map_id = state), map=map)+
  expand_limits(x = map$long, y=map$lat)+
  scale_fill_dfe(palette = 'heat',discrete = F)
