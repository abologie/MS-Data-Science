# 9.1
tapply(presidents, cycle(presidents), mean, na.rm = TRUE)

# 9.2
my.cut <- cut(airquality$Wind, breaks = 2 * (1:11) - 1)
tapply(airquality$Solar.R, my.cut, mean, na.rm = TRUE)

# 9.3
my.cut2 <- cut(swiss$Agriculture, breaks = 10 * (0:10))
my.cut3 <- cut(swiss$Catholic, breaks = 10 * (0:10))
tapply(swiss$Fertility, list(my.cut2, my.cut3), mean)