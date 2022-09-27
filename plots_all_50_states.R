# Generate plots from google trends data

library(dplyr)
library(ggplot2)
library(ggpubr)

# list of state names

state_list <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL",
              "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA",
              "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE",
              "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK",
              "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT",
              "VA", "WA", "WV", "WI", "WY", "DC", "US")

# Import data from CSV files

data1 <- read.csv(
  "/Users/reginaldhebert/Documents/myrepo/hearingCSV/10_days_around.csv", 
  header = TRUE)

# rename variables and convert from string to date format

new <- c("Date",state_list)

old <- colnames(data1)

data1 <- data1 %>% rename_with(~ new, all_of(old))

# date format can vary based on python script output

data1$Date <- as.Date(data1$Date, format = "%m/%d/%y")
 
# data1$Date <- as.Date(data1$Date)



# generate plots and save



# hearing aid

for (i in 2:ncol(data1)) {
  plot1 <- ggplot(data1, aes_string(x = colnames(data1)[1], 
                                    y = colnames(data1)[i], group = 1)) + 
    geom_line() +
    scale_x_date() +
    geom_vline(xintercept=data1$Date[33], color = "blue") +
    annotate("text", x = data1$Date[29], y = 100, label = "Aug 16", 
             colour = "blue", angle = 0) +
    labs(title = paste(names(data1)[i]," - \'hearing aid\'"), subtitle = "2022-07-15 2022-9-12, daily", 
         caption = "Data from Google Trends", y = "Search Intensity", x = "") 
  plot1
  ggsave(paste("plot_",names(data1)[i],".png"), plot = plot1, device = "png", 
         path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/plots", 
         dpi = 300)
}

# modified plot generation for multiple plots in a grid for visual inspection

for (i in 2:ncol(data1)) {
  assign(paste0("plot_",i-1), ggplot(data1, aes_string(x = colnames(data1)[1], 
                                                       y = colnames(data1)[i], 
                                                       group = 1)) + 
           geom_line() +
           scale_x_date(breaks="day", labels = NULL, name = NULL) +
           scale_y_discrete(labels = NULL, name = NULL, breaks = NULL) +
           geom_vline(xintercept=data1$Date[6], color = "blue") +  # [33] in original data set
           labs(y = "", x = "") +
           theme(
                 axis.text.y=element_blank(),  #remove y axis labels
                 axis.ticks.y=element_blank()  #remove y axis ticks
           ))
}

# old version of plot
# for (i in 2:ncol(data1)) {
#   assign(paste0("plot_",i-1), ggplot(data1, aes_string(x = colnames(data1)[1], 
#                                                        y = colnames(data1)[i], 
#                                                        group = 1)) + 
#           geom_line() +
#            scale_x_date() +
#           geom_vline(xintercept=data1$Date[6], color = "blue") +  # [33] in original data set
#           labs(y = "", x = "") +
#            theme(axis.text.x = element_blank(),
#                  axis.ticks.x = element_blank(),
#                  axis.text.y = element_blank(),
#                  axis.ticks.y = element_blank()))
# }


plot_list <- list(plot_1,plot_2,plot_3,plot_4,plot_5,plot_6,plot_7,plot_8,plot_9,plot_10,
                  plot_11,plot_12,plot_13,plot_14,plot_15,plot_16,plot_17,plot_18,plot_19,plot_20,
                  plot_21,plot_22,plot_23,plot_24,plot_25,plot_26,plot_27,plot_28,plot_29,plot_30,
                  plot_31,plot_32,plot_33,plot_34,plot_35,plot_36,plot_37,plot_38,plot_39,plot_40,
                  plot_41,plot_42,plot_43,plot_44,plot_45,plot_46,plot_47,plot_48,plot_49,plot_50,
                  plot_51,plot_52)

allPlots <- ggarrange(plotlist = plot_list , ncol = 7, nrow = 8, labels = state_list)

allPlots

# may want to save manually with width 2000 via export function

ggsave(paste("plot_test.png"), plot = allPlots, device = "png",
       path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/plots",
       dpi = 300, width = 2000, height = 1770, units = "px")




# hearing 

for (i in 2:ncol(data1)) {
  plot1 <- ggplot(data1, aes_string(x = colnames(data1)[1], 
                                    y = colnames(data1)[i], group = 1)) + 
    geom_line() +
    scale_x_date() +
    geom_vline(xintercept=data1$Date[33], color = "blue") +
    annotate("text", x = data1$Date[29], y = 100, label = "Aug 16", 
             colour = "blue", angle = 0) +
    labs(title = paste(names(data1)[i]," - \'hearing\'"), subtitle = "2022-07-15 2022-9-12, daily", 
         caption = "Data from Google Trends", y = "Search Intensity", x = "") 
  plot1
  ggsave(paste("plot_",names(data1)[i],".png"), plot = plot1, device = "png", 
         path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/plots", 
         dpi = 300)
}

# hearing loss

for (i in 2:ncol(data1)) {
  plot1 <- ggplot(data1, aes_string(x = colnames(data1)[1], 
                                    y = colnames(data1)[i], group = 1)) + 
    geom_line() +
    scale_x_date() +
    geom_vline(xintercept=data1$Date[33], color = "blue") +
    annotate("text", x = data1$Date[29], y = 100, label = "Aug 16", 
             colour = "blue", angle = 0) +
    labs(title = paste(names(data1)[i]," - \'hearing loss\'"), subtitle = "2022-07-15 2022-9-12, daily", 
         caption = "Data from Google Trends", y = "Search Intensity", x = "") 
  plot1
  ggsave(paste("plot_",names(data1)[i],".png"), plot = plot1, device = "png", 
         path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/plots", 
         dpi = 300)
}

# hearing test

for (i in 2:ncol(data1)) {
  plot1 <- ggplot(data1, aes_string(x = colnames(data1)[1], 
                                    y = colnames(data1)[i], group = 1)) + 
    geom_line() +
    scale_x_date() +
    geom_vline(xintercept=data1$Date[33], color = "blue") +
    annotate("text", x = data1$Date[29], y = 100, label = "Aug 16", 
             colour = "blue", angle = 0) +
    labs(title = paste(names(data1)[i]," - \'hearing test\'"), subtitle = "2022-07-15 2022-9-12, daily", 
         caption = "Data from Google Trends", y = "Search Intensity", x = "") 
  plot1
  ggsave(paste("plot_",names(data1)[i],".png"), plot = plot1, device = "png", 
         path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/plots", 
         dpi = 300)
}
