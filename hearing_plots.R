# Example plots for google trends data

library(dplyr)
library(ggplot2)


# Import data from CSV files

data1 <- read.csv("/Users/reginaldhebert/Documents/myrepo/hearingCSV/2021-22_annual.csv", header = TRUE)
data2 <- read.csv("/Users/reginaldhebert/Documents/myrepo/hearingCSV/2021-9.csv", header = TRUE)
data3 <- read.csv("/Users/reginaldhebert/Documents/myrepo/hearingCSV/2022-7.csv", header = TRUE)

# rename variables and convert from string to date format

data1 <- data1 %>% rename_at(1, ~'Date')
data1 <- data1 %>% rename_at(2, ~'Search_Intensity')
data1$Date <- as.Date(data1$Date, format="%m/%d/%y")

data2 <- data2 %>% rename_at(1, ~'Date')
data2 <- data2 %>% rename_at(2, ~'Search_Intensity')
data2$Date <- as.Date(data2$Date, format="%m/%d/%y")

data3 <- data3 %>% rename_at(1, ~'Date')
data3 <- data3 %>% rename_at(2, ~'Search_Intensity')
data3$Date <- as.Date(data3$Date, format="%m/%d/%y")


# generate plots and save

plot1 <- ggplot(data1, aes(x = Date, y = Search_Intensity)) + 
          geom_line() +
          geom_vline(xintercept=data1$Date[7], color = "blue") +
          annotate("text", x = data1$Date[6], y = 65, label = data1$Date[6], colour = "blue", angle = 90) +
          geom_vline(xintercept=data1$Date[34], color = "blue") +
          annotate("text", x = data1$Date[33], y = 90, label = data1$Date[34], colour = "blue", angle = 90) +
          geom_vline(xintercept=data1$Date[50], color = "blue") +
          annotate("text", x = data1$Date[49], y = 65, label = data1$Date[50], colour = "blue", angle = 90) +
          labs(title = "Search activity for \"Hearing Aid\" topic", subtitle = "All US States, 2021-09-05 to 2022-08-28, weekly", 
               caption = "Data from Google Trends")
plot1

ggsave("plot1.png", plot = plot1, device = "png", path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/", dpi = 300)

plot2 <-  ggplot(data2, aes(x = Date, y = Search_Intensity)) + 
          geom_line() +
          geom_vline(xintercept=data2$Date[36], color = "blue") +
          annotate("text", x = data2$Date[35], y = 65, label = data2$Date[36], colour = "blue", angle = 90) +
          labs(title = "Search activity for \"Hearing Aid\" topic", subtitle = "All US States, 2021-09-01 to 2021-11-30, daily", 
              caption = "Data from Google Trends")
plot2

ggsave("plot2.png", plot = plot2, device = "png", path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/", dpi = 300)

plot3 <-  ggplot(data3, aes(x = Date, y = Search_Intensity)) + 
          geom_line() +
          geom_vline(xintercept=data3$Date[48], color = "blue") +
          annotate("text", x = data3$Date[44], y = 65, label = data3$Date[48], colour = "blue", angle = 90) +
          labs(title = "Search activity for \"Hearing Aid\" topic", subtitle = "All US States, 2022-07-01 to 2022-9-01, daily", 
               caption = "Data from Google Trends")
plot3

ggsave("plot3.png", plot = plot3, device = "png", path = "/Users/reginaldhebert/Documents/myrepo/hearingCSV/", dpi = 300)
