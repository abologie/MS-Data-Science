# Initialize Stan
require(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores() - 2)

# Simulate data
N <- 5000
# we assume 5000 members
female <- rbinom(N, 1, 0.6) 
# simulate 60% of female
photography <- rbinom(N, 1, 0.5) 
# simulate 50% of customers who expressed interest for photography
sculpture <- rbinom(N, 1, 0.3) 
# simulate 50% of customers who expressed interest for sculpture
digital_content <- rpois(N, 0.5) 
# simulate digital content
months_since <- rpois(N, 5) 
# simulate months since last visit, with a max of 12
months_since[months_since > 12] <- 12

beta0 <- 0.6
beta1 <- 0.9
beta2 <- 0.6
beta3 <- 0.01
beta4 <- -0.01
beta5 <- -0.2
prob_simul <- pnorm(beta0 + beta1*female + beta2*photography + beta3*sculpture + beta4*digital_content + beta5*months_since)
renewal <- rbinom(N,1,prob_simul)

# Prepare the data
X <- cbind(rep(1, N), female, photography, sculpture, digital_content, months_since)

# assign column names
colnames(X) <- c("intercept", "female", "photography", "sculpture", "digital_content", "months_since")
K <- dim(X)[2]

# Run Stan
probit <- '
data{
  int<lower=0> N; # number of observations
  int<lower=0> K; # number of parameters

  int<lower=0,upper=1> y[N];
  vector[K] X[N];
}
parameters{
  vector[K] beta;
}
model{
  beta ~ cauchy(0,5);

for(j in 1:N)
  y[j] ~ bernoulli(Phi_approx(dot_product(X[j],beta)));
}
'
data_list <- list(N = N, K = K, y = renewal, X = X)
fit <- stan(model_code = probit, data = data_list, warmup = 2000, iter = 4000, chains = 2)

# Summary of results and plots
print(fit)
fitlist <- extract(fit)

par(mfrow = c(2, 3))
plot(fitlist$beta[,1],type = "l", xlab = "", ylab = "Intercept")
plot(fitlist$beta[,2],type = "l", xlab = "", ylab = "Gender Coefficient")
plot(fitlist$beta[,3],type = "l", xlab = "", ylab = "photography Coefficient")
plot(fitlist$beta[,4],type = "l", xlab = "", ylab = "Sculpture Coefficient")
plot(fitlist$beta[,5],type = "l", xlab = "", ylab = "Digital content Coefficient")
plot(fitlist$beta[,6],type = "l", xlab = "", ylab = "Months since login")

par(mfrow = c(2,3))  
par(bg = "white", fg = "black", col.lab = "black", col.axis = "black", col.main = "black", lwd = 1)
#Gender
param <- fitlist$beta[,2]
min <- min(0, min(param))
max <- max(0, max(param))
hist(param, breaks = seq(min - 0.05, max + 0.05, 0.05), main = "Female", xlab = "", ylab = "", yaxt='n')
axis(1, lab = T , lwd = 2)
abline(v = beta1, col = 2)
#PHOTO
param <- fitlist$beta[,3]
min <- min(0, min(param))
max <- max(0, max(param))
hist(param, breaks = seq(min - 0.04, max + 0.04, 0.04), main = "Photography", xlab = "", ylab = "", yaxt = 'n')
axis(1, lab = T , lwd = 2)
abline(v = beta2, col = 2)
#SCULPTURE
param <- fitlist$beta[,4]
min <- min(0, min(param))
max <- max(0, max(param))
hist(param, breaks = seq(min - 0.03, max + 0.03, 0.03), main = "Sculpture", xlab = "", ylab = "", yaxt = 'n')
axis(1, lab = T , lwd = 2)
abline(v = beta3, col = 2)
#ONLINE CONTENT
param <- fitlist$beta[,5]
min <- min(0, min(param))
max <- max(0, max(param))
hist(param, breaks = seq(min - 0.02, max + 0.02, 0.02), main = "Downloads", xlab = "", ylab = "", yaxt = 'n')
axis(1, lab = T , lwd = 2)
abline(v = beta4, col = 2)
#VISIT
param <- fitlist$beta[,6]
min <- min(0, min(param))
max <- max(0, max(param))
hist(param, breaks = seq(min - 0.01, max + 0.01, 0.01), main = "Months since visit", xlab = "", ylab = "", yaxt = 'n')
axis(1, lab = T , lwd = 2)
abline(v = beta5, col = 2)