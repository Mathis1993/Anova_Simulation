#Create an anova dataset:
  # - n_groups (int): How many groups we want to have.
  # - n_samples (int): Number of samples per group.
  # - homogenous (bool): If we want homogenous or heterogenous variances between the groups.
  # - first_mean (int): Mean of the dv in the first group. The mean in the second group will be two times the one in the first group . The mean in the third group will be three times the on in the first group (and so on).
  # - first_sd (int): Sd of the dv all groups (if homogenous=T) or sd of the dv in the first group. The sd in the second group will be two times the one in the first group. The sd in the third group will be three times the one in the first group (and so on; if homogenous=F).
#The dv will be i.i.d normally distributed with the respective means and sds.
anova_dataset <- function(n_groups=3, n_samples=10000, homogenous=T, first_mean=5, first_sd=2){
  means <-c(seq(first_mean, n_groups*first_mean, by=first_mean))
  
  if(homogenous){
    sds <- rep(first_sd, times=n_groups)
  }else{
    sds <- c(seq(first_sd, n_groups*first_sd, by=first_sd))
  }
  
  scores <- mapply(function(mean,sd)rnorm(n=n_samples, mean=mean, sd=sd), means, sds)
  scores <- as.vector(scores)
  groups <- rep(1:n_groups, each=n_samples)
  ids <- seq(1,n_groups*n_samples)
  anova_dataset <- data.frame(id=as.factor(ids), group=as.factor(groups), score=scores)
  
  return(anova_dataset)
}

#Create homogenous and heterogenous dataset with three groups each
#means: c(5, 10, 15)
#sds: hom: c(2, 2, 2) / het: c(2, 4, 6)
hom <- anova_dataset(n_groups=3, homogenous=T)
het <- anova_dataset(n_groups=3, homogenous=F)

#anova for each dataset
aov_hom <- aov(score ~ group, data=hom)
aov_het <- aov(score ~ group, data=het)
summary(aov_hom)
summary(aov_het)
