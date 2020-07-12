conditional_expectation <- function(u_var, copula, inv_CDF) {
  x_mean <- matrix(NA, nrow = nrow(u_var), ncol = 1)
  if (dim(copula) == 2){
    #' Prediction based on bivariate copula.
    for (j in 1:nrow(u_var)) {
      integral_term <- function(x)(inv_CDF(x) * dCopula(cbind(u_var[j], x), copula))
      x_mean[j, 1] <- integrate(integral_term, 0.0001, c(1-0.0001), subdivisions=1000L, stop.on.error=F)$value
    }
  } else{
    #' Prediction based on multivariate copula.
    for (j in 1:nrow(u_var)) {
      # j=1
      condSecVine <- get_condPDF_density(u_var[j,], copula)
      integral_term <- function(x)(inv_CDF(x) * condSecVine(x))
      x_mean[j, 1] <- integrate(integral_term, 0.0001, c(1-0.0001), subdivisions=1000L, stop.on.error=F)$value
    }
  }
  return(x_mean) 
}