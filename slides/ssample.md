---
title:    Statistiques pour petits échantillons
subtitle: Applications en recherche pré-clinique
author:   Christophe Lalanne
institute: |
           | RITME Academy
           | 72, rue des Archives – 75003 Paris 
           | www.ritme.com 
date:
---


## Synopsis

Plan de l'exposé  
rappels sur les principaux tests paramétriques pour la comparaison de moyennes et de proportions • présentation des approches non paramétriques • tests de permutation • plans d'expérience

Organisation  
théorie et applications dans le domaine biomédical • applications numériques avec le logiciel R

## Ressources

:::::::::::::: {.columns}
::: {.column width="60%"}
- Logiciel R : <http://cran.r-project.org>
- RStudio (pratique, mais optionnel) : <http://www.rstudio.com>
- Packages : ggplot2, car, rms, coin
- Mémento R et ggplot (syntaxe, commandes de base) 
:::
::: {.column width="40%"}
![[A Handbook of Small Data Sets][HSDS]](HSDS.jpg)
:::
::::::::::::::

# Rappels sur la démarche inférentielle

## Dicing with Death: Chance, Risk and Health

> Statisticians are applied philosophers. Philosophers argue how many angels can dance on the head of a needle; statisticians count them. Or rather, count how many can probably dance. (...) We can predict nothing with certainty but we can predict how uncertain our predictions will be, on average that is. Statistics is the science that tells us how.
>
> -- Stephen Senn (2003)

## Cadre de raisonnement

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


# Cas des variables continues et binaires

## Cas de la comparaison de deux moyennes

### Test de Student

Pour deux échantillons indépendants, la statistique de test se définit ainsi : 
$$ 
t_{\text{obs}}=\frac{\mathhigh{\bar x_1 - \bar x_2}}{s_c\sqrt{\frac{1}{n_1}+\frac{1}{n_2}}},\quad 
s_c=\left(\frac{\mathlow{(n_1-1)s^2_1+(n_2-1)s^2_2}}{n_1+n_2-2}\right)^{1/2},
$$ 
où les $\bar x_i$ et $n_i$ sont les moyennes et effectifs des deux échantillons, et $s_c$ est la \textlow{variance commune} pour la \texthigh{différence de moyennes} d'intérêt. Sous H~0~, cette statistique de test suit une loi de Student à $n_1+n_2-2$ degrés de liberté.

Un intervalle de confiance à $100(1-\alpha)$\% pour la différence $\bar x_1 - \bar x_2$ peut être construit comme suit : 
$$ \bar x_1 - \bar x_2\pm t_{\alpha, n_1+n_2-2}s_c\sqrt{\frac{1}{n_1}+\frac{1}{n_2}}, $$
avec $P(t<t_{\alpha,n_1+n_2-2})=1-\alpha/2$.

## Illustration

![Deux échantillons (n = 15)](fig-twosample.png)

## Remarque

\dnote{Quand on parle de "normalité" au sujet du test de Student, il faut garder à l'esprit que ce qui compte c'est essentiellement la distribution d'échantillonnage de la statistique de test. En l'occurence, la distribution d'échantillonnage d'une moyenne, et a fortiori d'une différence de moyenne est normale.}

## Application numérique

[Weight gain in rats][HSDS-WG] (`weight.dat`)  
Experimental study of the gain in weight of rats fed on four different diets, defined by amount (low / high) and by source of protein (beef and cereal)

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

```{.r .number-lines}
d <- read.table("weight.dat")
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

## Alternatives

1. Approche non paramétrique 
2. Test de nullité du paramètre par permutation
3. Estimation par intervalle par bootstrap
4. Estimation bayésienne d'un intervalle crédible de confiance


## Approche non paramétrique

### Le test des rangs de (Mann-Whitney-)Wilcoxon

L'hypothèse nulle est que les deux échantillons comparés proviennent de deux distributions ayant les mêmes distributions (paramètre de position, i.e. médiane).

La statistique de test est construite comme la plus petite somme des rangs d'un des deux échantillons ; quand $n_1,n_2>15$ et qu'il n'y a pas d'ex-aequo, on a l'approximation suivante pour La statistique de test : 

$$ Z=\frac{S-n_1(n_1+n_2+1)/2}{\sqrt{n_1n_2(n_1+n_2+1)/12}}\sim \mathcal{N}(0;1),$$ 

où $S$ est la statistique de test pour l'échantillon avec $n_1$ observations.

Pour deux échantillons appariés, le test des rangs signés est utilisé : on calcule la somme $T^+$ des rangs des différences $z_i=x_{1i}-x_{2i}$ en valeurs absolues positifs ; dans le cadre asymptotique, la statistique de test correspondante est : 

$$ Z=\frac{T^+-n(n+1)/4}{\sqrt{n(n+1)(2n+1)/24}}\sim\mathcal{N}(0;1). $$



## Bootstrap 
<!-- FIXME: must distinguish estimaiton of standard error, confidence interval, and hypothesis testing -->

Conditions de validité : (a) le paramètre à estimer n'est pas dans un cas limite (borne de l'espace du paramètre, cas des statistiques d'ordre ou des proportions extrêmes) ; (b) l'échantillon peut être considéré représentatif de la population cible ; (c) la taille de l'échantillon est raisonnable.

1. Tirage avec remise de $n$ échantillons de même taille $k$ ($k$, la taille de l'échantillon d'origine).[^2]
2. Pour chaque échantillon bootstrap, on calcule la statistique d'intérêt, $\hat\theta_i^*$.
3. Le biais par rapport à l'estimateur classique est $\hat\theta - \theta \approx \mathbb E(\hat\theta^*) - \hat\theta$.
4. Pour chaque échantillon bootstrap, on calcule $t_i^*=\tfrac{\hat\theta_i^* - \hat\theta}{\text{se}(\hat\theta_i^*)}$ ($\text{se}(\hat\theta_i^*) = s_i^*\sqrt{n}^{-1}$), et la distribution bootstrap de $t^*$ permet de construire un intervalle de confiance à 95 %.

[^2]: Illustration : [Bootstrap in Picture][drbunsen]


## Illustration

Dans le cas à deux échantillons, on rééchantillonne séparément les deux groupes (centrés sur leur moyennes respectives), on construit la statistique de test d'intérêt (ici, $s = \bar x_1^* - \bar x_2^*$) et on calcule le degré de signification achevé $\sharp \{|s| > |\bar x_1 - \bar x_2|\}$ (\texthigh{sous $H_0$}) :

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
pobs <-  (1 + sum(abs(s) > abs(mean(d[,1]) - mean(d[,2])))) / (B+1)
```

## Références
\setlength{\parindent}{-0.16in}
\setlength{\leftskip}{0.2in}
\setlength{\parskip}{8pt}
\vspace*{-0.2in}
\noindent
\small


[HSDS]: https://www.stat.ncsu.edu/research/sas/sicl/data/
[HSDS-WG]: https://www.stat.ncsu.edu/research/sas/sicl/data/weight.dat
[drbunsen]: http://www.drbunsen.org/bootstrap-in-picture/
