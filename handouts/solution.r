##
## Solutions des exercices d'applications.
##

library(ggplot2)

twogr <- function(x1, x2, levels = NULL) {
  require(reshape2)
  d <- melt(list(x1, x2))
  names(d)[2] <- "variable"
  d$variable <- factor(d$variable)
  if (!is.null(levels)) levels(d$variable) <- levels
  return(d)
}

################
## Exercice 1  ##
################
x1 <- c(11.1, 12.2, 15.5, 17.6, 13.0, 7.5, 9.1, 6.6, 9.5, 19.0, 12.6)
x2 <- c(18.2, 14.1, 13.8, 12.1, 34.1, 12.0, 14.1, 14.5, 12.6, 12.5, 19.8, 13.4, 16.8, 14.1, 12.9)

d <- twogr(x1, x2, c("x1", "x2"))

ggplot(data = d, aes(x = variable, y = value)) +
  geom_boxplot(outlier.color = "transparent") +
  geom_jitter(width = .1, size = 1)

## Determine whether the groups differ based on Welch's test. Use 𝛼 = 0.05.
t.test(value ~ variable, data = d, var.equal = FALSE)      ## p = 0.073 > 0.05, not significant

## Compare the observed p-value with that obtained from a permutation test.
library(coin)
oneway_test(value ~ variable, data = d)                    ## same conclusion

## What are the results of applying a Yuen’s test (using 10% trimming) on this dataset?
source("R/yuen.r")
yuen(x1, x2, tr = 0.1)                                     ## still not significant with 10% trimmed means


################
## Exercice 2  ##
################
x1 <- c(1.96, 2.24, 1.71, 2.41, 1.62, 1.93)
x2 <- c(2.11, 2.43, 2.07, 2.71, 2.50, 2.84, 2.88)

d <- twogr(x1, x2, c("A", "B"))

## Compute average ranks in the two groups.
aggregate(value ~ variable, data = d, function(x) mean(rank(x)))

## Verify that the Wilcoxon-Mann-Whitney test rejects with 𝛼 = 0.05.
wilcox.test(value ~ variable, data = d)                     ## p = 0.014 > 0.05

## Estimate the probability that a randomly sampled participant receiving drug A will have
## a smaller reduction in reaction time than a randomly sampled participant receiving drug B.
## Verify that the estimate is 0.9.
oneway_test(value ~ variable, data = d, distribution = "exact")


################
## Exercice 3  ##
################
x1 <- c(10, 14, 15, 18, 20, 29, 30, 40)
x2 <- c(40, 8, 15, 20, 10, 8, 2, 3)

## Compare the two groups with the sign test and the Wilcoxon signed rank test with 𝛼 = 0.05.
wilcox.test(x1, x2, paired = TRUE, correct = FALSE)

## Verify that according to the sign test, $\hat p = 0.29$ and that the 0.95 confidence interval
## for p is (0.04, 0.71), and that the Wilcoxon signed rank test has an approcimate p-value of 0.08.
di <- x1 - x2
di[di == 0] <- NA
ni <- sum(!is.na(di))
vi <- sum(di < 0, na.rm = TRUE)

binom.test(vi, ni)


################
## Exercice 4  ##
################

t.test(extra ~ group, data = sleep, paired = TRUE)

## Quelle est la puissance a posteriori d'une telle comparaison (10 sujets) ?
## Calculer les scores de différences entre les deux hypnotiques et réaliser un test t
## à un échantillon en testant la nullité de la moyenne des différences.
d <- cbind(sleep$extra[sleep$group == 1], sleep$extra[sleep$group == 2])

di <- d[,1] - d[,2]

t.test(di)

power.t.test(n = 10, delta = mean(di), sd = sd(di), type = "paired")    ## power ∞ 0.95

## Estimer un intervalle de confiance à 95 % pour cette moyenne des différences par bootstrap
library(boot)

f <- function(data, i) mean(data[i])

bs <- boot(di, statistic = f, R = 500)
boot.ci(bs, conf = 0.95, type = "perc")


################
## Exercice 5  ##
################
d <- data.frame(value = c(10, 11, 12, 9, 8, 7,
                         10, 66, 15, 32, 22, 51,
                         1, 12, 42, 31, 55, 19),
               variable = gl(3, 6, labels = paste0("g", 1:3)))

summary(aov(value ~ variable, data = d))

oneway.test(value ~ variable, data = d)                     ## reduced WSS via ranks


################
## Exercice 6  ##
################
tmp <- read.table("../data/weight.dat")

d <- data.frame(weight = as.numeric(unlist(tmp)),
               type = gl(2, 20, labels = c("Beef", "Cereal")),
               level = gl(2, 10, labels = c("Low", "High")))

fm <- weight ~ type * level

## Quels sont les effets significatifs ?
m <- aov(fm, data = d)
summary(m)                                                  ## level

## Effectuer toutes les comparaisons de paires de moyennes par des tests de Student
## en assumant ou non une variance commune, et comparer les résultats avec des tests
## protégés de type LSD ou Tukey.
with(d, pairwise.t.test(weight,
                        interaction(type, level),
                        p.adjust.method = "none"))

with(d, pairwise.t.test(weight,
                        interaction(type, level),
                        p.adjust.method = "none",
                        pool.sd = FALSE))

library(multcomp)

summary(glht(m, linfct = mcp(type = "Tukey")))

## To test for all pairs of means, see how to build the corresponding design matrix
## and apply a Tukey test in the following vignette (page 9):
## https://cran.r-project.org/web/packages/multcomp/vignettes/multcomp-examples.pdf


################
## Exercice 7  ##
################
load("../data/rats.rda")     ## "rat" data frame

rat <- within(rat, {
  Diet.Amount <- factor(Diet.Amount, levels = 1:2, labels = c("High", "Low"))
  Diet.Type <- factor(Diet.Type, levels = 1:3, labels = c("Beef", "Pork", "Cereal"))
})


## Show average responses for the 60 rats in an interaction plot.
ratm <- aggregate(Weight.Gain ~ Diet.Amount + Diet.Type, data = rat, mean)

ggplot(data = rat, aes(x = Diet.Type, y = Weight.Gain, color = Diet.Amount)) +
  geom_jitter() +
  geom_line(data = ratm, aes(x = Diet.Type, y = Weight.Gain, color = Diet.Amount, group = Diet.Amount))

## Consider the following 6 treatments: Beef/High, Beef/Low, Pork/High, Pork/Low,
## Cereal/High, et Cereal/Low. What is the result of the F-test for a one-way ANOVA?
tx <- with(rat, interaction(Diet.Amount, Diet.Type, sep="/"))
head(tx)
unique(table(tx))   ## obs / treatment

m <- aov(Weight.Gain ~ tx, data=rat)
summary(m)

## Use `pairwise.t.test()` with Bonferroni correction to identify pairs of treatments
## that differ significantly one from the other.
pairwise.t.test(rat$Weight.Gain, tx, p.adjust="bonf")

## Based on these 6 treatments, build a matrix of 5 contrasts allowing to test the following
## conditions: beef vs. cereal and beef vs. porc (2 DF); high vs. low dose (1 DF);
## and interaction type/amount (2 DF). Partition the SS associated to treatment computed
## in (2) according to these contrasts, and test each contrast at a 5% level (you can
## consider that there's no need to correct the multiple tests if contrasts were defined a priori).
ctr <- cbind(c(-1,-1,-1,-1,2,2)/6,
             c(-1,-1,1,1,0,0)/4,
             c(-1,1,-1,1,-1,1)/6,
             c(1,-1,1,-1,-2,2)/6,  # C1 x C3
             c(1,-1,-1,1,0,0)/4)   # C2 x C3
crossprod(ctr)

contrasts(tx) <- ctr
m <- aov(rat$Weight.Gain ~ tx)
summary(m, split=list(tx=1:5))

## Compare those results with a two-way ANOVA including the interaction between type and amount.
summary(aov(Weight.Gain ~ Diet.Type * Diet.Amount, data=rat))

## Test the following post-hoc contrast: beef and pork at high dose (i.e., Beef/High
## and Pork/High) vs. the average of all other treatments. Is the result significant
## at the 5% level? What does this result suggest?
tx <- with(rat, interaction(Diet.Amount, Diet.Type, sep="/"))
C6 <- c(2,-1,2,-1,-1,-1)/6

summary(glht(aov(rat$Weight.Gain ~ tx), linfct=mcp(tx=C6)))


################
## Exercice 8  ##
################

## Construire un graphique d'interaction (`dose` en abscisses) et commenter.
tooth.mean = aggregate(len ~ dose + supp, data = ToothGrowth, mean)

ggplot(data = ToothGrowth, aes(x = dose, y = len, color = supp)) +
  geom_point(position = position_jitterdodge(jitter.width = .1, dodge.width = 0.25)) +
  geom_line(data = tooth.mean, aes(x = dose, y = len, color = supp)) +
  scale_color_manual(values = c("dodgerblue", "coral")) +
  labs(x = "Dose (mg/day)", y = "Length (oc. unit)")

## Réaliser un test de Student pour comparer les groupes `OJ` et `VC` pour `dose == 0.5`. Les deux groupes peuvent-ils être considérés comme différent au seuil $\alpha = 0.05$ ?
t.test(len ~ supp, data = subset(ToothGrowth, dose == 0.5))

## Réaliser une ANOVA à deux facteurs avec interaction. Peut-on conclure à l'existence d'un effet dose dépendant du mode d'administration de la vitamine C ?
ToothGrowth$dose <- factor(ToothGrowth$dose)
m <- aov(len ~ supp * dose, data = ToothGrowth)
summary(m)

## Tester la linéarité de l'effet dose à l'aide d'un modèle de régression linéaire.
ToothGrowth$dose <- as.numeric(as.character(ToothGrowth$dose))
m <- lm(len ~ supp * dose, data = ToothGrowth)
summary(m)

################
## Exercice 9  ##
################

data(anorexia, package = "MASS")

## Construire un diagramme de dispersion (`Prewt` en abscisses, `Postwt` en ordonnées)
## avec des droites de régression conditionnelles pour chacun des trois groupes.
ggplot(data = anorexia, aes(x = Prewt, y = Postwt, color = Treat)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

## Comparer à l'aide de tests de Student les 3 groupes dans la période pré-traitement.
with(anorexia, pairwise.t.test(Prewt, Treat, p.adjust.method = "none", pool.sd = FALSE))

## Réaliser un modèle d'ANCOVA en testant l'interaction `Treat:Prewt`, en incluant
## le groupe contrôle ou non.
m0 <- lm(Postwt ~ Prewt + Treat, data = anorexia)
m1 <- lm(Postwt ~ Prewt * Treat, data = anorexia)
anova(m0, m1)

m2 <- lm(Postwt ~ Prewt * Treat, data = subset(anorexia, Treat != "Cont"))
summary(m2)


################
## Exercice 10 ##
################

babies <- read.table("../data/babies.txt", header = TRUE, na.string = ".")
babies$baby <- factor(babies$baby)
babies$loginsp <- log(babies$inspirat)

m1 <- aov(loginsp ~ maxp + Error(baby), data = babies[complete.cases(babies),])
summary(m1)

library(nlme)
m2 <- lme(loginsp ~ maxp, data=babies, random= ~ 1 | baby, na.action=na.omit)
anova(m2)




