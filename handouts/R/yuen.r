yuen <- function(x, y = NULL, tr = .2, alpha = .05) {
  ##
  ##  Perform Yuen's test for trimmed means on the data in x and y.
  ##  The default amount of trimming is 20%
  ##  Missing values (values stored as NA) are automatically removed.
  ##
  ##  A confidence interval for the trimmed mean of x minus the
  ##  the trimmed mean of y is computed and returned in yuen$ci.
  ##  The p-value is returned in yuen$p.value
  ##
  ##  x, y: The data for the two groups are stored in x and y
  ##  tr=.2: indicates that the default amount of trimming is .2
  ##         tr=0 results in using the sample mean
  ##
  ##  The function returns both a confidence interval and a p-value.
  ##
  if (is.null(y)) {
    if (is.matrix(x) || is.data.frame(x)) {
      y <- x[,2]
      x <- x[,1]
    }
    if (is.list(x)) {
      y <- x[[2]]
      x <- x[[1]]
    }
  }
  if (tr == .5) stop("Using tr=.5 is not allowed; use a method designed for medians")
  if (tr > .25) print("Warning: with tr>.25 type I error control might be poor")

  winvar <- function(x, tr = .2, na.rm = FALSE, STAND = NULL){
    ##  Compute the gamma Winsorized variance for the data in the vector x.
    remx <- x
    x <- x[!is.na(x)]
    y <- sort(x)
    n <- length(x)
    ibot <- floor(tr*n) + 1
    itop <- length(x) - ibot + 1
    xbot <- y[ibot]
    xtop <- y[itop]
    y <- ifelse(y <= xbot, xbot, y)
    y <- ifelse(y >= xtop, xtop, y)
    wv <- var(y)
    if (!na.rm)
      if (sum(is.na(remx) > 0))
        wv <- NA
    wv
  }


  x <- x[!is.na(x)]  # Remove any missing values in x
  y <- y[!is.na(y)]  # Remove any missing values in y
  h1 <- length(x) - 2 * floor(tr * length(x))
  h2 <- length(y) - 2 * floor(tr * length(y))
  q1 <- (length(x) - 1) * winvar(x, tr) / (h1 * (h1 - 1))
  q2 <- (length(y) - 1) * winvar(y, tr) / (h2 * (h2 - 1))
  df <- (q1 + q2)^2 / ((q1^2 / (h1 - 1)) + (q2^2 / (h2 - 1)))
  crit <- qt(1 - alpha/2, df)
  dif <- mean(x, tr)-mean(y, tr)
  low <- dif - crit * sqrt(q1 + q2)
  up <- dif + crit * sqrt(q1 + q2)
  test <- abs(dif / sqrt(q1 + q2))
  yuen <- 2 * (1 - pt(test, df))
  list(n1 = length(x), n2 = length(y), est.1 = mean(x, tr), est.2 = mean(y, tr),
       ci = c(low, up), p.value = yuen, dif = dif, se = sqrt(q1 + q2),
       teststat = test, crit = crit, df = df)
}
