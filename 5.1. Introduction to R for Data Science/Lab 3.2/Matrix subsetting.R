# Select elements
# star_wars_matrix is already defined in your workspace

# US box office revenue for "The Empire Strikes Back"
star_wars_matrix["The Empire Strikes Back", "US"]

# non-US box office revenue for "A New Hope"
star_wars_matrix["A New Hope", "non-US"]

# Select rows and columns
# star_wars_matrix is already defined in your workspace

# Select all US box office revenue
star_wars_matrix[, "US"]

# Select revenue for "A New Hope"
star_wars_matrix["A New Hope",]

# Average non-US revenue per movie: non_us_all
non_us_all <- mean(star_wars_matrix[, "non-US"])
  
# Average non-US revenue of first two movies: non_us_some
non_us_some <- mean(star_wars_matrix[1:2, "non-US"])

# Create submatrices
# star_wars_matrix is already defined in your workspace

# All figures for "A New Hope" and "Return of the Jedi"
star_wars_matrix[c("A New Hope", "Return of the Jedi"),]

# Alternative ways of subsetting
# star_wars_matrix is already defined in your workspace

# Select the US revenues for "A New Hope" and "The Empire Strikes Back"
star_wars_matrix[c("A New Hope", "The Empire Strikes Back"), "US"]

# Select the last two rows and both columns
star_wars_matrix[c(FALSE, TRUE, TRUE), TRUE]

# Select the non-US revenue for "The Empire Strikes Back"
star_wars_matrix["The Empire Strikes Back", "non-US"]

# Subsetting: The final challenge
# Combine view_count_1 and view_count_2 in a new matrix: view_count_all
view_count_all <- cbind(view_count_1, view_count_2)

# Subset view counts for three loudest debaters: view_count_loud
view_count_loud <- view_count_all[, c("Rachel", "Walter", "Dave")]

# Use colSums() to calculate the number of views: total_views_loud
total_views_loud <- colSums(view_count_loud)