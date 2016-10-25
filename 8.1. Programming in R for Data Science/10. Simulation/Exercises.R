# 10.1
par(mfrow = c(3, 3))
for (i in 1:9) {
    hist(rnorm(25), probability = TRUE, main = paste("Histogram ", i))
    curve(dnorm, add = TRUE, col = "red", lwd = 3)
}

# 10.2
par(mfrow = c(2, 1))
ozone <- airquality$Ozone[!is.na(airquality$Ozone) & airquality$Ozone > 1]
mean.1 <- mean(ozone)
sd.1 <- sd(ozone)
simulated.1 <- rnorm(length(ozone), mean = mean.1, sd = sd.1)
qqplot(simulated.1, ozone)
lines(0:200, 0:200, type = "l", lwd = 3, col = "red")

mean.2 <- mean(log(ozone))
sd.2 <- sd(log(ozone))
simulated.2 <- rnorm(115, mean = mean.2, sd = sd.2)
qqplot(exp(simulated.2), ozone)
lines(0:200, 0:200, type = "l", lwd = 3, col = "red")

# 10.3
par(mfrow = c(1, 1))
simulate.dice <- function() {
    x <- sum(sample(1:6, 2, replace = TRUE))
    y <- sum(sample(1:6, x, replace = TRUE))
    y
}

y.values <- replicate(1000, simulate.dice())
hist(y.values)