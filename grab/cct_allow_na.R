# SPDX-License-Identifier: GPL-2.0-or-later
#
# cct_allow_na.R: modified version of CCT() from the R package grab 0.2.5
#
# Original work: 2026 Bi et al., grab (GPL-2 | GPL-3).
#   Source: https://cran.r-project.org/web/packages/GRAB/index.html
# Modifications: 2026 Cardio-CARE
#' This is a function taken from the GRAB package and modified to allow NAs for
#' rare variant analysis. 
#'
#' This program is free software; you can redistribute it and/or modify it
#' under the terms of the GNU General Public License as published by the
#' Free Software Foundation; either version 2 of the License, or (at your
#' option) any later version. It is distributed WITHOUT ANY WARRANTY.
#' See the full text in /usr/share/licenses/GPL-2.0.txt.


#' Cauchy Combination Test for p-value aggregation
#'
#' Combines multiple p-values using the Cauchy distribution method, which provides
#' analytical p-value calculation under arbitrary dependency structures.
#'
#' @param pvals Numeric vector of p-values to combine (each between 0 and 1).
#'   P-values equal to 1 are automatically adjusted to 0.999. P-values equal
#'   to 0 will cause an error.
#' @param weights Numeric vector of non-negative weights for each p-value.
#'   If NULL, equal weights are used. Must have same length as pvals.
#' @return Single aggregated p-value combining all input p-values.
#' @details
#' The Cauchy Combination Test (CCT) transforms p-values using the inverse Cauchy
#' distribution and combines them with specified weights. This method is particularly
#' powerful because it:
#' \itemize{
#'   \item Works under arbitrary dependency structures
#'   \item Provides exact analytical p-values (no simulation needed)
#'   \item Maintains good power properties across different scenarios
#' }
#'
#' \strong{Special Cases:}
#' - If any p-value equals 0, returns 0 immediately
#' - P-values equal to 1 are adjusted to 0.999 with a warning
#' - Very small p-values (< 1e-16) receive special numerical treatment
#'
#' @examples
#' # Basic usage with equal weights
#' pvalues <- c(0.02, 0.0004, 0.2, 0.1, 0.8)
#' CCT(pvals = pvalues)
#'
#' # Usage with custom weights
#' weights <- c(2, 3, 1, 1, 1)
#' CCT(pvals = pvalues, weights = weights)
#'
#' @references
#' Liu, Y., & Xie, J. (2020). Cauchy combination test: a powerful test
#' with analytic p-value calculation under arbitrary dependency structures.
#' \emph{Journal of the American Statistical Association}, 115(529), 393-402.
#' \doi{10.1080/01621459.2018.1554485}
#'
CCT_accept_na <- function(
  pvals,
  weights = NULL
) {
  # Validate p-values for missing values
  if (sum(is.na(pvals)) > 0) {
    pvals[which(is.na(pvals))] <- 0.99999
    #pvals <- replicate(0.9999999, length(pvals))
   # stop("Cannot have NAs in the p-values!")
  }

  # Ensure all p-values are in valid range [0, 1]
  if ((sum(pvals < 0) + sum(pvals > 1)) > 0) {
    stop("All p-values must be between 0 and 1!")
  }

  # Handle edge cases: p-values exactly 0 or 1
  is.zero <- (sum(pvals == 0) >= 1)
  which.one <- which(pvals == 1)
  is.one <- (length(which.one) >= 1)

  if (is.zero && is.one) {
    stop("Cannot have both 0 and 1 p-values!")
  }
  if (is.zero) {
    return(0)  # If any p-value is 0, combined p-value is 0
  }
  if (is.one) {
    warning("There are p-values that are exactly 1!")
    pvals[which.one] <- 0.999  # Adjust p-values of 1 to avoid numerical issues
  }

  # Validate and standardize weights
  if (is.null(weights)) {
    weights <- rep(1 / length(pvals), length(pvals))  # Equal weights
  } else if (length(weights) != length(pvals)) {
    stop("The length of weights should be the same as that of the p-values!")
  } else if (sum(weights < 0) > 0) {
    stop("All the weights must be positive!")
  } else {
    weights <- weights / sum(weights)  # Normalize weights to sum to 1
  }

  # Calculate CCT test statistic with special handling for very small p-values
  is.small <- (pvals < 1e-16)
  if (sum(is.small) == 0) {
    # Standard calculation when no extremely small p-values
    cct.stat <- sum(weights * tan((0.5 - pvals) * pi))
  } else {
    # Special handling for very small p-values to avoid numerical issues
    cct.stat <- sum((weights[is.small] / pvals[is.small]) / pi)
    cct.stat <- cct.stat + sum(weights[!is.small] * tan((0.5 - pvals[!is.small]) * pi))
  }

  # Calculate final p-value from CCT statistic
  if (cct.stat > 1e+15) {
    # Asymptotic approximation for very large test statistics
    pval <- (1 / cct.stat) / pi
  } else {
    # Standard Cauchy distribution calculation
    pval <- 1 - pcauchy(cct.stat)
  }

  return(pval)
}

