# Exercices d'application
Exercices 1, 2, 3 et 5 tirés et adpatés de @wilcox-2012-moder-statis.

## Comparaison de moyennes

\#1  
Responses to stress are governed by the hypothalamus.[^1] Imagine you have two groups of participants. The first shows signs of heart disease and the other does not. You want to determine whether the groups differ in terms of the weight of the hypothalamus. For the first group of participants with no heart disease, the weights are

    11.1, 12.2, 15.5, 17.6, 13.0, 7.5, 9.1, 6.6, 9.5, 19.0, 12.6
    
For the other group with heart disease, the weights are

    18.2, 14.1, 13.8, 12.1, 34.1, 12.0, 14.1, 14.5, 12.6, 12.5, 19.8, 13.4, 16.8, 
    14.1, 12.9

- Determine whether the groups differ based on Welch's test. Use $\alpha = 0.05$.
- Compare the observed $p$-value with that obtained from a permutation test.
- What are the results of applying a Yuen's test (using 10% trimming) on this dataset?
    
[^1]: `t.test()`, `yuen()` (fonction externe, à charger dans l'espace de travail à l'aide de `source()`)

\#2  
Two independant groups are given different cold medicines[^2] and the goal is to compare reaction times. Suppose that the decrease in reaction times when taking drug A versus drug B are as follows.

    A: 1.96, 2.24, 1.71, 2.41, 1.62, 1.93
    B: 2.11, 2.43, 2.07, 2.71, 2.50, 2.84, 2.88

- Compute average ranks in the two groups.
- Verify that the Wilcoxon-Mann-Whitney test rejects with $\alpha = 0.05$.
- Estimate the probability that a randomly sampled participant receiving drug A will have a smaller reduction in reaction time than a randomly sampled participant receiving drug B. Verify that the estimate is 0.9.

[^2]: `rank()`, `wilcox.test()`

\#3  
For two dependent groups you get[^3]

    Group 1: 10, 14, 15, 18, 20, 29, 30, 40
    Group 2: 40, 8, 15, 20, 10, 8, 2, 3

- Compare the two groups with the sign test and the Wilcoxon signed rank test with $\alpha = 0.05$.
- Verify that according to the sign test, $\hat p = 0.29$ and that the 0.95 confidence interval for $p$ is $(0.04,0.71)$, and that the Wilcoxon signed rank test has an approcimate $p$-value of 0.08.

[^3]: `wilcox.test()`, `signt()` (fonction externe, à charger dans l'espace de travail à l'aide de `source()`). Le test des signes repose sur l'idée de comparer deux échantillons appariés, où $x_{ij}$ désigne la $i$\ieme observation du groupe $j$. Si l'on suppose qu'il n'y a pas d'ex-aequo ($x_{i1} \neq x_{i2}$), la probabilité qu'une observation du groupe 1 soit inférieure à celle du groupe 2, $p = \Pr (x_{i1} < x_{i2})$, se calcule comme la proportion des différences $d_i = x_{i1} < x_{i2} < 0$. Si l'on note $v_i = 1$ si $d_i < 0$, 0 sinon, alors $\hat p = \tfrac{1}{n}\sum v_i$ et on peut tester $H_0:\, p = 0.5$.

\#4  
Avec les données `sleep`[^4], réaliser un test de Student pour échantillons appariés.

- Quelle est la puissance a posteriori d'une telle comparaison (10 sujets) ?
- Calculer les scores de différences entre les deux hypnotiques et réaliser un test t à un échantillon en testant la nullité de la moyenne des différences.
- Estimer un intervalle de confiance à 95 % pour cette moyenne des différences par bootstrap.

[^4]: `data(sleep)`, `power.t.test()`, `boot.ci()` (package boot)

## ANOVA

\#5  
For the following data[^5], verify that you do not reject with the ANOVA F testing with $\alpha = 0.05$, but you do reject with Welch's test.

    Group 1: 10, 11, 12, 9, 8, 7
    Group 2: 10, 66, 15, 32, 22, 51
    Group 3: 1, 12, 42, 31, 55, 19

What might explain the discrepancy between the two methods?

[^5]: `aov()`, `oneway.test()`, il est également possible d'utiliser la fonction `Anova(..., white.adjust = TRUE)` (package `car`)

\#6  
Avec les données sur le poids des rats (`weight.dat`)[^6], réaliser un modèle d'ANOVA à deux facteurs incluant l'interaction entre les deux facteurs.

- Quels sont les effets significatifs ?
- Effectuer toutes les comparaisons de paires de moyennes par des tests de Student en assumant ou non une variance commune, et comparer les résultats avec des tests protégés de type LSD ou Tukey.

[^6]: `aov()`, `pairwise.t.test()`, `LSD.test()` (package `agricolae`), `glht()` (package `multcomp`)

\#7  
Authors studied the effect of different dieting treatment on 60 rats[^7], and they considered two factors of interest: type of proteins used to feed the rats (beef, pork, cereals) and their concentration level (high or low). The response variable was the weight gain (in grams) after treatment. Data are available in the `rats.rda` data file.

```{.r .number-lines}
load("rats.rda")
rat <- within(rat, {
    Diet.Amount <- factor(Diet.Amount, levels = 1:2, labels = c("High", "Low"))
    Diet.Type <- factor(Diet.Type, levels = 1:3, 
                        labels = c("Beef", "Pork", "Cereal"))
})
```

![Exemple de graphique d'interaction](../assets/fig-toothgrowth.png)

- Show average responses for the 60 rats in an interaction plot.
- Consider the following 6 treatments: Beef/High, Beef/Low, Pork/High, Pork/Low, Cereal/High, et Cereal/Low. What is the result of the F-test for a one-way ANOVA?
- Use `pairwise.t.test()` with Bonferroni correction to identify pairs of treatments that differ significantly one from the other.
- Based on these 6 treatments, build a matrix of 5 contrasts allowing to test the following conditions: beef vs. cereal and beef vs. porc (2 DF); high vs. low dose (1 DF); and interaction type/amount (2 DF). Partition the SS associated to treatment computed in (2) according to these contrasts, and test each contrast at a 5% level (you can consider that there's no need to correct the multiple tests if contrasts were defined a priori).
- Compare those results with a two-way ANOVA including the interaction between type and amount.
- Test the following post-hoc contrast: beef and pork at high dose (i.e., Beef/High and Pork/High) vs. the average of all other treatments. Is the result significant at the 5% level? What does this result suggest?

[^7]: `aov()`, `contrasts()`, `glht()` (package `multcomp`)

## Régression linéaire

\#8  
Les données `Toothgrowth`[^8] portent sur une étude sur la longueur des odontoblastes (variable `len`) chez 10 cochons d'inde après administration de vitamine C à différentes doses (0.5, 1 ou 2 mg, variable `dose`) sous forme d'acide ascorbique ou de jus d'orange (variable `supp`).

- Construire un graphique d'interaction (`dose` en abscisses) et commenter.
- Réaliser un test de Student pour comparer les groupes `OJ` et `VC` pour `dose == 0.5`. Les deux groupes peuvent-ils être considérés comme différent au seuil $\alpha = 0.05$ ?
- Réaliser une ANOVA à deux facteurs avec interaction. Peut-on conclure à l'existence d'un effet dose dépendant du mode d'administration de la vitamine C ?
- Tester la linéarité de l'effet dose à l'aide d'un modèle de régression linéaire.

[^8]: `data(ToothGrowth)`, `t.test()`, `factor()`, `aov()`, `as.numeric()`, `lm()`

\#9  
Les données `anorexia` (package `MASS`)[^9] résument le poids de 72 patientes, en kg, avant et après traitement, selon le groupe de traite- ment (thérapie familiale, `FT` ou cognitive, `CBT`). Il y a également 26 patientes dans un groupe contrôle (`Cont`).

- Construire un diagramme de dispersion (`Prewt` en abscisses, `Postwt` en ordonnées) avec des droites de régression conditionnelles pour chacun des trois groupes.
- Comparer à l'aide de tests de Student les 3 groupes dans la période pré-traitement.
- Réaliser un modèle d'ANCOVA en testant l'interaction `Treat:Prewt`, en incluant le groupe contrôle ou non.

[^9]: `data(anorexia, package = "MASS")`, `t.test()`, `lm()`, `anova()`

\#10  
Avec les données `babies.txt`[^10], effectuer une ANOVA sur mesures répétées en considérant le logarithme de la force d'inspiration (`inspirat`) comme variable dépendante et la pression maximale (`maxp`) comme variable indépendante. Comparer avec une approche par modèle de régression avec effet aléatoire.

[^10]: `read.table()`, `aov()`, `nlme::lme()`. Attention aux valeurs manquantes !


## Références
