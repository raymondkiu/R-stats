setwd("~/Figure-R/")
library(rstatix)
library(dplyr)


# Mean birth weight
###################
# Stats - wanted to use t-test for mean birth weight
data <- read.csv("Mean-birth-weight.csv", header = TRUE, stringsAsFactors = TRUE)
data

# data input in csv:
#Group Birthweight
#Nonprobiotic	1230
#Nonprobiotic	1340
#Nonprobiotic	1370
#Nonprobiotic	1380
#Probiotic	1384
#Probiotic	1400
#Probiotic	1425
#Probiotic	1230
#Probiotic	940
#Probiotic	1374

# assumption 1: two groups of samples are independent - yes, not related because they are different individuals
# assumption 2: are the data following normal distribution - use Shapiro test

# Shapiro-Wilk normality test for Men's weights
with(data, shapiro.test(Birthweight[Group == "Nonprobiotic"]))# p = 0.1
# Shapiro-Wilk normality test for Women's weights
with(data, shapiro.test(Birthweight[Group == "Probiotic"])) # p = 0.6

# outcome:
#Shapiro-Wilk normality test

#data:  Birthweight[Group == "Probiotic"]
#W = 0.81197, p-value = 0.005257
# so Probiotic group has significant P-value which means they are different from normal distribution - suggest use Wilxocon test, if not use t-test

# Since data are not normally distributed - use Wilcoxon test also called Mann-whitney Test
pairwise_wilcox_test(Birthweight ~ Group, data = data, conf.level = 0.95,paired = FALSE,exact = FALSE, alternative="two.sided",p.adjust.method="bonferroni")

#  .y.         group1       group2       n1    n2 statistic     p p.adj p.adj.signif
#* <chr>       <chr>        <chr>     <int> <int>     <dbl> <dbl> <dbl> <chr>       
#1 Birthweight Nonprobiotic Probiotic    19    15      51.5 0.002 0.002 **   

data %>%  group_by(Group) %>% 
  summarise(
    count = n(), 
    mean = mean(Birthweight),
    sd = sd(Birthweight)
  )
data %>%  group_by(Group) %>% summarise(quantile=quantile(Birthweight))  %>% as.data.frame()# to get IQR

