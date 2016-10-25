install.packages("R330")
library(R330)
data(wine.df)

model1 <- lm(price ~ year + temp + h.rain + w.rain + h.rain:w.rain, wine.df)
summary(model1)
drop1(model1, test = "F")
coef(model1)[4] + 800 * coef(model1)[6]

predict(model1, data.frame(year = 1985, temp = mean(wine.df$temp), h.rain = mean(wine.df$h.rain), w.rain = mean(wine.df$w.rain)))

model2 <- lm(log(price) ~ year + temp + h.rain + w.rain + h.rain:w.rain, data = wine.df)
summary(model2)
drop1(model2, test = "F")
model2 <- update(model2, ~ . - h.rain:w.rain)
summary(model2)
exp(predict(model2, data.frame(year = 1985, temp = mean(wine.df$temp), h.rain = mean(wine.df$h.rain), w.rain = mean(wine.df$w.rain))))

par(mfrow = c(1, 2))
g <- function(x) { dnorm(x, sd = sd(model1$res)) }
hist(model1$res, probability = TRUE)
curve(g, col = "red", lwd = 3, add = TRUE)
hist(model2$res, probability = TRUE)
g <- function(x) { dnorm(x, sd = sd(model2$res)) }
curve(g, col = "red", lwd = 3, add = TRUE)