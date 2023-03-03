


library(tidyverse)
library("vtable")

load("riskall.RData")
st(risk.all)

risk.all <- risk.all %>%
  filter(region %in% c("2", "3", "4" ,"6" ))


risk.all <- risk.all %>%
  mutate(region2 = recode(region, `2` = "A" , `3` = "B",  `4` = "C", `6` = "D"))




save(risk.all, file = "riskSmall.Rdata")
