# 5.1
read.table("data.exercise5.1.dat ", sep = " ", skip = 1, header = TRUE)

# 5.2
read.table("data.exercise5.2.dat", skip = 2, header = TRUE, sep = ";", dec = ",")

# 5.3
read.csv2("Exercise 5.3.csv", na.strings = "", skip = 2)[, -1]

# 5.4
file.a <- file("Exercise 5.4a.txt", open = "r")
headers <- scan(file.a, what = "", skip = 1, nlines = 1)
data.a <- read.table(file.a)
names(data.a) <- paste(headers[c(1, 3, 5)], headers[c(2, 4, 6)])
close(file.a)
data.a

data.b <- list()
all.data.headers <- character(2)
file.b <- file("Exercise 5.4b.txt", open = "r")
all.data.headers[1] <- scan(file.b, what = "", nlines = 1, skip = 1)
data.b[[1]] <- scan(file.b, nlines = 1)
all.data.headers[2] <- scan(file.b, what = "", nlines = 1)
data.b[[2]] <- matrix(scan(file.b), nrow = 4, byrow = TRUE)
close(file.b)
names(data.b) <- all.data.headers
data.b

file.b <- file("Exercise 5.4b.txt", open = "r")