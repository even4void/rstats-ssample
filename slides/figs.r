#! /usr/bin/env Rscript

##
## Time-stamp: <2018-02-16 19:50:23 chl>
## Figures that go along ssample.md slides.
##

library(MASS)
library(ggplot2)
library(gridExtra)
library(hrbrthemes)
library(directlabels)

set.seed(101)

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

