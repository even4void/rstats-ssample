permg <- function(x, y, alpha = .05, est = mean, nboot = 1000) {
  ##
  ## Do a two-sample permutation test based on means or any
  ## other measure of location or scale indicated by the
  ## argument est.
  ##
  ## The default number of permutations is nboot=1000
  ##
  x <- x[!is.na(x)]
  y <- y[!is.na(y)]
  xx <- c(x,y)
  dif <- est(x)-est(y)
  vec <- c(1:length(xx))
  v1 <- length(x)+1
  difb <- NA
  temp2 <- NA
  for (i in 1:nboot) {
    data <- sample(xx, size = length(xx), replace = FALSE)
    temp1 <- est(data[c(1:length(x))])
    temp2 <- est(data[c(v1:length(xx))])
    difb[i] <- temp1 - temp2
  }
  difb <- sort(difb)
  icl <- floor((alpha/2) * nboot + .5)
  icu <- floor((1-alpha/2) * nboot + .5)
  reject <- "no"
  if (dif >= difb[icu] || dif <= difb[icl]) reject<-"yes"
  list(dif = dif, lower = difb[icl], upper = difb[icu], reject = reject)
}

