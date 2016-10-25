# 4.1
matrix(1:6, nrow = 3, ncol = 3)
matrix()
matrix(nrow = 3, ncol = 3)

# 4.2
x <- matrix(1:12, 4)
x[cbind(c(1, 3, 2), c(3, 3, 2))]
x[c(1, 3, 2), c(3, 3, 2)]

# 4.3
row <- matrix(rep(1:100, 100), nrow = 100)
column <- matrix(rep(1:100, 100), nrow = 100, byrow = T)
A <- 3 * column ^ 3 / (1 + row * column)
sum(A)
sum(A[row <= column])