# 2.1
paste("R session", 1)
data.frame(1:3) + 5
data.frame(x = 1:3, y = c("a", "b", "c")) + 5

# 2.2
standardize.values <- function(x) {
    mean.x <- mean(x)
    sd.x <- sd(x)
    (x - mean.x) / sd.x
}

# 2.3
f <- function(x) {
    3 * sin(x / 2) + x
}

curve(f, -7, 7)