## Pouzi data 'train' a 'valid' z hodiny (uz nacitane na zaciatku 'my_homework.R').
##
## Tvoja startovacia premenna je 'D_ZIP'. V datasete s finalnymi upravami ju najdes ako 'D_ZIP_1'
## (povodna verzia 'D_ZIP' tam stale je, ale pouzivaj upravenu 'D_ZIP_1').
##
## Predstav si, ze zadavatel (stakeholder) vyslovene chce mat tuto premennu v modeli. Preto z nej vychadzame
## a vyberove metody len rozhoduju, co sa k nej este prida. V metodach je preto tvoja premenna v argumente 'base'.
## Je to podobne ako na hodine v Exercise 1, kde bol zakladnou premennou typ vozidla ('Veh_type2_merged').

## 1. Vytvor glm model 'Burning_Cost ~ D_ZIP_1'.
## Interpretuj vysledok (nezabudni, ze exp(koeficient) je priemerny nasobok narastu cielovej premennej, nie jej nominalna zmena).
## Skus povedat, ci (a preco) vysledok dava zmysel.

## 2. Spusti forward selection podobne ako na hodine, s tym, ze pouzijes `base = "D_ZIP_1"` (zoznam premennych je `candidates`).
## Pozri sa na vyvoj training a validation deviance metriky. Kolko premennych by si pridal a preco?

## 3. Spusti a postupne prejdi cez selekciu podla poradia v grafoch, podobne ako na hodine.
## Pouzi funkciu `rank_by_mismatch` a `base = "D_ZIP_1"`.
## Pozri si grafy, pridaj premennu a niekolko razy zopakuj pre prvych par premennych.
## Vybranu premennu vzdy pridaj do vektora argumentu 'base', napr. `base = c("premenna1", "premenna2")`.
## Ktore a kolko premennych by si pridal a preco?

## 4. Spusti Lasso selection podobne ako na hodine, pouzi ako doteraz `base = "D_ZIP_1"`.

## 5. Porovnaj tri vybery (cca 3 premenne ku startovacej). Ktore premenne sa objavili vo vsetkych troch,
## ktore len v jednej? Porovnaj modely cez compare_models() na train aj valid datach
## a napis kratky komentar, ktoremu vyberu by si dal prednost a preco.
