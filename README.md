[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/SarahAlidoost/ConditionalPrediction/blob/master/LICENSE)

# Conditional prediction using copula

Three predictors are used to predict an unknown variable: conditional expectation, conditional median, and conditional probability. The conditional distribution is determined by copulas. The functions support both bivariate and multivariate distributions.
The `ConditionalPrediction_script.R` in the scripts folder shows how to use the functions and implement conditional prediction using the example data.
The `example_data.RData` contains mean air temperature at one day obtained from weather stations and ERA-Interim data.

The packages `sp`, `gstat`, `VineCopula`, and `copula` are available on [CRAN](https://cran.r-project.org/) whereas the package `spcopula` on [R-Forge](https://r-forge.r-project.org/).

## New to copulas?

Please take a look at the post ["Environmental processes are linked, but how?" An introduction to copulas](https://blog.esciencecenter.nl/environmental-processes-are-linked-but-how-ba917e79094b).

## References:

* Alidoost F., Su Z, Stein A. 2019. Evaluating the effects of climate extremes on crop yield, production and price using multivariate distributions: A new copula application. [Weather and climate extremes](https://doi.org/10.1016/j.wace.2019.100227).

* Alidoost F., Stein A., Su Z. 2019. The use of bivariate copulas for bias correction of reanalysis air temperature data. [PLOS ONE](https://doi.org/10.1371/journal.pone.0216059).

* Alidoost, F., (2019), Copulas for integrating weather and land information in space and time ([Doctoral](https://research.utwente.nl/en/publications/copulas-for-integrating-weather-and-land-information-in-space-and)), University of Twente.

## How to contribute:

We value the time you invest in contributing. If you have questions/suggestions, please open an [issue](https://github.com/SarahAlidoost/ConditionalPrediction/issues).

If you would like to add your contributions, you can submit a [pull request](https://github.com/SarahAlidoost/ConditionalPrediction/pulls).
Each pull request is reviewed at least by one reviewer.
