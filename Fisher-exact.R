library(rstatix)

# Delivery mode stats
#####################
# Fisher exact test on contigency tables 2x2
# Input matrix in csv:
#Delivery	CS	NVD
#Nonprobiotic	17	2
#Probiotic	8	7

matrix <- as.matrix(read.csv("Deliverymode.csv",header=TRUE, 
                             row.names=1))
matrix
#fisher_test(matrix,alternative="two.sided")
pairwise_fisher_test(matrix,alternative="two.sided",p.adjust.method="bonferroni")

#  group1       group2        n      p  p.adj p.adj.signif
#* <chr>        <chr>     <int>  <dbl>  <dbl> <chr>       
#1 Nonprobiotic Probiotic    34 0.0252 0.0252 *   
