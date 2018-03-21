---
title:    Plans d'expérience
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
rappels sur les principaux types de plans d'expérience • principe de l'analyse de variance • procédures de comparaisons multiples

TL;DR  
Lorsque les conditions d'application sont vérifiées, le test de Student reste le plus puissant pour comparer deux moyennes. Les plans d'expérience permettent d'arranger les sources de variation de manière à maximiser la précision de l'estimation d'un effet, c'est le principe de l'analyse de variance.

# Plans d'expérience

## Design of Experiments, 1971

> To call in the statistician after the experiment is done may be no more than asking him to perform a post-mortem examination: he may be able to say what the experiment died of.
>
> --- Ronald Fisher

## The Environment and Disease: Association or Causation?

![](Hill-1965.png)

## Principe des plan d'expérience

Mise en œuvre organisée d'un ensemble d'unités expérimentales pour caractériser l'effet de certains traitements, ou combinaison de traitements, sur une ou plusieurs variables réponses. 

Prise en considération d'un ou plusieurs facteurs de nuisance pendant la constitution du dessin expérimental : organiser les sources de variation indésirables de façon à ce qu'elles affectent les traitements de manière équivalente, rendant ainsi possible la comparaison entre traitements.

- Minimiser le nombre d'essais et maximiser la précision 
- Respecter des contraintes externes (budget, sujets, éthique, durée, exposition, environnement, etc.)


## Etudes pré-cliniques : cas d'un plan 3 + 3

![Protocole d'escalade de dose[^1]](3-3.png){ width=60% }

[^1]: Source : [Phase 1 Trial Design: Is 3 + 3 the Best?](https://moffitt.org/media/1310/200.pdf)

## Etudes pré-cliniques : plan dose-réponse

![Protocole de recherche d'effet thérapeutique[^2]](dose-resp.png){ width=70% }

[^2]: Source : [Drug Safety & the Therapeutic Index](http://tmedweb.tulane.edu/pharmwiki/doku.php/basic_principles_of_pharm)

## Plan complet randomisé[^3] (CRD)

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
- Les répliques de traitement sont administrées aléatoirement et de manière indépendante aux sujets
- Les sujets adjacents peuvent recevoir le même traitement
- Le cas à deux traitements correspond au test de Student pour deux échantillons indépendants
:::
::: {.column width="50%"}
\small
![4 traitements (A–D), 4 répliques (1–4)](CRD.gif){ width=80% }

A1  B1  C1  A2  
D1  A3  D2  C2  
B2  D3  C3  B3  
C4  A4  B4  D4
:::
::::::::::::::

[^3]: Source des illustrations : [A Field Guide to Experimental Design](http://www.tfrec.wsu.edu/ANOVA/index.html)

## Blocs complets aléatoires (RCB)

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
- Traitements assignés au hasard à l'intérieur des blocs, une seule fois par bloc
- Le nombre de blocs est égal au nombre de répliques
- N'importe quel traitement peut être adjacent à un autre entre blocs mais pas à l'intérieur des blocs
- Permet de contrôler la **variabilité dûe aux effets spatiaux**
:::
::: {.column width="50%"}
\small
![4 traitements (A–D), 4 blocs (I–IV)](RCB.gif){ width=80% }

Block I     A   B   C   D  
Block II    D   A   B   C  
Block III   B   D   C   A  
Block IV    C   A   B   D
:::
::::::::::::::

## Carré latin

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
- Traitements assignés aléatoirement et de manière unique par ligne et par colonne
- Même nombre de lignes, colonnes et traitements
- Intéressant pour **contrôler la variabilité dans deux directions** (souvent orthogonales)
:::
::: {.column width="50%"}
\small
![4 traitements (A–D), 4 lignes (I–IV) et 4 colonnes (1–4)](Latin.gif){ width=80% }

Row I     A   B   C   D  
Row II    C   D   A   B  
Row III   D   C   B   A  
Row IV    B   A   D   C

Column    1   2   3   4
:::
::::::::::::::

## Plan factoriel 2^2^ CRD

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
- Les traitements correspondent au croisement des deux niveaux de deux facteurs dans un plan complet
- Les répliques sont assignées au hasard aux sujets indépendants
- Les sujets adjacents peuvent recevoir la même combinaison de traitement
:::
::: {.column width="50%"}
\small
![4 combinaisons de traitement (Aa, Ba, Ab et Bb) et 4 répliques (1–4)](CRD2way.gif){ width=80% }

Aa1  Ba1  Ab1  Aa2  
Bb1  Aa3  Bb2  Ab2  
Ba2  Bb3  Ab3  Ba3  
Ab4  Aa4  Ba4  Bb4
:::
::::::::::::::

## Plan factoriel 2^2^ RCB

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
- Les traitements correspondent au croisement des deux niveaux de deux facteurs dans un plan de blocs aléatoires
- Les traitements sont assignés au hasard et de manière unique à l'intérieur des blocs de sujets adjacents
- Le nombre de blocs est égal au nombre de répliques
- N'importe quel traitement peut être adjacent à un autre entre blocs mais pas à l'intérieur des blocs
:::
::: {.column width="50%"}
\small
![4 blocs et 4 combinaisons de traitement (Aa, Ba, Ab et Bb)](factorial.gif){ width=80% }

Block IV     Aa  Ba  Ab  Bb  
Block III    Bb  Aa  Ba  Ab  
Block II     Ba  Bb  Ab  Aa  
Block I      Ab  Aa  Ba  Bb
:::
::::::::::::::

## Plan split-plot CRD

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
- Principe du CRD dans lequel on introduit un niveau additionnel de stratification pour des sujets indépendants ("subplot") auxquels on administre aléatoirement un autre type de traitement
- Les répliques sont assignées au hasard aux sujets expérimentaux du premier niveau, pas au subplot
- Les sujets indépendants adjacents peuvent recevoir le même traitement
:::
::: {.column width="50%"}
\small
![4 répliques de 3 traitements (A–C) divsisés en 3 sous-traitements (a–c)](splplt.gif){ width=80% }

A1a A1b A1c B1c B1b B1a A2b A2c A2a C1a C1c C1b  
C2c C2a C2b A3b A3c A3a B2c B2a B2b C3b C3a C3c  
B3b B3c B3a A4a A4c A4b C4c C4a C4b B4a B4b B4c
:::
::::::::::::::

## Plan split-block RCB

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
- Deux ensembles de traitement (possiblement en gradient) sont randomisés entre eux à l'intérieur de bandes dans un plan en blocs aléatoires
- Utilisable lorsque les traitements doivent être administrés intégralement entre chaque bloc
- Le nombre de blocs est égal au nombre de répliques
:::
::: {.column width="50%"}
\small
![3 blocs (I–III), 3 + 2 traitements (A–C, 1–2)](spblock.gif){ width=80% }

Block I   Block II   Block III  
 A1  A2    C2  C1     B1  B2  
 B1  B2    A2  A1     C1  C2  
 C1  C2    B2  B1     A1  A2
:::
::::::::::::::

## Régréssion linéaire simple

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
- Les traitements sont déterminés et fixés à partir de quantités numériques choisies dans un ensemble de valeurs admissibles
- Les répliques sont assignées complétement au hasard aux sujets indépendants
- Les sujets adjacents peuvent recevoir le même traitement
:::
::: {.column width="50%"}
\small
![4 traitements (0, 1, 2, 5) et 4 répliques (a–d)](regress.gif){ width=80% }

5a  2a  0a  5b  
1a  5c  1b  0b  
2b  1c  0c  2c  
0d  5d  2d  1d
:::
::::::::::::::

## Régréssion linéaire avec groupes indépendants

:::::::::::::: {.columns}
::: {.column width="50%"}
\small
- Les traitements sont déterminés et fixés à partir de quantités numériques choisies dans un ensemble de valeurs admissibles, et croisés avec les niveaux d'un facteur
- Les répliques sont assignées complètement au hasard aux sujets indépendants
:::
::: {.column width="50%"}
\small
![3 niveaux (1, 2, 5), 2 traitements (A, B) et 4 répliques (a–d)](regress2.gif){ width=80% }

5Aa   2Aa   5Ba   5Ab   2Ba   1Ba  
1Bb   1Aa   2Bb   2Ab   1Bc   1Ab  
5Ac   2Bc   2Ac   1Ac   5Bb   5Bc  
1Ad   5Bd   5Ad   1Bd   2Bd   2Ad
:::
::::::::::::::

## Cas concrets 

### Blocs complets

Pour des raisons d'économie de place, les animaux utilisés pour une expérience sont mis dans des cages qui peuvent en contenir chacune
12. On dispose au total de 10 cages et l'on doit comparer 3 traitements A, B et C. L'une des solutions consiste à répartir au hasard les 3 traitements parmi les 120 animaux. On conçoit cependant qu'il puisse être intéressant, si l'on pense que les résultats observés dans chaque case risquent de présenter une certaine homogénéité par rapport à l'ensemble, et qu'il existe corrélativement une certaine hétérogénéité d'une cage à l'autre, d'attribuer les 3 traitements à 4 animaux à l'intérieur de chaque cage (par tirage au sort).

### Blocs incomplets équilibrés

Comparaison des réactions cutanées locales de 5 traitements A, B, C, D, E chez la souris. On souhaiterait utiliser l'animal comme son propre témoin, en d'autres termes prendre chaque souris comme bloc. Il se peut cependant que, compte-tenu des dimensions de la souris, il ne soit possible d'appliquer que 4 traitements à chaque animal.

### Carré latin

Comparaison de 4 traitements appliqués localement au même animal, mais à des endroits différents. Si le lieu d'injection est une cause systématique et importante de variation, on constituera des blocs "animal-lieu d'injection" avec une seule unité expérimentale [@lellouch-1974-method].


## `<R/>`

```{.r .number-lines}
library(agricolae)
tx <- LETTERS[1:4]
p1 <- design.crd(trt = tx, r = rep(4, 4), seed = 101)   ## CRD
p1$book
p2 <- design.rcbd(trt = tx, r = 4, seed = 121)          ## RCB
tx1 <- paste0("c", 1:4)
tx2 <- paste0("r", 1:4)
p3 <- design.graeco(tx1, tx2, serie = 1)        ## Carré latin
```

# Modèles statistiques courants

## Cas de la comparaison de deux moyennes

### Test de Student

Pour deux échantillons indépendants, la statistique de test se définit ainsi : $$ t_{\text{obs}}=\frac{\bar x_1 - \bar x_2}{s_c\sqrt{\frac{1}{n_1}+\frac{1}{n_2}}},\quad s_c=\left(\frac{(n_1-1)s^2_1+(n_2-1)s^2_2}{n_1+n_2-2}\right)^{1/2}, $$ où les $\bar x_i$ et $n_i$ sont les moyennes et effectifs des deux échantillons, et $s_c$ est la variance commune pour la différence de moyennes d'intérêt. Sous H~0~, cette statistique de test suit une loi de Student à $n_1+n_2-2$ degrés de liberté.

Un intervalle de confiance à $100(1-\alpha)$\% pour la différence $\bar x_1 - \bar x_2$ peut être construit comme suit : 
$$ \bar x_1 - \bar x_2\pm t_{\alpha, n_1+n_2-2}s_c\sqrt{\frac{1}{n_1}+\frac{1}{n_2}}, $$
avec $P(t<t_{\alpha,n_1+n_2-2})=1-\alpha/2$.

## Illustration

![Données sur les hypnotiques [@gosset-1908-probab-error-mean]](fig-student.png)

## `<R/>`

```{.r .number-lines}
t.test(extra ~ group, data = sleep)
t.test(extra ~ group, data = sleep, paired = TRUE)
```

```{caption="Résultat du test de Student pour échantillons appariés"}
	Paired t-test

data:  extra by group
t = -4.0621, df = 9, p-value = 0.002833
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2.4598858 -0.7001142
sample estimates:
mean of the differences
                  -1.58
```

## Facteurs à effets fixes ou aléatoires

![](random-vs-fixed.png){ width=80% }

## Analyse de la variance

L'ANOVA constitue une extension naturelle au cas où plus de deux moyennes de groupe sont à comparer. Pour $k$ échantillons, l'hypothèse nulle se lit : 
$$ H_0:\ \mu_1=\mu_2=\ldots=\mu_k, $$ 
et l'hypothèse alternative ($H_1$) est l'existence d'au moins une paire de moyennes qui diffèrent (négation logique de $H_0$). 

Si l'on exprime chaque observation comme une déviation par rapport à sa propre moyenne de groupe, $y_{ij}=\bar y_i+\varepsilon_{ij}$, on voit que la variabilité totale peut se décomposer comme suit : $$\underbrace{(y_{ij}-\bar y)}_{\text{totale}}=\underbrace{(\bar y_{i\phantom{j}}\hskip-.5ex-\bar y)}_{\text{groupe}} + \underbrace{(y_{ij}-\bar y_i)}_{\text{résiduelle}}.$$

## Illustration

![Exemple de distribution sur 3 groupes](anova2.png){ width=70% }

## Conditions de validité

![Indépendance, égalité des variances, normalité des résidus](anova.png){ width=70% }


## ANOVA à un facteur

### Le modèle d'ANOVA

Soit $y_{ij}$ la $j$\ieme observation dans le groupe $i$ (facteur A). On peut résumer le modèle à effet comme suit :
$$ y_{ij} = \mu + \alpha_i + \varepsilon_{ij}, $$
où $\mu$ désigne la moyenne générale, $\alpha_i$ l'effet du groupe $i$ ($i=1,\dots,a$), et $\varepsilon_{ij}\sim {\cal N}(0,\sigma^2)$ un terme d'erreur aléatoire. On impose généralement que $\sum_{i=1}^a\alpha_i=0$. 

L'hypothèse nulle se lit $H_0:\alpha_1=\alpha_2=\dots=\alpha_a$, et se teste à l'aide d'un test F à $a-1$ et $N-a$ degrés de liberté.

Des méthodes graphiques (boxplot ou QQ-plot) sont recommendées pour vérifier les hypothèses de normalité ou d'homogénéité des variances à la place de tests formels (Levene, Fisher, Bartlett, etc.).

Il existe des alternatives au modèle paramétrique de base : ANOVA de Welch ne supposant pas l'égalité des variances [@welch-1951-compar-sever], ANOVA non paramétrique de Kruskal-Wallis, ANOVA robuste avec utilisation de moyennes tronquées [@wilcox-2003-moder-robus].


## ANOVA à deux facteurs

### Le modèle d'ANOVA

Soit $y_{ijk}$ la $k$\ieme observation pour le niveau $i$ du facteur $A$ ($i=1,\dots,a$) et le niveau $j$ du facteur $B$ ($j=1,\dots,b$). Le
modèle complet avec interaction s'écrit 
$$ y_{ijk} = \mu + \alpha_i + \beta_j + \gamma_{ij} + \varepsilon_{ijk}, $$
où $\mu$ désigne la moyenne générale, $\alpha_i$ ($\beta_j$) l'écart à la moyenne des moyennes de groupe pour le facteur $A$ ($B$), $\gamma_{ij}$ les écarts à la moyenne des moyennes pour les traitements $A\times B$, et $\varepsilon_{ijk}\sim {\cal N}(0,\sigma^2)$ la résiduelle. Les effets $\alpha_i$ et $\beta_j$ sont appelés effets principaux, tandis que $\gamma_{ij}$ est l'effet d'interaction. 

Les hypothèses nulles associées au modèle complet sont : 

1. $H_0^A:\, \alpha_1=\alpha_2=\dots=\alpha_a$, $(a-1)$ ddl
2. $H_0^B:\, \beta_1=\beta_2=\dots=\beta_b$, $(b-1)$ ddl
3. $H_0^{AB}:\, \gamma_{11}=\gamma_{13}=\dots=\gamma_{ab}$, $(a-1)(b-1)$ ddl

Des tests F (CM effets / CM résiduelle) permettent de tester ces hypothèses.

## Interpréter une interaction

![](interaction.png)

## Remarque sur les formules R

R suit les conventions de notation proposées par Wilkinson & Rogers pour les plans d'expérience [@wilkinson-1973-symbol-descr; @chambers-1992-statis-model-s]. 

| y ~   |                                                  |
|-------|--------------------------------------------------|
| x     | régression linéaire simple                       |
| x + 0 | idem avec suppression de l'intercept             |
| a + b | deux effets principaux (croisement)              |
| a * b | équivalent à 1 + a + b + a:b (interaction)       |
| a / b | équivalent à 1 + a + b  + a %in% b (emboîtement) |

```r
fm <- y ~ a * b * c          ## modèle de base (A, B, C, AB, AC, BC, ABC)
m1 <- aov(fm, data = d)      ## estimation des paramètres du modèle
update(mod1, . ~ . -a:b:c)   ## suppression de l'interaction ABC
```

## Illustration
\vskip2em

> The response is the length of odontoblasts in 10 guinea pigs at three dose levels of Vitamin C with two delivery methods (orange juice or ascorbic acid).
> 
> --- @bliss-1952-statis-bioas

![](fig-toothgrowth.png)

## `<R/>`

```{.r .number-lines}
ToothGrowth$dose <- (*@\texthigh{factor}@*)(ToothGrowth$dose)
fm <- len ~ supp * dose
replications(fm, data = ToothGrowth)
aggregate(fm, ToothGrowth, mean)
m <- aov(fm, data=ToothGrowth)
summary(m)
model.tables(m, type = "means", se = TRUE, cterms = "supp:dose")
```

```{caption="Tableau d'ANOVA"}
            Df Sum Sq Mean Sq F value   Pr(>F)
supp         1  205.4   205.4  15.572 0.000231 ***
dose         2 2426.4  1213.2  92.000  < 2e-16 ***
supp:dose    2  108.3    54.2   4.107 0.021860 *
Residuals   54  712.1    13.2
```

## Commentaires

1. Les tests précédents n'indiquent pas quelles paires de moyennes diffèrent significativement, mais permettent de se prononcer sur l'existence d'un effet et le rejet de l'hypothèse nulle associée. Pour préciser quels sont les traitements qui diffèrent deux à deux, il faudrait utiliser des procédures (post-hoc) de comparaisons multiples.

2. Le facteur `dose` est traité comme une variable qualitative non ordonnée. Un test de linéarité de la relation `len ~ dose` serait toutefois intéressant. Sous R, on peut réaliser un tel test par régression ou en utilisant des contrastes polynomiaux.

3. Pour tester formellement l'hypothèse d'égalité des variances, il faut travailler au niveau de tous les traitements : 

```r
bartlett.test(len ~ interaction(supp, dose), data = ToothGrowth)
```


## Comparaisons multiples planifiées ou non

1. Méthode des contrastes  
Avec $k$ échantillons, on peut définir $k-1$ contrastes orthogonaux
$$ \phi = \sum_{i=1}^kc_i\overline{x}_i,\quad \sum_ic_i=0\; \text{et}\; \phi_u^t\phi_v^{\phantom{t}}=0 $$
et utiliser comme statistique de test, $\frac{\phi}{s_{\phi}}$, où $s_{\phi}^2=s^2\sum_i\frac{c_i^2}{n_i}\sim t(\nu)$.

2. Tests post-hoc  
On a un ensemble de $k(k-1)/2$ paires de moyennes. Pour $k=4$, en fixant $\alpha=0.05$, le risque d'ensemble ou FWER (en supposant les tests indépendants) devient $1-(1-0.05)^6=0.265$, soit 27 % de chance de déclarer à tort un résultat significatif.  
Deux stratégies, généralement conservatrices : modifier la statistique de test (Tukey HSD) ou modifier le risque de première espèce (Bonferroni) [@christensen-2002-plane-answer]. Autres approches : méthode adaptative (Holm), contrôle du FDR, permutations, etc. [@dudoit-2008-multip-testin].

## Cas des protocoles déséquilibrés

Lorsque les effectifs ne sont pas tous égaux entre les traitements, les choses se compliquent, notamment au niveau du calcul séquentiel des sommes de carrés [@herr-1986-histor-anova].

Cas d'un plan à deux facteurs, A et B :

- Type I (défaut): SS($A$), SS($B|A$), puis SS($AB|B$, $A$)
- Type II: SS($A|B$), puis SS($B|A$) (pas d'interaction)
- Type III: SS($A|B$, $AB$), SS($B|A$, $AB$) (interpréter chaque effet principal après avoir pris en compte les autres effets principaux et l'interaction) 


## Méthode d'ajustement *a posteriori*

Applicable également dans le cas des plans de type avant/après, l'analyse de covariance fournit le meilleur estimateur pour la différence différence entre deux groupes de sujets, en comparaison de la simple analyse des scores de différence ou d'une approche par modèle mixte [@senn-2006-chang-from].

### Modèle d'ANCOVA

Soit $y_{ij}$ la $j$ème observation dans le groupe $i$. À l'image du modèle d'ANOVA à un facteur, le modèle d'ANCOVA s'écrit :
$$ y_{ij} = \mu+\alpha_i+\beta(x_{ij}-\bar x)+\varepsilon_{ij},$$ 
où $\beta$ est le coefficient de régression liant la réponse $y$ et le cofacteur $x$ (continu), avec $\bar x$ la moyenne générale des $x_{ij}$, et toujours un terme d'erreur $\varepsilon_{ij}\sim \mathcal{N}(0,\sigma^2)$.

Notons que l'on fait l'hypothèse que $\beta$ est le même dans chaque groupe. Cette hypothèse de parallélisme peut se vérifier en testant la significativité du terme d'interaction $\alpha\beta$.

La réponse moyenne ajustée pour l'effet du co-facteur numérique s'obtient simplement comme $\bar\alpha_i+\hat\beta(\bar x_i-\bar x)$, où $\bar x_i$ est la moyenne des $x$ dans le $i$ème groupe.


# Étude de cas : essai croisé

## Utilisation d'un modèle à effet aléatoire
\vskip2em

> Two-period AB-BA randomised crossover trial in which patients are treated with two bronchodilators, salbutamol (S) and formoterol (F). The outcome is the peak expiratory flow (PEF). Patients received F-S or S-F. 
>
> --- @senn-1993-cross-trial

![](fig-salbutamol.png)

## `<R/>`

```{.r .number-lines}
library(nlme)
m <- lme(value ~ variable * period, data = d, random = ~ 1 | patient)
```





## Pour aller plus loin

:::::::::::::: {.columns}
::: {.column width="50%"}
![](quinn.jpg){ width=80% }
:::
::: {.column width="50%"}
![](maxwell.jpg){ width=80% }
:::
::::::::::::::


## Références {.allowframebreaks}
\setlength{\parindent}{-0.16in}
\setlength{\leftskip}{0.2in}
\setlength{\parskip}{2pt}
\noindent
\small\sffamily


