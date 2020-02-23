#MULTICHOOSE, also refered to as "bars and stars"
#https://math.stackexchange.com/questions/1356876/unique-combinations-of-7-items-repetition-allowed-order-doesnt-matter
#!!!!!!!!!!
#http://mathworld.wolfram.com/Multichoose.html

#Implementation
#https://r.789695.n4.nabble.com/generate-combination-multiset-set-with-repetition-td872728.html
# create multisets: choose 2 mean differences (for the second and third group, compared to the first one) for each condition. Get all combinations but without duplicates (the same mean differences only in another order) --> all "unique" combinations
mean_d <- c(0,0.3,0.5)
# all combinations (3*3=9)
comb <- expand.grid(mean_d, mean_d)
# only multisets: n+k-1 over k, so 3+2-1 over 2 = (3+2-1)!/((3+2-1 - 2)! * 2!) = 6
# in practice: Choose all rows, where the value in the first row is smaller or equal to the one in the second row
# all multisets by hand:
# 0   0
# 0   0.3
# 0   0.5
# 0.3 0.3
# 0.3 0.5
# 0.5 0.5
unique_comb <- comb[comb[,1]<=comb[,2] , ]
#sort (so that output looks like the example done by hand)
multisets <- unique_comb[order(unique_comb[,1]) , ]

#For two factors
comb <- expand.grid(mean_d, mean_d, c(1,1.5), c(1,1.5))
comb[comb[,1]<=comb[,2] & comb[,3]<=comb[,4], ]