#Create an anova dataset:
# - n_samples (int): Number of samples per group.
# - means (num or vector of num): Mean(s) of the dv in the groups. Specify one for all groups or one for each group.
# - sds (num or vector of num): Standard deviation(s) of the dv in the groups. Specify one for all groups or one for each group.
#The dv will be i.i.d normally distributed with the respective means and sds.
anova_dataset <- function(n_samples=10000, means=5, sds=5){
  #coerce to vectors
  means <- c(means)
  sds <-  c(sds)
  
  #get amount of groups
  n_groups <- max(length(means), length(sds))
  
  #draw scores (draws iteratively over the mean/sd vector)
  scores <- rnorm(n=n_samples*n_groups, mean=means, sd=sds)
  
  #make groups
  groups <- rep(1:n_groups, times=n_samples)
  
  #make ids
  ids <- seq(1,n_groups*n_samples)
  
  #combine into dataset
  anova_dataset <- data.frame(id=as.factor(ids), group=as.factor(groups), score=scores)
  
  return(anova_dataset)
}

#Create homogenous and heterogenous dataset with three groups each
#means: c(5, 10, 15)
#sds: hom: c(2, 2, 2) / het: c(2, 4, 6)
het <- anova_dataset(n_samples=1000, means=c(5,10,15), sds=c(2,4,6))
hom <- anova_dataset(n_samples=1000, means=c(5,10,15), sds=2)

#anova for each dataset
aov_hom <- aov(score ~ group, data=hom)
aov_het <- aov(score ~ group, data=het)
summary(aov_hom)
summary(aov_het)

