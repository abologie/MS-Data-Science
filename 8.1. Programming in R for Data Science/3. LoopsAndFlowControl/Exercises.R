# 3.1
set.seed(1786)
data.exercise.3.1 <- exp(matrix(rnorm(2000), nrow = 100))
index1.temp <- sample(1:100, 10)
index2.temp <- sample(1:20, 10)
for (i in 1:10) {
    data.exercise.3.1[index1.temp[i], index2.temp[i]] <- -1
}

my.data <- data.exercise.3.1
neg.numbers <- 0
for (i in 1:length(my.data[, 1])) {
    row.neg.numbers <- (min(my.data[i,]) < 0)
    neg.numbers <- neg.numbers + row.neg.numbers
    if (neg.numbers <= 3 & !row.neg.numbers) {
        cat("The mean of row", i, "is", mean(my.data[i,]), "\n")
    }
    if (neg.numbers <= 3 & row.neg.numbers) {
        cat("<Row", str(i), "contains negative values>\n")
    }
    if (neg.numbers > 3) {
        cat("Too many negative values\n")
        break
    }
}

# 3.2
k <- 10
y <- matrix(rnorm(k ^ 2), nrow = k)
z <- 0 * y

#loop:
time1 <- as.numeric(Sys.time())
for (i in 1:k) {
    #loop:
    for (j in 1:k) {
        z[i, j] <- y[i, j] ^ 2
    }
}

time2 <- as.numeric(Sys.time())
# using object form in R:
time3 <- as.numeric(Sys.time())
# using object form in R:
z <- y ^ 2
time4 <- as.numeric(Sys.time())
# run time increase factor:
(time2 - time1) / (time4 - time3)

options(digits.secs = 20)
dimensions <- c(10, 20, 50, 100, 200, 500, 800, 1000)
runtime.factors <- numeric(length(dimensions))
for (r in 1:length(dimensions)) {
    k <- dimensions[r]
    y <- matrix(rnorm(k ^ 2), nrow = k)
    z <- 0 * y
    time1 <- as.numeric(Sys.time())
    for (i in 1:k) {
        for (j in 1:k) {
            z[i, j] <- y[i, j] ^ 2
        }
    }
    time2 <- as.numeric(Sys.time())

    time3 <- as.numeric(Sys.time())
    z <- y ^ 2
    time4 <- as.numeric(Sys.time())
    runtime.factors[r] <- (time2 - time1) / (time4 - time3)
}

plot(dimensions ^ 2, runtime.factors, log = "xy", xlab = "Number of operations")

# 3.3
rows <- 10
cols <- 100000
data <- as.data.frame(matrix(rnorm(rows * cols), nrow = rows))

mean1 <- numeric(cols)
mean2 <- numeric(cols)

time1 <- as.numeric(Sys.time())
for (i in 1:cols) {
    mean1[i] <- mean(data[, i])
}

time2 <- as.numeric(Sys.time())

time3 <- as.numeric(Sys.time())
mean2 <- sapply(data, mean)
time4 <- as.numeric(Sys.time())
(time2 - time1) / (time4 - time3)