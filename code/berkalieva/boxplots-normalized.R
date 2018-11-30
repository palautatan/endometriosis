
# look at the PROBESETS
par(mfrow=c(2,3))
boxplot(non_normalized,
        main = "Non-normalized")
boxplot(normalized_quantile,
        main = "Normalized Quantile")
boxplot(t(t_normalized_quantile),
        main = "t-Normalized Quantile")
boxplot(normalized_loess,
        main = "Normalized LOESS")
boxplot(normalized_scale,
        main = "Normalized Scale")
boxplot(genes)
 

# look at CUT_1
par(mfrow=c(2,3))
boxplot(non_norm_cut,
        main = "Non-normalized")
boxplot(cut_quantile,
        main = "Normalized Quantile")
boxplot(t(t_cut_quantile),
        main = "t-Normalized Quantile")
boxplot(cut_loess,
        main = "Normalized LOESS")
boxplot(cut_scale,
        main = "Normalized Scale")
boxplot(genes)


par(mfrow=c(1,2))
boxplot(t(non_norm_cut),
        main = "Non-normalized")
boxplot(t(genes),
        main = "FigShare Sample")



