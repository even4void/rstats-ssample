---
title:    Statistiques pour petits échantillons
subtitle: Applications en recherche pré-clinique
author:   
institute: |
           | RITME Academy
           | 72, rue des Archives – 75003 Paris 
           | www.ritme.com 
date:
---


## Synopsis

Plan de l'exposé  
rappels sur les principaux tests paramétriques pour la comparaison de moyennes et de proportions • présentation des approches non paramétriques • tests de permutation • plans d'expérience

TL;DR  
Lorsque les conditions d'application sont vérifiées, le test de Student reste le plus puissant. On peut cependant envisager des méthodes alternatives pour la construction d'un test d'hypothèse nulle. Le modèle de régression linéaire est un outil versatile pour l'estimation ponctuelle et par intervalle. On peut néanmoins profiter des plans d'expérience pour gagner de la puissance statistique et de méthodes robuste d'estimation pour limiter l'influence de certaines observations.

# Rappels sur la démarche inférentielle

## Dicing with Death: Chance, Risk and Health

> Statisticians are applied philosophers. Philosophers argue how many angels can dance on the head of a needle; statisticians count them. Or rather, count how many can probably dance. (...) We can predict nothing with certainty but we can predict how uncertain our predictions will be, on average that is. Statistics is the science that tells us how.
>
> -- Stephen Senn (2003)

## Cadre de raisonnement

Mots-clés :

- approche (fréquentiste) du test d'une hypothèse nulle, approche bayésienne, approche reposant sur la vraisemblance
- méthodes paramétriques et non paramétriques, bootstrap, procédures de re randomization, approches robustes, validation croisée
- dessin de l'étude, efficacité d'un estimateur et puissance statistique : structure d'appariement, variables d'ajustement et variables de confusion, réduction de dimension

Les petis échantillons sont plus susceptibles de présenter des valeurs extrêmes (observations influentes), ils rendent difficile la mise en évidence de "petites différences", et il est plus difficile de vérifier les conditions de validité des tests statistiques usuels. 

## Moindres carrés ordinaires *versus* M-estimateur

![Méthode des moindres carrés (LM) et approche robuste[^1] (RLM)](fig-anscombe-lrm.png)

[^1]: John Fox & Sanford Weisberg, [Robust Regression](http://users.stat.umn.edu/~sandy/courses/8053/handouts/robust.pdf) (PDF)

## Linéarité de la relation et points influents

![Anscombe's Quartet [@tufte-1989-visual-displ]](fig-anscombe-all.png)

## Taille d'effet et nombre de sujets nécessaires

![Tiré de @campbell-1995-estim-sampl](campbell-1995-estim-sampl.png){ width=80% }


# Estimation et test d'hypothèse

## Cas de la comparaison de deux moyennes

### Test de Student

Pour deux échantillons indépendants, la statistique de test se définit ainsi : 
$$ 
t_{\text{obs}}=\frac{\bar x_1 - \bar x_2}{s_c\sqrt{\frac{1}{n_1}+\frac{1}{n_2}}},\quad 
s_c=\left(\frac{(n_1-1)s^2_1+(n_2-1)s^2_2}{n_1+n_2-2}\right)^{1/2},
$$ 
où les $\bar x_i$ et $n_i$ sont les moyennes et effectifs des deux échantillons, et $s_c$ est la variance commune pour la différence de moyennes d'intérêt. Sous H~0~, cette statistique de test suit une loi de Student à $n_1+n_2-2$ degrés de liberté.

Un intervalle de confiance à $100(1-\alpha)$\% pour la différence $\bar x_1 - \bar x_2$ peut être construit comme suit : 
$$ \bar x_1 - \bar x_2\pm t_{\alpha, n_1+n_2-2}s_c\sqrt{\frac{1}{n_1}+\frac{1}{n_2}}, $$
avec $P(t<t_{\alpha,n_1+n_2-2})=1-\alpha/2$.

## Illustration

![Deux échantillons (n = 15)](fig-twosample.png)


## Application numérique
\vskip2em

> Experimental study of the gain in weight of rats fed on four different diets, defined by amount (low / high) and by source of protein (beef and cereal)
>
> --- @hand-1993-handb-small

:::::::::::::: {.columns}
::: {.column width="50%"}
| Beef     | Cereal   |
|:---------+:---------|
| 90 / 73  | 107 / 98 |
| 76 / 102 | 95 / 74  |
| 90 / 118 | 97 / 56  |
| 64 / 104 | 80 / 111 |
| 86 / 81  | 98 / 95  |
| 51 / 107 | 74 / 88  |
| 72 / 100 | 74 / 82  |
| 90 / 87  | 67 / 77  |
| 95 / 117 | 89 / 86  |
| 78 / 111 | 58 / 92  |
:::
::: {.column width="50%"}
![](fig-ratweight.png){ width=80% }
:::
::::::::::::::


## `<R/>`

```r
d <- read.table("weight.dat")
## comparaison Beef/Low vs. Beef/High
t.test(d[,1], d[,2], (*@\texthigh{var.equal = TRUE}@*))
```


```{caption="Résultat du test de Student"}
	Two Sample t-test

data:  d[, 1] and d[, 2]
t = -3.2021, df = 18, p-value = 0.00494
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -34.447192  -7.152808
sample estimates:
mean of x mean of y
     79.2     100.0
```

## Condition d'homoscédasticité

L'hypothèse de variances égales[^2] peut être relaxée en utilisant une approximation des degrés de liberté sous la forme d'une simple combinaison linéaire des variances, $\tfrac{s_1^2}{n_1}+\tfrac{s_2^2}{n_2}$ [@satterthwaite-1946-approx-distr]. La statistique de test suit toujours une loi de Student, mais avec des degrés de liberté ($\nu$) différents.

### Formule de Satterthwaite et de Welch
L'approximation de Satterthwaite considère les degrés de liberté suivants :
$$ \nu = \frac{ \left( s_1^2/n_1 + s_2^2/n_2 \right)^2 }
{ \frac{\left( s_1^2/n_1 \right)^2}{n_1-1} + \frac{\left( s_2^2/n_2 \right)^2}{n_2-1} }. $$

La formule proposée par @welch-1947-gener-studen (`var.equal = FALSE`, par défaut sous R) est à peu près comparable :
$$ \nu = \high{-2} + \frac{ \left( s_1^2/n_1 + s_2^2/n_2 \right)^2 }
{ \frac{\left( s_1^2/n_1 \right)^2}{n_1 \high{+} 1} + \frac{\left( s_2^2/n_2 \right)^2}{n_2 \high{+} 1} }. $$


[^2]: [Problème de Behrens-Fisher](https://en.wikipedia.org/wiki/Behrens–Fisher_problem).

## Alternatives

1. Approche non paramétrique 
2. Test de nullité du paramètre par permutation
3. Estimation par intervalle par bootstrap
4. Test de nullité du paramètre par bootstrap
5. *Test de nullité basé sur un estimateur robuste* [@wilcox-2003-moder-robus]
6. *Estimation bayésienne d'un intervalle de crédibilité* [@kruschke-2013-bayes-estim]

## Approche non paramétrique

### Le test des rangs de (Mann-Whitney-)Wilcoxon

L'hypothèse nulle est que les deux échantillons comparés proviennent de deux distributions ayant les mêmes distributions (paramètre de position, i.e. médiane).

La statistique de test est construite comme la plus petite somme des rangs d'un des deux échantillons ; quand $n_1,n_2>15$ et qu'il n'y a pas d'ex-aequo, on a l'approximation suivante pour La statistique de test : 

$$ Z=\frac{S-n_1(n_1+n_2+1)/2}{\sqrt{n_1n_2(n_1+n_2+1)/12}}\sim \mathcal{N}(0;1),$$ 

où $S$ est la statistique de test pour l'échantillon avec $n_1$ observations.

Pour deux échantillons appariés, le test des rangs signés est utilisé : on calcule la somme $T^+$ des rangs des différences $z_i=x_{1i}-x_{2i}$ en valeurs absolues positifs ; dans le cadre asymptotique, la statistique de test correspondante est : 

$$ Z=\frac{T^+-n(n+1)/4}{\sqrt{n(n+1)(2n+1)/24}}\sim\mathcal{N}(0;1). $$

## Test de permutation bilatéral

Dans la plupart des cas, la distribution de la statistique de test est symétrique (et $\mathbb{E}(T) = 0$ sous $H_0$). Soit $s_0=\bar x_1 - \bar x_2$ la statistique empirique. On calculera le degré de signification en cumulant les résultats des permutations $s=\bar x_1^* - \bar x_2^*$ dans les deux queues de distribution.

```{.r .number-lines}
s0 <- mean(d[,1]) - mean(d[,2])              ## statistique emp.
x <- c(d[,1], d[,2])
idx <- combn(seq(along = 1:20), 10)          ## {20 \choose 10} 
f <- function(k) mean(x[k]) - mean(x[-k])
s <- apply(idx, 2, f)                        ## statistique s
pobs <- sum(abs(s) >= abs(s0)) / length(s)
```

Avec le package `coin` : 

```r
library(coin)
oneway_test(value ~ variable, data = reshape2::melt(d[1:2]), 
            alternative = "two.sided", distribution = "exact")
```

## Illustration

![Distribution de la statistique sous permutation](fig-permutation.png)

## Approche par bootstrap 

Conditions de validité :  
(a) le paramètre à estimer n'est pas dans un cas limite (borne de l'espace du paramètre, cas des statistiques d'ordre ou des proportions extrêmes) ; (b) l'échantillon peut être considéré représentatif de la population cible ; (c) la taille de l'échantillon est raisonnable.

1. Tirage avec remise de $n$ échantillons de même taille $n$.[^3]
2. Pour chaque échantillon, on calcule la statistique d'intérêt, $\hat\theta_i^*$.
3. Le biais par rapport à l'estimateur classique est $\hat\theta - \theta \approx \mathbb E(\hat\theta^*) - \hat\theta$.
4. Pour chaque échantillon bootstrap, on calcule $t_i^*=\tfrac{\hat\theta_i^* - \hat\theta}{\text{se}(\hat\theta_i^*)}$ ($\text{se}(\hat\theta_i^*) = s_i^*\sqrt{n}^{-1}$), et la distribution bootstrap de $t^*$ permet de construire un intervalle de confiance à 95 %.

Cette approche peut également être utilisée pour construire un test d'hypothèse nulle.

[^3]: Illustration : [Bootstrap in Picture][drbunsen]

## Illustration : intervalle de confiance pour une moyenne

![IC à 95 % (\textcolor{Peru}{bootstrap percentile}) pour la moyenne Beef/Low (\textcolor{LimeGreen}{Student}, \textcolor{SkyBlue}{Normal})](fig-bootstrap.png)

## Illustration : test d'hypothèse pour une différence de moyenne

Dans le cas à deux échantillons, on rééchantillonne séparément les deux groupes (centrés sur leur moyennes respectives), on construit la statistique de test d'intérêt (ici, $s = \bar x_1^* - \bar x_2^*$) et on calcule le degré de signification achevé $\sharp \{|s| > |\bar x_1 - \bar x_2|\}$ (sous $H_0$) :

```{.r .number-lines}
x1 <- d[,1] - (*@\texthigh{mean(d[,1]) + mean(x)}@*) 
x2 <- d[,2] - mean(d[,2]) + mean(x)
B <- 10000        ## no. bootstrap samples
s <- numeric(B)   ## vector of test statistics
for (i in 1:B) {
  x1s <- sample(x1, replace=TRUE)
  x2s <- sample(x2, replace=TRUE)
  s[i] <- mean(x1s) - mean(x2s)
}
pobs <-  (1 + sum(abs(s) > abs(s0))) / (B+1)
```

# Modèle linéaire et applications

## Rappels sur la régression linéaire

### Le modèle de régression simple

Soit $y_i$ la réponse observée sur l'individu $i$, et $x_i$ sa valeur observée pour le prédicteur $x$. Le modèle de régression linéaire s'écrit : 
$$y_i = \beta_0+\beta_1x_i+\varepsilon_i,$$ 
où $\beta_0$ représente l'ordonnée à l'origine et $\beta_1$ la pente de la droite de régression, et $\varepsilon_i\sim\mathcal{N}(0,\sigma^2)$ est un terme d'erreur (résidus, supposés indépendants).

En minimisant les différences quadratiques entre les valeurs observées et les valeurs prédites (principe des MCO), on peut estimer les coefficients de régression, $\hat\beta_0$ et $\hat\beta_1$ : 
\begin{align*}
\hat\beta_0 & = \bar y - \hat\beta_1\bar x\\ 
\hat\beta_1 & = \sum(y_i-\bar y)(x_i-\bar x) \big/ \sum(x_i-\bar x)^2
\end{align*} 

Sous $H_0$, le rapport entre l'estimé de la pente ($\hat\beta_1$, de variance $\tfrac{\text{SSR}/(n-2)}{(n-1)s_x^2}$) et son erreur standard suit une loi de Student à $(n-2)$ degrés de liberté. 

## Mesures d'influence

Les résidus "simples", $e_i=y_i-\hat y_i$, sont de variance non constante, mais on montre que celle-ci est fonction de $\sigma_{\varepsilon}^2$ : $$\text{Var}(e_i)=\sigma_{\varepsilon}^2(1-h_i),$$ où $h_i$ ("*hat value*") est l'effet levier de la $i$ème observation sur l'ensemble des valeurs ajustées via le modèle de régression. Les points exerçant un fort effet levier tendent donc à avoir de plus faibles résidus.

### 
- effet levier : large si $h_i>2(k+1)/n$
- distance de Cook : $D_i=\frac{h_i}{1-h_i}\times\frac{e_i^{'2}}{k+1}$, considérée large si $D_i>4/(n-k-1)$.
- $\text{DFFITS}=\frac{\hat y_i-\hat y_i^{(-i)}}{s_{e^{(-i)}}}\sqrt{h_i^{(-i)}}$, considéré large si $>2\sqrt{p/n}$.
- $\text{DFBETAS}=\hat\beta_j-\hat\beta_j^{(-i)} \big/ s_{e^{(-i)}}\sqrt{X'X}_{jj}$, pour le $j$ème coefficient du modèle (incluant l'intercept), considéré large si $>2/\sqrt{n}$.

## Approche robuste et résistante de la régression

1. Méthode robuste :  
Estimer un modèle de régression classique, puis calculer les distances de Cooket exclure les observations pour lesquelles $D > 1$. Ensuite, de manière itérative on estime le modèle et on calcule le poids de chaque observation à partir des résidus. En utilisant la fonction de pondération proposée par @huber-1964-robus-estim, les observations avec des résidus élevés auront des poids de plus en plus petits. Il existe d'autres variantes de M-estimateurs.

2. Méthode résistante :  
Utilisation de la médiane au lieu des MCO, $\min_b\text{median}_i\|y_i-x_ib\|^2$, ou d'une moyenne tronquée, $\min_b\sum_{i=1}^q\|y_i-x_ib\|_{(i)}^2$ (généralement, $q=\lfloor (n+p+1)/2 \rfloor$) [@rousseeuw-1987-robus-regres].

## Illustration numérique
\vskip2em

> Plasma inorganic phosphate levels from 33 subjects in two groups (20 control, 13 obese), taken every 30' or 60' from baseline (t0).
>
> --- @davis-2002-statis-method

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
| ID | group   |  t0 |  t1 |  t4 |  t5 |
|----|---------|-----|-----|-----|-----|
|  1 | control | 4.3 | 3.0 | 3.4 | 4.4 |
|  2 | control | 3.7 | 2.6 | 3.1 | 3.9 |
|  3 | control | 4.0 | 3.1 | 3.9 | 4.0 |
|  4 | control | 3.6 | 2.2 | 3.8 | 4.0 |
|  5 | control | 4.1 | 2.1 | 3.6 | 3.7 |
|    | ...     |     |     |     |     |
| 29 | obese   | 4.2 | 3.8 | 3.5 | 3.9 |
| 30 | obese   | 6.6 | 5.2 | 4.2 | 4.8 |
| 31 | obese   | 3.6 | 3.1 | 2.5 | 3.5 |
| 32 | obese   | 4.5 | 3.7 | 3.1 | 3.3 |
| 33 | obese   | 4.6 | 3.8 | 3.8 | 3.8 |
:::
::: {.column width="50%"}
![](fig-phosphate-1.png){ width=80% }
:::
::::::::::::::



## `<R/>`

```r
tmp <- read.csv("phosphate.csv")
d <- subset(tmp, group == "obese")
```

![](fig-phosphate-2.png)


## `<R/>`

```{.r .number-lines}
m <- lm(t5 ~ t0, data = d)
cooks.distance(m)
rob <- MASS::rlm(t5 ~ t0, data = d)  ## Huber M-estimator
rob$w[c(3,7)]                        ## weights for obs. 23/27
```

```{caption="Mesures d'influence `influence.measure(m)`"}
     dfb.1_  dfb.t0   dffit cov.r  cook.d    hat inf
21  0.32600 -0.4144 -0.6286 0.895 0.17372 0.1360
22  0.30425 -0.2843  0.3168 1.940 0.05437 0.3949   *
23 -0.05780  0.1686  0.6459 0.616 (*@\texthigh{0.15678}@*)0.0826
24 -0.00301 -0.0168 -0.1138 1.274 0.00702 0.0786
25  0.02863 -0.0191  0.0599 1.313 0.00197 0.0856
26 -0.01154  0.0337  0.1289 1.271 0.00898 0.0826
27 -0.18166  0.2811  0.6159 0.733 (*@\texthigh{0.15426}@*)0.0972
...
```

## 


![](fig-phosphate-3.png)


## Analyse de variance et régression linéaire

Le modèle à effets pour un modèle à deux facteurs $A$ et $B$ s'écrit :
$$ y_{ijk} = \mu + \alpha_i + \beta_j + \varepsilon_{ijk}, $$
où $y_{ijk}$ désigne la mesure sur le $k$\ieme\ sujet pour le niveau $i$ de $A$ et $j$ de $B$, $\mu$ est la moyenne générale et les $\alpha_i$ et $\beta_j$ désignent les effets principaux de $A$ et $B$. Si le dessin expérimental est équilibré, la variance totale peut être partitionnée en sommes de carré indépendantes.

Un modèle de régression, en considérant des variables indicatrices codant les niveaux de $A$ et $B$, se formule ainsi :
$$ y_i = \beta_0 + \beta_1 x_{1i} + \beta_2 x_{2i} + \varepsilon_i, $$
où $\beta_0$ représente l'intercept et $\beta_1$ et $\beta_2$ les coefficients de régression associés à chaque facteur.

## Modèle =  données + erreur

![](linmod.png)

## `<R/>`

```{.r .number-lines}
tmp <- read.table("weight.dat")
d <- data.frame(weight = as.numeric(unlist(tmp)),
               type = gl(2, 20, labels = c("Beef", "Cereal")),
               level = gl(2, 10, labels = c("Low", "High")))
fm <- weight ~ type + level + type:level
summary(aov(fm, data = d))
```


## `<R/>`

```{.r .number-lines}
m <- lm(fm, data = d)
summary(m)
```

## Analyse de covariance

L'analyse de covariance consiste à tester différents niveaux d'un facteur en présence d'un ou plusieurs co-facteurs continus. La variable réponse et ces co-facteurs sont supposées reliés, et l'objectif est d'obtenir une estimation des réponses corrigée pour les éventuelles différences entre groupes (au niveau des cofacteurs). 

Ce type d'analyse est fréquemment utilisé comme méthode d'ajustement *a posteriori*, ou dans le cas des données pré/post avec des mesures continues et un facteur de groupe, et reste préférable à une simple analyse des scores de différences [@miller-2001-misun-analy-covar; @senn-2006-chang-from].

Il existe également des alternatives non-paramétriques [@young-1995-nonpar-analy-covar].

## Formalisation du modèle d'ANCOVA

### Équation de la droite de régression

Soit $y_{ij}$ la $j$ème observation dans le groupe $i$. À l'image du modèle d'ANOVA à un facteur, le modèle d'ANCOVA s'écrit :
$$ y_{ij} = \mu+\alpha_i+\beta(x_{ij}-\bar x)+\varepsilon_{ij},$$ 
où $\beta$ est le coefficient de régression liant la réponse $y$ et le cofacteur $x$ (continu), avec $\bar x$ la moyenne générale des $x_{ij}$, et toujours un terme d'erreur $\varepsilon_{ij}\sim \mathcal{N}(0,\sigma^2)$.

Notons que l'on fait l'hypothèse que $\beta$ est le même dans chaque groupe. Cette hypothèse de parallélisme peut se vérifier en testant la significativité du terme d'interaction $\alpha\beta$.

La réponse moyenne ajustée pour l'effet du co-facteur numérique s'obtient simplement comme $\bar\alpha_i+\hat\beta(\bar x_i-\bar x)$, où $\bar x_i$ est la moyenne des $x$ dans le $i$ème groupe.


## Cas des mesures répétées

TODO

## Application numérique

> Lack of digestive enzymes in the intestine can cause bowel absorption problems, as indicated by excess fat in the feces. Pancreatic enzyme supplements can be given to ameliorate the problem
>
> --- @vittinghoff-2005-regres-method-biost

| ID | None | Tablet | Capsule | Coated | Avg. |
|:---|-----:|-------:|--------:|-------:|-----:|
| 1  | 44.5 |  7.3   |   3.4   |  12.4  | 16.9 |
| 2  | 33.0 | 21.0   |   23.1  |  25.4  | 25.6 |
| 3  | 19.1 |  5.0   |   11.8  |  22.0  | 14.5 |
| 4  |  9.4 |  4.6   |    4.6  |  5.8   |  6.1 |
| 5  | 71.3 | 23.3   |   25.6  |  68.2  | 47.1 |
| 6  | 51.2 | 38.0   |   36.0  |  52.6  | 44.5 |
|Avg.| 38.1 | 16.5   |   17.4  |  31.1  | 25.8 |

## 

![](fig-pill.png)

## Modèles d'ANOVA

```{.r .number-lines}
aov(fecfat ~ pilltype, data = fat)                    ## M1
aov(fecfat ~ pilltype + subject, data = fat)          ## M2
aov(fecfat ~ pilltype + (*@\texthigh{Error(subject)}@*), data = fat)  ## M3
```

| Source      |     DF |     SS |       MS | M1            | M2\*/M3        |
| :---------- | -----: | -----: | -------: | ------------: | -------------: |
| pilltype    |      3 |   2009 |    669.5 | 669.5/359.7   | 669.5/107.0    |
|             |        |        |          | p=0.169       | p=0.006        |
| subject     |      5 |   5588 |   1117.7 | ---           | 1117.7/107.0   |
|             |        |        |          |               | p<0.001\*      |
| Residuals   |     15 |   1605 |    107.0 | ---           | ---            |

## 

Le modèle M1 (ANOVA à un facteur à effet fixe) suppose les observations indépendantes et de tient pas compte des 78 % de variance entre sujets. 

Les modèles M2 (ANOVA à deux facteurs à effet fixe) et M3 (ANOVA à deux facteurs dont un à effet aléatoire) incorporent un effet sujet :

$$ y_{ij} = \mu + \text{subject}_i + \text{pilltype}_j + \varepsilon_{ij}, \quad 
   \varepsilon_{ij} \sim \mathcal{N}(0,\sigma_\varepsilon^2). $$

Dans M3, on suppose de plus que $\text{subject}_i \sim \mathcal{N}(0,\sigma_s^2)$, indépendants de $\varepsilon_{ij}$. L'inclusion d'un effet aléatoire permet de modéliser la corrélation intra sujet.

## Composantes de variance

### Corrélation intraclasse et symétrie composée

La corrélation entre deux mesures prises sur le même sujet vaut :
$$ \text{Cor}(y_{ij},y_{ik})=\frac{\text{Cov}(y_{ij},y_{ik})}{\text{Var}(y_{ij})^{1/2} \text{Var}(y_{ik})^{1/2}}. $$
Comme $\mu$ et $\text{pilltype}$ sont fixés, et $\varepsilon_{ij} \perp \text{subject}_i$, on a alors :

\begin{align*}
\text{Cov}(y_{ij},y_{ik}) & = \text{Cov}(\text{subject}_i,\text{subject}_i) \\
& = \text{Var}(\text{subject}_i) = \sigma_{s}^2
\end{align*}

Les composantes de variance découlent de l'égalité $\text{Var}(y_{ij})=\text{Var}(\text{subject}_i)+\text{Var}(\varepsilon_{ij})=\sigma_{s}^2+\sigma_{\varepsilon}^2$, supposée valide pour toutes les observations. On a donc : $\text{Cor}(y_{ij},y_{ik})=\frac{\sigma_{s}^2}{\sigma_{s}^2+\sigma_{\varepsilon}^2}$, qui représente la proportion de variance attribuable aux sujets, et qu'on appelle également \texthigh{corrélation intraclasse} ($\rho$).


## Approche par modèle mixte

Les modèles mixtes offrent une approche plus flexible



## Références {.allowframebreaks}
\vskip1em
\setlength{\parindent}{-0.16in}
\setlength{\leftskip}{0.2in}
\setlength{\parskip}{4pt}
\noindent
\small\sffamily

[HSDS]: https://www.stat.ncsu.edu/research/sas/sicl/data/
[HSDS-WG]: https://www.stat.ncsu.edu/research/sas/sicl/data/weight.dat
[drbunsen]: http://www.drbunsen.org/bootstrap-in-picture/
