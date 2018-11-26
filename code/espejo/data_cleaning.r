
library(tidyverse)

clean_af <- read_csv("../../data/genbank/series.csv")
head(clean_af)

test <- t(clean_af)
test <- data.frame(test)

names(test) <- unlist(test[1,])
test <- test[-1,]
head(test)

dim(test)

# write.csv(test, "../../data/clean/series_clean.csv")

metadata <- read_csv("../../data/genbank/sample_metadata.csv")

metadata <- rbind(names(metadata), metadata)
class(metadata)

names(metadata) <- c("attribute", metadata[2,2:ncol(metadata)])

metadata <- t(metadata[-2,])
metadata <- data.frame(metadata)
names(metadata) <- unlist(metadata[1,])
names(metadata) <- gsub("!", "", names(metadata))
metadata <- metadata[-1,]

names(metadata)[which(grepl("Sample_characteristics_ch1", names(metadata)))] <- paste0("Sample_characteristics_ch1_", 1:3)

head(metadata)

names(metadata)

desired_metadata <- metadata %>% select(Sample_characteristics_ch1_1, Sample_characteristics_ch1_2, Sample_characteristics_ch1_3)
# desired_metadata

desired_metadata <- desired_metadata %>% rename(tissue=Sample_characteristics_ch1_1,
                            endometriosis=Sample_characteristics_ch1_2,
                            severity=Sample_characteristics_ch1_3)

desired_metadata$tissue <- gsub("tissue: ", "", desired_metadata$tissue)

desired_metadata$endometriosis <- gsub("endometriosis/no endometriosis: ", "", desired_metadata$endometriosis)

desired_metadata$severity <- gsub("endometriosis severity: ", "", desired_metadata$severity)
desired_metadata$severity <- gsub("presence or absence of uterine/pelvic pathology: ", "", desired_metadata$severity)

head(desired_metadata)

# write.csv(desired_metadata, "../../data/clean/metadata.csv")

series <- test
dim(test)

table(desired_metadata_2[,2:3])

merged_df <- merge(desired_metadata, test, by=0, all=TRUE)

names(merged_df)[1] <- "sample"

head(merged_df)

# write.csv(merged_df, "../../data/clean/endometriosis.csv")

ix <- sample(x=1:ncol(merged_df), size=100, replace=FALSE)

# ix

small_subset <-merged_df[,c(1:4,ix)]

# write.csv(small_subset, "../../data/clean/small_subset.csv")
