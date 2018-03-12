# Mémento R

## Structure de données

En règle générale, on travaillera à partir d'un tableau rectangulaire, chaque ligne désignant une unité statistique regroupant un ensemble d'observations attachées à des variables arrangées en colonnes, appelé "data frame" (+@fig:toothgrowth).

```{.r caption="Propriétés d'un data frame"}
data(ToothGrowth)             # chargement de données internes
str(ToothGrowth)              # structure d'un objet R
head(ToothGrowth, n = 5)      # en-tête d'un objet R
```

![Structure d'un data frame](toothgrowth.png){#fig:toothgrowth}
