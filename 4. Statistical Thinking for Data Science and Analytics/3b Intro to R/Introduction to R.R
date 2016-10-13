# Basic operations
print(2 + 3)
print(3 ^ 2)
print(4 / 2)
print(log(10))
print(sin(pi / 3))
x = c(3, 1, 4, 2, 1, 4, 5, 1,4)
print(length(x))
print(mean(x))
table(x)

# Load an R dataset
data("InsectSprays")
print(dim(InsectSprays))
table(InsectSprays[, "spray"])
pie(table(InsectSprays[,"spray"]))
summary(InsectSprays[,"count"])
hist(InsectSprays[,"count"], xlab = "Insect Counts", main = "")