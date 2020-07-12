conditional_probability <- function(u_var, copula, inv_CDF, cp){
  if (dim(copula) == 2){
    x_cp <- inv_CDF(invdduCopula(u_var, copula, rep(cp, nrow(u_var))))
  }else{
    x_cp <- inv_CDF(get_condQuantile(u_var, rep(cp, nrow(u_var)), copula))
  }
  return(x_cp)
}