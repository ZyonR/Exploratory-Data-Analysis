library(readr)
library(tidyverse)
cytof_one_experiment <- read_csv("Data/cytof_one_experiment.csv")

view(cytof_one_experiment)
ggplot(cytof_one_experiment,aes(cytof_one_experiment$GranzymeB)) +
  stat_ecdf(geom = "step")+
  labs(title = "ECDF of GranztmeB Protien Activation")+
  xlab("GranztmeB Protien Activation")


