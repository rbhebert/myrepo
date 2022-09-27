# Imports CSV of seach interest/Google Trends for hearing aid
# outputs heat map of US states

library(dplyr)
library(ggplot2)
library(ggpubr)
library(tidyverse)

theme_set(theme_bw(base_size=16))

us_states <- map_data("state")

# load CSV data
data1 <- read.csv(
  "/Users/reginaldhebert/Documents/myrepo/hearingCSV/5day30dayMap.csv", 
  header = TRUE)

# remove US aggregate
data2 <- data1[-c(52), ]

# scale values to 100%
# data2$delta5day <- data2$delta5day*100
# data2$delta30day <- data2$delta30day*100

# plot ratio of 3 days post-announcement to 5 days pre-announcement
plot1 <- 
us_states %>% 
  left_join(data2, by=c("region"="state")) %>% 
  ggplot(aes(x=long,y=lat,group=group, fill=delta5day)) +
  geom_polygon(color = "gray90", size = 0.1) +
  #coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  coord_map(projection = "albers", lat0 = 45, lat1 = 55) +
  # scale_fill_continuous(type = "viridis")+
  scale_fill_continuous(low = "white", high = "red")+
  theme(legend.position="bottom",
        axis.line=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid=element_blank())

ggsave(paste("5day.png"), plot = plot1, device = "png", 
       path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/plots", 
       dpi = 300)

# plot ratio of 3 days post-announcement to 30 days pre-announcement
plot2 <- 
us_states %>% 
  left_join(data2, by=c("region"="state")) %>% 
  ggplot(aes(x=long,y=lat,group=group, fill=delta30day)) +
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 45, lat1 = 55) +
  # scale_fill_continuous(type = "viridis")+
  scale_fill_continuous(low = "white", high = "blue")+
  # annotate("text", x = -120, y = 20, label = "Aug 16", 
  #          colour = "blue", angle = 0)
  theme(legend.position="bottom",
        axis.line=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid=element_blank())

ggsave(paste("30day.png"), plot = plot2, device = "png", 
       path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/plots", 
       dpi = 300)
