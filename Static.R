

# Working a bit with the original data
library(tidyverse)
library("vtable")
library(doBy)


load('riskall.rdata')

risk.all <- risk.all %>%
  filter(region %in% c("2", "3", "4" ,"6" )) %>%
  mutate(region2 = recode(region, `2` = "A" , `3` = "B",  `4` = "C", `6` = "D")) %>% 
  select(ident, AR, annee,  region2, years)


risk.sum <- summaryBy(AR~years, data = risk.all,
                      FUN = function(x) { c(med = median(x, na.rm=TRUE),
                                            mean = mean(x),
                                            sd= quantile(x,probs= c(0.05,0.95), names= FALSE, na.rm=TRUE)) } )

labs <- c('Index (Median)',
          'Index (Sd-)',
          "Index (Sd+)")

st(risk.sum,
   vars = c("AR.med" ,"AR.sd1", "AR.sd2"),
   group = "years",
   summ = "mean(x)",
   labels=labs,
   summ.names = "-", 
   digit= 2)

save(risk.all, risk.sum, file = "data/risksmall.Rdata")
