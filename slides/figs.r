#! /usr/bin/env Rscript

##
## Time-stamp: <2018-03-21 17:58:00 chl>
## Figures that go along ssample.md slides.
##

library(MASS)
library(ggplot2)
library(gridExtra)
library(hrbrthemes)
library(directlabels)

set.seed(101)

WD <- "../data"

psave <- function(filename = NULL, plot = last_plot(), w = 5, h = w * 2/(1+sqrt(5)), r = 300, ...) {
  p = plot + theme(axis.title.x = element_text(hjust = 1),
                   axis.title.y = element_text(hjust = 1))
  ggsave(filename = filename, width = w, height = h, dpi = r, ...)
}

theme_set(theme_ipsum(base_family = "Fira Sans Condensed Light", base_size = 11))

clr6 = ipsum_pal()(6)

### Fig #1
p3 = ggplot(data = anscombe, aes(x3, y3)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, col = clr6[1]) +
  geom_smooth(method = "rlm", col = clr6[2]) +
  labs(x = NULL, y = NULL) +
  annotate(geom = "text", x = 13.5, y = 10.5, label = "LM", size = 2.8, col = clr6[1]) +
  annotate(geom = "text", x = 13.5, y = 8, label = "RLM", size = 2.8, col = clr6[2])

psave("fig-anscombe-lrm.png")

### Fig #2
mp <- function(x, y, col) {
  out = ggplot(data = NULL, aes(x, y)) +
    geom_point(size = 1) +
    geom_smooth(method = "lm", se = FALSE, col = col) +
    labs(x = NULL, y = NULL) +
    theme_ipsum(base_family = "Fira Sans Condensed Light", base_size = 9) +
    theme(plot.margin = rep(unit(0.2,"null"),4))
  return(out)
}

p1 = mp(anscombe$x1, anscombe$y1, clr6[1])
p2 = mp(anscombe$x2, anscombe$y2, clr6[1])
p4 = mp(anscombe$x4, anscombe$y4, clr6[1]) + scale_x_continuous(breaks = c(7, 10,  13, 16, 19))

png("fig-anscombe-all.png", width = 5, height = 5 * 2/(1+sqrt(5)), res = 300, units = "in")
grid.arrange(p3, arrangeGrob(p1, p2, p4, nrow = 3), ncol = 2)
dev.off()


### Fig #3
n = 15
y1 = rnorm(n, mean = 11, sd = 1)
y2 = rnorm(n, mean = 9, sd = 1)
y = c(y1, y2)
cl = rep(clr6[1:2], each = n)
lbl = rep(c("A", "B"), each = n)
d = data.frame(x = rep(c(1, 2), each = n), y)

p = ggplot(data = d, aes(x, y)) +
  geom_point(col = cl) +
  geom_text(data = NULL, aes(x = 1.5, y, label = lbl),
            position = position_jitter(width = .1), size = 2.8, col = cl, alpha = .5) +
  annotate(geom = "text", x = c(1.1, 1.9), y = c(mean(y1), mean(y2)),
           label = c("atop(bold(A))", "atop(bold(B))"), size = 3.2, col = clr6[1:2], parse = TRUE) +
  scale_x_continuous(breaks = NULL) +
  labs(x = NULL, y = NULL) +
  theme_ipsum(grid = "Y", base_family = "Fira Sans Condensed Light", base_size = 11)

psave("fig-twosample.png")

## Fig #4
tmp = read.table(paste(WD, "weight.dat", sep = "/"))

d = data.frame(weight = as.numeric(unlist(tmp)),
               type = gl(2, 20, labels = c("Beef", "Cereal")),
               level = gl(2, 10, labels = c("Low", "High")))

p = ggplot(data = d, aes(x = level, y = weight)) +
  geom_boxplot(position = position_dodge()) +
  geom_jitter(size = .8, width = .05) +
  facet_wrap(~ type, nrow = 2) +
  labs(x = NULL, y = "Rat weight (g)")

psave("fig-ratweight.png", w = 3, h = 4.5)


## Fig #5
s0 = mean(tmp[,1]) - mean(tmp[,2])
x = c(tmp[,1], tmp[,2])
idx = combn(seq(along = 1:20), 10)
f = function(k) mean(x[k]) - mean(x[-k])
s = apply(idx, 2, f)
pobs = sum(abs(s) >= abs(s0)) / length(s)

dens = density(s, adjust = 0.5)
dd = data.frame(x = dens$x, y = dens$y)

p = ggplot(data = dd, aes(x, y)) +
  geom_area(fill = grey(0.5), alpha = 0.5) +
  geom_area(data = subset(dd, x >= -s0), aes(x, y), fill = clr6[1]) +
  geom_area(data = subset(dd, x <= s0), aes(x, y), fill = clr6[1]) +
  annotate(geom = "text", x = 22.5, y = 0.005, label = round(pobs/2, 4), size = 2.8, col = clr6[1]) +
  annotate(geom = "text", x = -22.5, y = 0.005, label = round(pobs/2, 4), size = 2.8, col = clr6[1]) +
  labs(x = "Value of s*", y = "Density")

psave("fig-permutation.png")

## Fig #6
library(boot)
s = function(x, d) mean(x[d])
b = boot(tmp[,1], s, 1000)
bci = boot.ci(b, type = "perc")$percent[4:5]
tci = mean(tmp[[1]]) + c(-1,1) * qt(0.975, 9) * sd(tmp[[1]])/sqrt(10)
nci = mean(tmp[[1]]) + c(-1,1) * qnorm(0.975) * sd(tmp[[1]])/sqrt(10)

p = ggplot(data = NULL, aes(x = b$t)) +
  geom_line(stat = "density") +
  geom_vline(xintercept = b$t0, col = clr6[1]) +
  geom_vline(xintercept = bci, linetype = 2, col = clr6[1]) +
  geom_segment(aes(x = tci, xend = tci, y = 0.0875, yend = 0.0872), size = 1,
               arrow = arrow(length = unit(0.25, "cm")), col = clr6[2]) +
  geom_segment(aes(x = nci, xend = nci, y = 0.0875, yend = 0.0872), size = 1,
               arrow = arrow(length = unit(0.25, "cm")), col = clr6[4]) +
  labs(x = "Value of t*", y = "Density")

psave("fig-bootstrap.png")


## Fig #7
phosphate = read.csv("../data/phosphate.csv")
d = subset(phosphate, group == "obese")

p = ggplot(data = phosphate, aes(x = t0, y = t5)) +
  geom_point(col = grey(.5)) +
  geom_smooth(method = "loess", span = 1, se = FALSE, col = clr6[1]) +
  facet_wrap(~ group, nrow = 2) +
  labs(x = "Baseline (T0)", y = "Baseline + 5 hours (T5)")

psave("fig-phosphate-1.png", w = 3, h = 4.5)

## Fig #8
m = lm(t5 ~ t0, data = d)
yhat = fitted(m)

p = ggplot(data = d, aes(x = t0, y = t5)) +
  geom_point(col = grey(.5)) +
  geom_smooth(method = "lm", se = FALSE, col = clr6[1]) +
  geom_segment(aes(x = t0, xend = t0, y = t5, yend = yhat), color = grey(.5)) +
  labs(x = "Baseline (T0)", y = "Baseline + 5 hours (T5)", caption = "Obese") +
  annotate(geom = "text", x = 4.8, y = 4.9, label = "23", size = 2.8, col = clr6[5]) +
  annotate(geom = "text", x = 5.2, y = 4.9, label = "27", size = 2.8, col = clr6[5])

psave("fig-phosphate-2.png")


## Fig #9
p = ggplot(data = d, aes(x = t0, y = t5)) +
  geom_point(col = grey(.5)) +
  geom_smooth(method = "lm", se = FALSE, col = clr6[1]) +
  geom_smooth(method = "rlm", se = FALSE, col = clr6[2]) +
  labs(x = "Baseline (T0)", y = "Baseline + 5 hours (T5)") +
  annotate(geom = "text", x = 6.25, y = 4.375, label = "RLM", size = 2.8, col = clr6[2]) +
  annotate(geom = "text", x = 5.75, y = 4.625, label = "LM", size = 2.8, col = clr6[1])

psave("fig-phosphate-3.png")



## Fig #10
fat = data.frame(fecfat = c(44.5, 33, 19.1, 9.4, 71.3, 51.2,
                            7.3, 21, 5, 4.6, 23.3, 38,
                            3.4, 23.1, 11.8, 4.6, 25.6, 36,
                            12.4, 25.4, 22, 5.8, 68.2, 52.6),
                 pilltype = gl(4, 6, labels = c("None", "Tablet", "Capsule", "Coated")),
                 subject = gl(6, 1))

fat.mean = aggregate(fecfat ~ pilltype, data = fat, mean)

p = ggplot(data = fat, aes(x = reorder(pilltype, fecfat), y = fecfat)) +
  geom_line(aes(group = subject), color = grey(0.5)) +
  geom_line(data = fat.mean, aes(x = pilltype, y = fecfat, group = 1),
            color = clr6[1], size = 1.2) +
  labs(x = NULL, y = "Fecal Fat")

psave("fig-pill-1.png")

## FIg #11
library(nlme)
m = lme(fecfat ~ pilltype, data = fat, random = ~ 1 | subject)
yhat = predict(m)

p = ggplot(data = fat, aes(x = reorder(pilltype, fecfat), y = yhat)) +
  geom_line(aes(group = subject), color = grey(0.5)) +
  geom_line(data = fat.mean, aes(x = pilltype, y = fecfat, group = 1),
            color = clr6[1], size = 1.2) +
  labs(x = NULL, y = "Predicted Fecal Fat")

psave("fig-pill-2.png")


################################################################################

##
## Figures that go along design.md slides.
##

## Fig #1

sleep$group = factor(sleep$group, labels = c("DHH", "LHH"))
sleep$ID = factor(sleep$ID)

sleep.mean = aggregate(extra ~ group, data = sleep, mean)

p = ggplot(data = sleep, aes(x = group, y = extra)) +
  geom_line(aes(group = ID), col = grey(0.5)) +
  geom_line(data = sleep.mean, aes(x = group, y = extra, group = 1),
            color = clr6[1], size = 1.2) +
  geom_hline(yintercept = 0, linetype = 2) +
  labs(x = NULL, y = "Extra sleep (hours)")

psave("fig-student.png")


## Fig #2

tooth.mean = aggregate(len ~ dose + supp, data = ToothGrowth, mean)

p = ggplot(data = ToothGrowth, aes(x = dose, y = len, color = supp)) +
  geom_point(position = position_jitterdodge(jitter.width = .1, dodge.width = 0.25)) +
  geom_line(data = tooth.mean, aes(x = dose, y = len, color = supp)) +
  scale_color_manual(values = clr6[c(4,6)]) +
  guides(color = FALSE) +
  geom_dl(aes(label = supp), method = list("smart.grid", cex = .8)) +
  labs(x = "Dose (mg/day)", y = "Length (oc. unit)")

psave("fig-toothgrowth.png")
