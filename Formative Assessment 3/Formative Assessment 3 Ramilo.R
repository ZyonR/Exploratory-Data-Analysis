library(tidyverse)

ggplot(diamonds,aes(x=carat))+
  geom_histogram()+
  labs(
    title = "Frequency per Carat"
  )+
  ylab("Frequency")

# Rewrite the ggplot function into a layer version

ggplot(diamonds)+
  layer(
    geom = GeomBar, stat = StatBin, position = PositionStack,
    params = list(binwidth = 0.1, na.rm = FALSE),
    mapping = aes(x=carat)
  )+
  labs(
    title = "Frequency per Carat",
    subtitle = "Histogram"
  )+
  ylab("Frequency")+
  xlab("Carat")

ggplot(diamonds)+
  layer(
    geom = GeomPoint, stat = "identity", position = "identity",
    params = list(na.rm = FALSE),
    mapping = aes(x=carat,y=price)
  )+
  labs(
    title = "Price per Carat",
    subtitle = "Scatterplot "
  )+
  ylab("Price")+
  xlab("Carat")

ggplot(diamonds,aes(x=carat,y=price))+
  layer(
    geom = GeomLine, stat = "identity", position = "identity",
    params = list(na.rm = FALSE),
    mapping = aes(x=carat,y=price)
  )+
  labs(
    title = "Price per Carat",
    subtitle = "Line Plot"
  )+
  ylab("Price")+
  xlab("Carat")


