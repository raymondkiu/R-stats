library(rstatix)

# Mean birth weight
###################
# Stats - wanted to use t-test for mean birth weight
data <- read.csv("Mean-birth-weight.csv", header = TRUE, stringsAsFactors = TRUE)
data

# data input in csv:
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
# assumption 2: are the data following normal distribution - use Shapiro test to test:

# Shapiro-Wilk normality test for Men's weights
with(data, shapiro.test(Birthweight[Group == "Nonprobiotic"]))
# Shapiro-Wilk normality test for Women's weights
with(data, shapiro.test(Birthweight[Group == "Probiotic"])) 

# If P values are not significant for both means that it is normal distribution => use t-test, but firstly test whether variances are equal as below:
var.test(Birthweight ~ Group, data = data)
# test to compare two variances

#data:  Birthweight by Group
#F = 0.85592, num df = 18, denom df = 14, p-value = 0.7445
#alternative hypothesis: true ratio of variances is not equal to 1
#95 percent confidence interval:
# 0.297248 2.307931
#sample estimates:
#ratio of variances 
#         0.8559208   => not significant => both variances are equal
# if not significant, means variances are equal, speficy this var.equal=TRUE, => use classic t-test

t_test(Birthweight ~ Group, data = data, paired = FALSE, alternative="two.sided",p.adjust.method="bonferroni", var.equal=TRUE) %>% as.data.frame()

# Use %>% as.data.frame() to show data in decimal places, as in tibbles may not show up
#  .y.         group1       group2       n1    n2 statistic    df     p
#* <chr>       <chr>        <chr>     <int> <int>     <dbl> <dbl> <dbl>
#1 Birthweight Nonprobiotic Probiotic    19    15     -1.64    32 0.112

# To generate some stats
library(dplyr)
data %>%  group_by(Group) %>% 
  summarise(
    count = n(), 
    mean = mean(Birthweight),
    sd = sd(Birthweight)
  )%>% as.data.frame()
data %>%  group_by(Group) %>% summarise(quantile=quantile(Birthweight))  %>% as.data.frame() # to get IQR
