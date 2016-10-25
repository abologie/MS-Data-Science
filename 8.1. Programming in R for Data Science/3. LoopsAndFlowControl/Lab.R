k <- 1000
r <- 100
set.seed(5556)
x <- as.data.frame(matrix(rnorm(r * k), nrow = r))

my.summary <- matrix(nrow = 4, ncol = k)
for (i in 1:k) {
    my.summary[1, i] <- min(x[, i])
    my.summary[2, i] <- median(x[, i])
    my.summary[3, i] <- mean(x[, i])
    my.summary[4, i] <- max(x[, i])
}

my.function <- function(x) {
    return(c(min(x), median(x), mean(x), max(x)))
}

sapply(x, my.function)