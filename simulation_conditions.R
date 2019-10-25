##simulation conditions
#We want to vary
# - means
# - variances
# - group sizes

#Holling's lecture: mean of cohens d over psychological meta-analyses is 0.5, sd .29 (source?!)
#So for varying means, maybe choose 
# - no effect (d=0)
# - weak effect (d=-0.08 (2 sds below the mean))
# - weaker effect (d=0.21) (1 sd below the mean)
# - average effect (d=0.5)
# - stronger effect (d=0.79) (1 sd above the mean)
# - strong effect (d=1.08) (2 sds above the mean)
#(on iq-scale)
means <- c(0, 0.08, 0.21, 0.5, 0.79, 1.08)*15+100
#OR
# - stick with conventions and choose 0.3, 0.5 and 0.8 (and 0 of course)
means_conventions <- c(0, 0.3, 0.5, 0.8)*15+100

#Vary sd in steps of 20% of the original value from 20% to 180%
sds <- seq(3,27,by=0.2*15)

#group sizes
#Marszalek, J. M., Barber, C., Kohlhart, J., & Cooper, B. H. (2011). Sample size in psychological research over the past 30 years. Perceptual and motor skills, 112(2), 331-348.
#table on p. 339: Total sample sizes in an abnormal/applied/developmental/experimental journal in the year 2006 (mean): 340, 404, 295, 26
#--> sample sizes in steps of 30 between 30 and 390?
sample_sizes <- c(seq(30,390,by=30))
#three groups
n_groups <- 3
group_sizes <- sample_sizes / n_groups

#combine all variations into one df
conditions <- expand.grid(means, sds, group_sizes)
names(conditions) <- c("mu", "sigma", "n")

#If we want to use three groups, as stated above, wouldn't we need to choose every possibility of selecting three rows from the conditions df? Wouldn't that be a bit too much?
#The dataframe probably is too big as it is already?
