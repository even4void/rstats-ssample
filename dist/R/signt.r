signt <- function(x, y = NULL, alpha = .05, AC = TRUE, SD = FALSE) {
  ##
  ##  Do a sign test on data in x and y
  ##  If y=NA, assume x is a matrix with
  ##  two columns or has list mode.
  ##
  ##  Returns n, the original sample size
  ##  N, number of paired observations that are not equal to one another.
  ##  phat, an estimate of p, the probability that x<y.
  ##  ci, a confidence interval for p
  ##
  ##  The Agresti-Coull method is used by default.
  ##  AC=F, Pratt's method is used instead.
  ##  SD=TRUE, the Schilling-Doi method is used, which returns a confidence
  ##           interval but no p-value.
  ##
  if (is.null(y[1])) {
    if (ncol(as.matrix(x)) != 2) stop('y is null so x should be a matrix or data frame with two columns')
    if (is.matrix(x) || is.data.frame(x)) dif <- x[,1] - x[,2]
    if (is.list(x)) dif <- x[[1]] - x[[2]]
  }
  if (!is.null(y[1])) dif <- x - y
  n <- length(dif)
  dif <- dif[dif != 0] 
  flag <- (dif < 0)
  if (!AC) temp <- binomcipv(y = flag, alpha = alpha)
  if (AC) temp <- acbinomcipv(y = flag, alpha = alpha)
  if (SD) temp <- binomLCO(y = flag, alpha = alpha)
  list(Prob_x_less_than_y = temp$phat, ci = temp$ci,
       n = n, N = length(flag), p.value = temp$p.value)
}

