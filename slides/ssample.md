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

        
## Références
\setlength{\parindent}{-0.16in}
\setlength{\leftskip}{0.2in}
\setlength{\parskip}{8pt}
\vspace*{-0.2in}
\noindent
\small


[HSDS]: https://www.stat.ncsu.edu/research/sas/sicl/data/
[HSDS-WG]: https://www.stat.ncsu.edu/research/sas/sicl/data/weight.dat
