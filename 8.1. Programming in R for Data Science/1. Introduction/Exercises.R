# 1.1
mean(exp(rnorm(1000)))

# 1.2
a <- 1
b <- 3
c <- 1
roots <- c(( - b + sqrt(b ^ 2 - 4 * a * c)) / (2 * a), ( - b - sqrt(b ^ 2 - 4 * a * c)) / (2 * a))

# 1.3
set.seed(1234)
x <- rnorm(100, mean = .5, sd = .3)
hist(x, axes = FALSE)
axis(1)
axis(4)