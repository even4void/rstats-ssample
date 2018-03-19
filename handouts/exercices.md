# Exercices d'application
Exercices 1, 2, 3, 4 et 7 tirés et adpatés de @wilcox-2012-moder-statis.

## Comparaison de moyennes

\#1  
`t.test()`, `yuen()`, `permg()`  
Responses to stress are governed by the hypothalamus. Imagine you have two groups of participants. The first shows signs of heart disease and the other does not. You want to determine whether the groups differ in terms of the weight of the hypothalamus. For the first group of participants with no heart disease, the weights are

    11.1, 12.2, 15.5, 17.6, 13.0, 7.5, 9.1, 6.6, 9.5, 19.0, 12.6
    
For the other group with heart disease, the weights are

    18.2, 14.1, 13.8, 12.1, 34.1, 12.0, 14.1, 14.5, 12.6, 12.5, 19.8, 13.4, 16.8, 
    14.1, 12.9

- Determine whether the groups differ based on Welch's test. Use $\alpha = 0.05$.
- Compare the observed $p$-value with that obtained from a permutation test.
- What are the results of applying a Yuen's test (using 10% trimming) on this dataset?
    
\#2  
`rank()`, `wilcox.test()`  
Two independant groups are given different cold medicines and the goal is to compare reaction times. Suppose that the decrease in reaction times when taking drug A versus drug B are as follows.

    A: 1.96, 2.24, 1.71, 2.41, 1.62, 1.93
    B: 2.11, 2.43, 2.07, 2.71, 2.50, 2.84, 2.88

- Compute average ranks in the two groups.
- Verify that the Wilcoxon-Mann-Whitney test rejects with $\alpha = 0.05$.
- Estimate the probability that a randomly sampled participant receiving drug A will have a smaller reduction in reaction time than a randomly sampled participant receiving drug B. Verify that the estimate is 0.9.

\#3  
`wilcox.test()`, `signt()`  
For two dependent groups you get

    Group 1: 10, 14, 15, 18, 20, 29, 30, 40
    Group 2: 40, 8, 15, 20, 10, 8, 2, 3

- Compare the two groups with the sign test a,d the Wilcoxon signed rank test with $\alpha = 0.05$.
- Verify that according to the sign test, $\hat p = 0.29$ and that the 0.95 confidence interval for $p$ is $(0.04,0.71)$, and that the Wilcoxon signed rank test has an approcimate $p$-value of 0.08.

## ANOVA

\#4  
`aov()`, `oneway.test()`, `car::Anova(..., white.adjust = TRUE)`  
For the following data, verify that you do not reject with the ANOVA F testing with $\alpha = 0.05$, but you do reject with Welch's test.

    Group 1: 10, 11, 12, 9, 8, 7
    Group 2: 10, 66, 15, 32, 22, 51
    Group 3: 1, 12, 42, 31, 55, 19

What might explain the discrepancy between the two methods?

\#5  
`aov()`, `pairwise.t.test()`, `agricolae::LSD.test()`, `multcomp::glht()`  
Avec les données sur le poids des rats (`weight.dat`), réaliser un modèle d'ANOVA à deux facteurs incluant l'interaction entre les deux facteurs.

- Quels sont les effets significatifs ?
- Effectuer toutes les comparaisons de paires de moyennes par des tests de Student en assumant ou non une variance commune, et comparer les résultats avec des tests protégés de type LSD ou Tukey.


## Régression linéaire

\#6  
Les données `Toothgrowth` (`data(ToothGrowth)`) portent sur une étude sur la longueur des odontoblastes (variable `len`) chez 10 cochons d'inde après administration de vitamine C à différentes doses (0.5, 1 ou 2 mg, variable `dose`) sous forme d'acide ascorbique ou de jus d'orange (variable `supp`).

- Construire un graphique d'interaction (`dose` en abscisses) et commenter.
- Réaliser un test de Student pour comparer les groupes `OJ` et `VC` pour `dose == 0.5`. Les deux groupes peuvent-ils être considérés comme différent au seuil $\alpha = 0.05$ ?
- Réaliser une ANOVA à deux facteurs avec interaction. Peut-on conclure à l'existence d'un effet dose dépendant du mode d'administration de la vitamine C ?
- Tester la linéarité de l'effet dose à l'aide d'un modèle de régression linéaire.

\#7


## Références
