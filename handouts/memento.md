# Mémento R

## Structure de données

En règle générale, on travaillera à partir d'un tableau rectangulaire, chaque ligne désignant une unité statistique regroupant un ensemble d'observations attachées à des variables arrangées en colonnes : on parle de "data frame" (+@fig:toothgrowth).

```{.r caption="[1] chargement de données internes ; [2] structure d'un objet R ; [3] en-tête d'un tableau"}
data(ToothGrowth)
str(ToothGrowth)
head(ToothGrowth, n = 3)
```

![Structure d'un data frame](toothgrowth.png){width=25% #fig:toothgrowth}
