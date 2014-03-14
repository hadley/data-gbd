library(dplyr)
library(ggplot2)

deaths <- readRDS("deaths.rds")

# Currently not accurate because deaths being double (or more) counted
top_deaths <- deaths %.% group_by(cause) %.% tally(sort = T) 
qplot(n, data = top_deaths) + scale_x_log10()

# Look at individual diseases
deaths %.% 
  filter(cause == "Non-communicable diseases") %.%  
  ggplot(aes(age, rt, group = sex)) + 
  geom_ribbon(aes(ymin = rt_lower, ymax = rt_upper), fill = "grey50", alpha = 0.5) + 
  geom_line(aes(colour = sex))

deaths %.% 
  filter(cause == "Road injury") %.%  
  ggplot(aes(age, rt, group = sex)) + 
  geom_ribbon(aes(ymin = rt_lower, ymax = rt_upper), fill = "grey50", alpha = 0.5) + 
  geom_line(aes(colour = sex))

