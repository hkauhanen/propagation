source("simulations.R")

set.seed(123)

write.csv(afewsimus(), "results.csv", row.names=FALSE, quote=FALSE)
