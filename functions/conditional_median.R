conditional_median <- function(u_var, copula, inv_CDF){
  if (dim(copula) == 2){
    x_median <- inv_CDF(invdduCopula(u_var, copula, rep(0.5, nrow(u_var))))
  }else{
    x_median <- inv_CDF(get_condQuantile(u_var, rep(0.5, nrow(u_var)), copula))
  }
  return(x_median)
}