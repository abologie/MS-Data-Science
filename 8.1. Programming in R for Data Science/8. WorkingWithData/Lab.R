set.seed(449)
your.dates <- as.Date(sample(18000:20000, 20), origin = "1960-01-01")
your.days <- c(julian(your.dates, origin = as.Date("1960-01-01")))
your.days[3]

set.seed(119)
my.days <- sample(18000:20000, 20)
old.locale <- Sys.getlocale()
Sys.setlocale("LC_TIME", "English")
library(chron)
my.days.structure <- month.day.year(my.days, origin = c(1, 1, 1960))
my.dates <- as.Date(my.days, origin = "1960-01-01")
my.date.info <- data.frame(Weekday = weekdays(my.dates), my.days.structure)
Sys.setlocale("LC_TIME", old.locale)