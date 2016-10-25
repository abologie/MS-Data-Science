lab.file <- file("Assignment 5.dat", open = "r")
data.a <- read.table(lab.file, skip = 4, comment.char = "%", nrows = 7)
data.b <- read.table(lab.file, skip = 3, sep = ";", dec = ",", nrows = 2)
data.c <- read.table(lab.file, skip = 5, na.strings = "-9999", sep = ",", nrows = 2)
close(lab.file)

all.data <- rbind(data.a, data.b, data.c)
all.data