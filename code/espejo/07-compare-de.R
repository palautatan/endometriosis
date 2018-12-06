from_tf <- as.character(core_df %>% pull(X1))
from_mw <- as.character(df$gene)
length(from_mw)

five_a <- read.csv("../../data/tamaresis/table-5a.csv")
five_b <- read.csv("../../data/tamaresis/table-5b.csv")
tamaresis <- c(as.character(five_a$Gene.Symbol), as.character(five_b$Gene.Symbol))

# tamaresis <- c(as.character(five_a$Probe.Set.ID), as.character(five_b$Probe.Set.ID))
length(unique(tamaresis))

length(intersect(from_tf, tamaresis)) / length(from_tf)
length(intersect(from_mw, tamaresis)) / length(from_mw)

length(intersect(from_tf, from_mw))
length(from_mw)
length(from_tf)
