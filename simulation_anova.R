#Create an anova dataset:
# - n_samples (int or vector of int): Number of samples per group. Specify one for all groups or one for each group (as a vector).
# - means (num or vector of num): Mean(s) of the dv in the groups. Specify one for all groups or one for each group (as a vector).
# - sds (num or vector of num): Standard deviation(s) of the dv in the groups. Specify one for all groups or one for each group (as a vector).
#The dv will be i.i.d normally distributed with the respective means and sds.
anova_dataset <- function(n_samples=c(1000, 1000, 1000), means=c(5,10,15), sds=c(5,5,5)){
  #coerce to vectors
  n_samples <- c(n_samples)
  means <- c(means)
  sds <-  c(sds)
  
  #create scores: draw from normal distribtion parametrized according to each mean-/sd-value as many
  #times as specified
  scores <- mapply(function(n_sample, mean, sd)rnorm(n=n_sample,mean=mean,sd=sd),n_samples,means,sds)
  scores <- unlist(scores)
  scores <-as.vector(scores)
  
  #get amount of groups
  n_groups <- max(length(n_samples), length(means), length(sds))
  #create group labels
  groups <- mapply(function(n_sample,n_group)rep(n_group,each=n_sample),n_samples,1:n_groups)
  groups <- unlist(groups)
  groups <- as.vector(groups)
  
  #create ids
  ids <- seq(1,length(scores))
  
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

#different group sizes
sizes <- anova_dataset(n_samples=c(1000,500,700), means=c(5,5,10), sds=2)
