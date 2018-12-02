getwd()
test1 <- read.csv("small_subset.csv")
View(test1)

#EDA BEFORE ANY NORMALIZATIONS  

ncol(test1) #number of columns
ncol(test1[,-c(1:5)]) #number of genes after excluding sample meta data columns 
nrow(test1) #number of samples 
sum(is.na(test1)) #Perfect! no missing values 

library(dplyr)

count(group_by(test1, severity)) #number of samples in each category 

#1 Minimal/Mild: 28
#2 Moderate/Severe: 49
#3 No Uterine Pelvic Pathology: 34
#4 Uterine Pelvic Pathology: 37

#pca1 analysis to see variation of genes across samples 
pca1 <- prcomp(test1[,-c(1:5)]) #pca for all columns except the sample meta data 
plot(pca1) 
barplot(pca1$rotation)

#pretty plot to show pca1 
library(ggfortify)
autoplot(pca1, data = test1, colour="severity")

#this doesn't make any sense but I wanted to try it 
boxplot(test1[,6]~severity, data=test1)
str(test1)


#Affy, gcRMA and limma 
# First set wd of the place where all CEL files are stored 
source("http://www.bioconductor.org/biocLite.R")
biocLite("limma")
biocLite("affy")
biocLite("gcrma")
biocLite("hgu133plus2.db") #probeset database from Affymetrix for the Affymetrix platform that was used in the microarray analysis

getwd() #Be where your CEL files are and this folder should only contain CEL files 
library(affy)
Endo_testcel <- ReadAffy() #This step takes f*ing forever 

library(gcrma)
#Un-normalized data and EDA 
eset_unnormalized <- gcrma(Endo_testcel, normalize=FALSE)
unnorm.data <- exprs(eset_unnormalized)
#count the number of rows in the eset output data 
dim(unnorm.data) 

#Normalized data and EDA 
eset <- gcrma(Endo_testcel, normalize = TRUE) #creating an expression set of the data using gcrma 
norm.data <- exprs(eset) #This is my data after picking out the epxression assay data out of the eset created 
#count the number of rows in the eset normalized output data 
dim(eset)
class(eset)
dim(norm.data) 
class(norm.data)

#summary statistics of gcRMA normalization
table(summary(norm.data))

#side by side plots of un-normalized and normalized data 
par(mfrow=c(1,2))
plot1<- boxplot(unnorm.data, las=2, cex.axis=0.6, ylab="log2 GeneExp", main= "gcRMA un-normalized data")
plot2<- boxplot(norm.data, las=2, cex.axis=0.6, ylab="log2 GeneExp", main="gcRMA normalized data")

#Trying out RMA normalization which uses log2 values 
eset_rma <- rma(Endo_testcel)
e_rma <- exprs(eset_rma)

#count the number of unique rows to check if there are duplicate probes 
length(unique(rownames(norm.data))) #Great! All probes are unique values 

#outpt the normalized data into .csv 

write.table(norm.data,file="NormalR.csv",sep=",",row.names=TRUE, quote=FALSE) 
normalR <- read.csv("NormalR.csv")
View(normalR)





