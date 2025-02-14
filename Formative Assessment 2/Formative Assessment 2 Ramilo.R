library(tidyverse)
cytof_one_experiment <- read_csv("Data/cytof_one_experiment.csv")

cytof_one_experiment_the_long_way <- pivot_longer(cytof_one_experiment,cols = NKp30:INFg,names_to = "Protien", values_to = "Amount")
str(cytof_one_experiment_the_long_way)

median_MAD_Data <- cytof_one_experiment_the_long_way %>% 
  group_by(Protien) %>% 
  summarize(
    "Median" = median(Amount),
    "Median Absolute Deviation" = mad(Amount,center = median(Amount))
  )
View(median_MAD_Data)
madXMedian <- ggplot(median_MAD_Data, aes(x=`Median Absolute Deviation`,y=Median))+
  geom_point()+
  labs(
    title = "MAD x Median of Protiens",
    x = "MAD",
    y = "Median"
  )+
  scale_x_continuous(breaks = seq(0,3,by=0.3))

library(dcldata)
data(example_gymnastics_2)
View(example_gymnastics_2)                     
gymnasticsDataset2 <- pivot_longer(example_gymnastics_2,cols=vault_2012:floor_2016,names_to = "Event", values_to = "Score") %>% 
  separate(Event,into=c("Event","Year"), sep="_")
View(gymnasticsDataset2)   

ggsave("madXMedian.png", plot = madXMedian, width = 8, height = 6)
