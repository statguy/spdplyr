library(maptools)
data(wrld_simpl)
library(spbabel)
library(dplyr)
xtab <- spbabel::sptable(wrld_simpl)
abline(v = 90, h = 0)
seindex <- dplyr::filter(xtab, x_ > 100 & y_ < 0) %>% distinct(object_)
seatt <- seindex %>% inner_join(as.data.frame(wrld_simpl) %>% mutate(object_ = row_number()))
semap <- xtab %>% filter(object_ %in% seatt$object_)

spmap <- sp(semap, attr_tab = seatt, crs = "+proj=longlat +ellps=WGS84")
devtools::use_data(spmap)
