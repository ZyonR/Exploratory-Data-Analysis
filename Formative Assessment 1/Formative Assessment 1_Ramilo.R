library(readr)
library(tidyverse)
library(gridExtra)

cytof_one_experiment <- read_csv("Data/cytof_one_experiment.csv")

view(cytof_one_experiment)
ecdf_granztmeb <- ggplot(cytof_one_experiment,aes(cytof_one_experiment$GranzymeB)) +
  stat_ecdf(geom = "step")+
  labs(title = "ECDF of GranztmeB Protien Activation")+
  xlab("GranztmeB Protien Activation")

hist_granztmeb <- ggplot(cytof_one_experiment,aes(cytof_one_experiment$GranzymeB)) +
  geom_histogram(binwidth = 0.01)+
  labs(title = "Histogram of GranztmeB Protien Activation")+
  xlab("GranztmeB Protien Activation")

granztmeBPlot <- ggplot(cytof_one_experiment,aes(sample = cytof_one_experiment$GranzymeB)) +
                    stat_qq() +
                    stat_qq_line()+
                    labs(title = "QQ plot of GranztmeB Protien")+
                    xlab("GranztmeB Protien Activation")

cd69Plot <- ggplot(cytof_one_experiment,aes(sample = cytof_one_experiment$CD69)) +
                    stat_qq() +
                    stat_qq_line()+
                    labs(title = "QQ plot of CD69 Protien")+
                    xlab("CD69 Protien Activation")
qqplot_granztmeb_vs_cd69 <- grid.arrange(granztmeBPlot, cd69Plot, ncol = 2, 
             widths = c(1, 1),      # Adjust width of each plot
             heights = c(1),        # Adjust height of plots
             padding = unit(1, "cm")) 

ggsave("ecdf_granztmeb.png", plot = ecdf_granztmeb, width = 8, height = 6)
ggsave("hist_granztmeb.png", plot = hist_granztmeb, width = 8, height = 6)
ggsave("qqplot_granztmeb_vs_cd69.png", plot = qqplot_granztmeb_vs_cd69, width = 8, height = 6)

