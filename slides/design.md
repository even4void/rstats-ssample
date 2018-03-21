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

## The Environment and Disease: Association or Causation?

![](Hill-1965.png)

# Plans d'expérience

## Principe des plan d'expérience

- Minimiser le nombre d'essais et maximiser la précision 
- Respecter des contraintes externes (budget, sujets, éthique, durée, exposition, environnement, etc.)
- Maîtriser les sources de variation et les effets de confusion potentiels

## Etudes pré-cliniques : cas d'un plan 3 + 3

![Protocole d'escalade de dose[^1]](3-3.png){ width=50% }

[^1]: Source : [Phase 1 Trial Design: Is 3 + 3 the Best?](https://moffitt.org/media/1310/200.pdf)

## Etudes pré-cliniques : plan dose-réponse

![Protocole de recherche d'effet thérapeutique[^2]](dose-reponse.png){ width=50% }

[^2]: Source : [Drug Safety & the Therapeutic Index](http://tmedweb.tulane.edu/pharmwiki/doku.php/basic_principles_of_pharm)

## Plan complet randomisé (CRD)

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
- Les répliques sont assignées complétement au hasard aux sujets indépendants
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



# Modèles statistiques courants

## Facteurs à effets fixes ou aléatoires

![](random-vs-fixed.png){ width=80% }

## Rappels sur le test de Student

## Analyse de la variance à un facteur

L'ANOVA constitue une extension naturelle au cas où plus de deux moyennes de groupe sont à comparer. Pour $k$ échantillons, l'hypothèse nulle se lit : 
$$ H_0:\ \mu_1=\mu_2=\ldots=\mu_k, $$ 
et l'hypothèse alternative ($H_1$) est l'existence d'au moins une paire de moyennes qui diffèrent (négation logique de $H_0$). 

Si l'on exprime chaque observation comme une déviation par rapport à sa propre moyenne de groupe, $y_{ij}=\bar y_i+\varepsilon_{ij}$, on voit que la variabilité totale peut se décomposer comme suit : $$\underbrace{(y_{ij}-\bar y)}_{\text{totale}}=\underbrace{(\bar y_{i\phantom{j}}\hskip-.5ex-\bar y)}_{\text{groupe}} + \underbrace{(y_{ij}-\bar y_i)}_{\text{résiduelle}}.$$

## Comparaisons multiples

## Méthode d'ajustement *a posteriori*



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


