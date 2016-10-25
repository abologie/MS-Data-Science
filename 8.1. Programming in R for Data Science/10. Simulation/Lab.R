my.data <- read.csv("Lab10.csv")
dim(my.data)

unique(my.data$Genotype)
data1 <- my.data$systolic.bp[my.data$Genotype == "BA"]
data2 <- my.data$systolic.bp[my.data$Genotype == "BB"]

testResult <- t.test(data1, data2)
testResult

hist(data1, probability = TRUE, main = "Mice systolic blood pressure comparison")
lines(density(data2), lty = "dashed")

n1 <- length(data1)
n1

set.seed(1234)
my.new.data <- my.data
my.new.data$Genotype <- "BB"
index.temp <- sample(1:50, n1)
my.new.data$Genotype[index.temp] <- "BA"
new.data1 <- my.new.data$systolic.bp[my.new.data$Genotype == "BA"]
new.data2 <- my.new.data$systolic.bp[my.new.data$Genotype == "BB"]
t.test(new.data1, new.data2)$statistic

perform.simulation <- function() {
    my.t.values <- numeric(100000)
    for (i in 1:length(my.t.values)) {
        my.new.data <- my.data
        my.new.data$Genotype <- "BB"
        index.temp <- sample(1:50, n1)
        my.new.data$Genotype[index.temp] <- "BA"
        new.data1 <- my.new.data$systolic.bp[my.new.data$Genotype == "BA"]
        new.data2 <- my.new.data$systolic.bp[my.new.data$Genotype == "BB"]
        my.t.values[i] <- t.test(new.data1, new.data2)$statistic
    }
    
    length(my.t.values[abs(my.t.values) > 2.027]) / length(my.t.values)
}

set.seed(554)
perform.simulation()
