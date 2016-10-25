# 6.1
set.seed(9007)
my.data <- data.frame(x = rnorm(10), y = rnorm(10) + 5, z = rchisq(10, 1))
additional.data <- data.frame(x = rnorm(3), y = rnorm(3) + 5, z = rchisq(3, 1))
file.name <- "Exercise 6.1.txt"
write.table(my.data, file.name, row.names = FALSE, col.names = FALSE)
write.table(additional.data, file.name, row.names = FALSE, col.names = FALSE, append = TRUE)

# 6.2
set.seed(45)
my.data <- data.frame(x = rnorm(10), y = rnorm(10), z = rnorm(10))
write.csv2(my.data, "Exercise 6.2.csv")

# 6.3
my.data <- data.frame(a = LETTERS[1:5], b = 1:5)
write.table(my.data, file = "Exercise 6.3 a.txt", sep = ";", row.names = FALSE)
my.text <- "TITLE extra line\n2 3 5 7\n11 13 17 \nOne more line"
writeLines(my.text, con = "Exercise 6.3b.txt")

# 6.4
set.seed(45)
my.data <- data.frame(x = rnorm(10), y = rnorm(10), z = rnorm(10))
save(my.data, file = "Exercise 6.4.Rdata")
rm(my.data)
load("Exercise 6.4.Rdata")
my.data