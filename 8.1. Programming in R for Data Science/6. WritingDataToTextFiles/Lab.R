set.seed(9007)
my.data <- data.frame(x = rnorm(10), y = rnorm(10) + 5, z = rchisq(10, 1))
write.table(round(my.data, digits = 2), "Assignment 6a.txt", row.names = FALSE)
write.table(format(my.data, digits = 20), "Assignment 6b.txt", row.names = FALSE)

options(digits = 20)
my.data2 <- my.data * 10e5
write.table(my.data2, "Assignment 6c.txt", row.names = FALSE)
my.data3 <- read.table("Assignment 6c.txt", header = TRUE) / 10e5
my.data[1, 1] - my.data3[1, 1]