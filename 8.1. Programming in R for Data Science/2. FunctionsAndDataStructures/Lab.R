my.display <- function(x) {
    cat("Summary of input: \n")
    return(summary(x))
}

my.display(1:10)

my.display <- function(x, display = FALSE, type = "", prob = FALSE) {
    if (display) {
        if (type == "hist") {
            hist(x, freq = !prob)
        }
        else if (type == "density") {
            plot(density(x))
        }
        else {
            print("Please specify type as either hist or density")
        }
    }

    cat("Summary of input: \n")
    return(summary(x))
}

set.seed(1234)
my.data <- rnorm(200)
my.display(my.data)
my.display(my.data, display = TRUE, type = "hist")
my.display(my.data, display = TRUE, type = "hist", prob = TRUE)
my.display(my.data, display = TRUE, type = "density")
my.display(my.data, display = TRUE)