library(tidyverse)
library(broom)
library(MASS)

mortality_by_latitude <- read_csv("Formative Assessment 4/mortality_by_latitude.csv")
mort_v_temp <- ggplot(mortality_by_latitude,aes(x=mortality_index,y=temperature))+
  geom_point()+
  labs(
    title = "Mortality Index Vs Avg. Temperature"
  )+
  geom_smooth(method = "lm",formula = y ~ poly(x, 2), color = "blue", se = FALSE,fullrange = TRUE) +
  xlab("Mortality Index")+
  ylab("Average Temperature")+
  theme_minimal()
mort_v_temp

mort_v_temp_modified <- ggplot(mortality_by_latitude,aes(x=sqrt(mortality_index),y=temperature))+
  geom_point()+
  labs(
    title = "Mortality Index (Square Root Transformation) Vs Avg. Temperature"
  )+
  geom_smooth(method = "lm",formula = y ~ poly(x, 2), color = "blue", se = FALSE,fullrange = TRUE) +
  xlab("Mortality Index")+
  ylab("Average Temperature")+
  theme_minimal()
mort_v_temp_modified

lm_model <- lm(sqrt(mortality_index) ~ temperature, data = mortality_by_latitude)
tidy(lm_model)
augment(lm_model)
glance(lm_model)

resid_plot <- ggplot(augment(lm_model)) + 
  geom_point(aes(x = `sqrt(mortality_index)`, y = .resid))+
  labs(
    title = "Mortality Index (Square Root Transformation) Vs Residuals"
  )+
  xlab("Mortality Index")+
  ylab("Residuals")
resid_plot

bc <- boxcox(mortality_by_latitude$temperature ~ mortality_by_latitude$mortality_index)
best_lambda <- bc$x[which.max(bc$y)]
print(best_lambda)

mortality_by_latitude<- mortality_by_latitude %>% 
  mutate(
    "transformed_temp" = (mortality_by_latitude$temperature^best_lambda - 1) / best_lambda
  ) %>% 
  select(-transformed_mortality)
