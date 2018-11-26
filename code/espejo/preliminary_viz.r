
library(tidyverse)
library(reshape2)
library(plyr)
library(ggplot2)
library(scales)

this_sub <- read_csv("../../data/clean/small_subset.csv")[,-1]
head(this_sub)

ggplot(this_sub, aes(x=endometriosis)) + geom_histogram(stat="count", aes(fill=severity))

this_melt <- melt(this_sub[,c(1,5:ncol(this_sub))])

this_melt <- ddply(this_melt, .(variable), transform, rescale = rescale(value))

head(this_melt)

ggplot(this_melt, aes(variable, sample)) +
    geom_tile(aes(fill = value), colour = "white") +
    scale_fill_gradient(low = "white", high = "steelblue") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(this_melt, aes(variable, sample)) +
    geom_tile(aes(fill = rescale), colour = "white") +
    scale_fill_gradient(low = "white", high = "midnightblue") +
    xlab("probe") +
    theme(text = element_text(size=4),
          axis.text.x = element_text(angle = 90, hjust = 1))


