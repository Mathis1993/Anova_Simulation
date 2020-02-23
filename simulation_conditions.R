# We have 3 groups in total. For group 1, values will be set, eg mean of 100, 
# sd of 15 and group size of 50.
# For our simulation conditions, we will have 6 columns per condition (per row):
# 1. mean difference of group 2 in comparison to group 1 (Cohen's d)
# 2. mean difference of group 3 in comparison to group 1 (Cohen's d)
# 3. sd ratio of group 2 in comparison to group 1
# 4. sd ratio of group 3 in comparison to group 1
# 5. group size ratio of group 2 in comparison to group 1
# 6. group size ratio of group 2 in comparison to group 1
# Conditions are build as a multichoose scenario (so we are creating multisets):
# If we specify possible mean differences of 0, 0.3 and 0.5, and we have 3 groups, so two columns
# for group differences, we will get 6 "unique combinations", so 6 multisets
# (All multisets for choosing 2 from a pool of 3:
# n+k-1 over k, so 3+2-1 over 2 = (3+2-1)!/((3+2-1 - 2)! * 2!) = 6).
# Multichoose means that a combination like 0 and 0.3 is the same as 0.3 and 0.
# Therefore, in the example from above, from 9 possible combinations, we are only interested in 
# 6 "unique combinations", so the 6 possible multisets.
# This function generates simulation conditions for the three design factors "mean_difference", 
# "sd_ratio" and "group_size" by returning all multisets where one multiset contains a difference/ratio value for the second and third group in comparison to the first group per design factor.
# (3+2-1 over 2) * (3+2-1 over 2) * (2+2-1 over 2) = 6 * 6 * 3 = 108 conditions
draw_multisets <- function(mean_diff=c(0, 0.3, 0.5), sd_ratio=c(1, 1.5, 2), group_size=c(1,2)){
  # coerce to vectors
  mean_diff = c(mean_diff)
  sd_ratio = c(sd_ratio)
  group_size = c(group_size)
  
  # all possible combinations
  comb <- expand.grid(mean_diff_2=mean_diff, mean_diff_3=mean_diff, 
                      sd_ratio_2=sd_ratio, sd_ratio_3=sd_ratio, 
                      group_size_2=group_size, group_size_3=group_size)
  # all "unique combinations" obtained by only choosing columns where the value for the first group
  # is less or equal to that of the second group per design factor
  comb_unique <- comb[comb[,1]<=comb[,2] & comb[,3]<=comb[,4] & comb[,5]<=comb[,6] , ]
  #sort output
  comb_unique <- comb_unique[order(comb_unique[,1]),]
  
  return(comb_unique)  
}

multisets <- draw_multisets()

# Potentially: Include number of groups argument 
# (How to pass a vector a variable amount of times to expand.grid())? 