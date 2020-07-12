#' This script is used to implement
#' prediction using copulas (bivariate and multivariate)
#' Variables are:
#' obs: data and locations of observations
#' prd: data and locations of predictions
#' ws:  weather station (or x)
#' era: era_interim (or y)
#' dem: digital elevation model (or z)


# Set directories
library_path = "PATH_TO/R/win-library/3.5"
functions_path = "PATH_TO/ConditionalPrediction/functions"
data_path = "PATH_TO/ConditionalPrediction/example_data"
output_path = "PATH_TO/ConditionalPrediction"

# Load libraries
.libPaths(library_path)
library(sp)
library(gstat)
library(VineCopula)
library(copula)
library(spcopula)
# Remove local variables
rm(library_path)

# Source functions
for (file_name in list.files(functions_path, pattern = "[.][R]")) {
  source(file.path(functions_path, file_name))
}
# Remove local variables
rm(functions_path, file_name)


# Load input
file_name <- list.files(data_path, pattern = "[.][RData]")
load(file.path(data_path, file_name))
# Remove local variables
rm(data_path, file_name)


# Estimate marginal distributions
#' marginal_cdf: u = F(x)
#' inv_marginal_cdf: x = F^-1(u)
inv_marginal_cdf_x <-
  estimate_inv_marginal_cdf(grd_obs@data$ws_obs)
marginal_cdf_x <-  estimate_marginal_cdf(grd_obs@data$ws_obs)
grd_obs@data$u_obs <- marginal_cdf_x(grd_obs@data$ws_obs)

#' marginal_cdf: v = F(y)
marginal_cdf_y <-
  estimate_marginal_cdf(c(grd_obs@data$era_obs, grd_prd@data$era_prd))
grd_obs@data$v_obs <- marginal_cdf_y(grd_obs@data$era_obs)
grd_prd@data$v_prd <- marginal_cdf_y(grd_prd@data$era_prd)

#' marginal_cdf: w = F(z)
marginal_cdf_z <-
  estimate_marginal_cdf(c(grd_obs@data$dem_obs, grd_prd@data$dem_prd))
grd_obs@data$w_obs <- marginal_cdf_z(grd_obs@data$dem_obs)
grd_prd@data$w_prd <- marginal_cdf_z(grd_prd@data$dem_prd)

# Remove local variables
rm(marginal_cdf_x, marginal_cdf_y, marginal_cdf_z)


# Run conditional prediction using bivariate copulas
#' CE: conditional expectation that results x_mean
#' CM: conditional median that results x_median
#' CP: conditional probability that results x
#' u = F(x)
#' v = F(y)

#' bivariate copula estimation using observations
cop_uv <- estimate_copula(grd_obs@data$u_obs,
                          grd_obs@data$v_obs)

#' covariate used for prediction
v = as.matrix(grd_prd@data$v_prd)

grd_prd@data$bivar_CE_x <- conditional_expectation(v, cop_uv, inv_marginal_cdf_x) 
grd_prd@data$bivar_CM_x <- conditional_median(v, cop_uv, inv_marginal_cdf_x) 
grd_prd@data$bivar_CP_x <- conditional_probability(v, cop_uv, inv_marginal_cdf_x, cp=0.75) 


# Run conditional prediction using multivariate copulas
#' CE: conditional expectation that results x_mean
#' CM: conditional median that results x_median
#' CP: conditional probability that results x
#' u = F(x)
#' v = F(y)
#' w = F(z)

#' multivariate copula estimation using observations
cop_uvw <- estimate_Rvm(cbind(grd_obs@data$u_obs,
                              grd_obs@data$v_obs,
                              grd_obs@data$w_obs ))

#' covariates used for prediction
vw = as.matrix(cbind(grd_prd@data$v_prd,
                     grd_prd@data$w_prd))

grd_prd@data$multivar_CE_x <- conditional_expectation(vw, cop_uvw, inv_marginal_cdf_x) 
grd_prd@data$multivar_CM_x <- conditional_median(vw, cop_uvw, inv_marginal_cdf_x) 
grd_prd@data$multivar_CP_x <- conditional_probability(vw, cop_uvw, inv_marginal_cdf_x, cp=0.75) 


# Remove local variables
rm(cop_uv, cop_uvw, v, vw)


# Save output
save.image(paste(output_path, "/ConditionalPrediction_output.RData", sep = ""))
