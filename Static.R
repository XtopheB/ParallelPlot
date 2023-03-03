


library(tidyverse)
library("vtable")

load("riskall.RData")
st(risk.all)

risk.all <- risk.all %>%
  filter(region %in% c("2", "3", "4" ,"6" ))

save(risk.all, file = "riskSmall.Rdata")
