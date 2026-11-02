## Pouzi data 'train' a 'valid' z hodiny (nacitane cez load_l6_data, viz 'my_homework.R').
##
## Tvoja startovacia premenna je 'Capacity'. V datasete upravenom na hodine ju najdes ako 'Capacity_band'
## (povodna verzia 'Capacity' tam stale je, ale pouzivaj 'Capacity_band').

## 1. Vytvor glm model 'Burning_Cost ~ Veh_type2_merged + Capacity_band'.
## Interpretuj vysledok (nezabudni, ze exp(koeficient) je nasobok, nie pricitanie).
## Skus povedat, ci (a preco) vysledok dava zmysel.

## 2. Forward selection: spusti forward_select(train, valid, candidate_vars, start = "Capacity_band") a pozri sa
## na vyvoj train_dev a valid_dev. Kolko premennych by si pridal a preco?

## 3. Poradie podla grafov: pre model z bodu 1 zavolaj mismatch_rank() a pozri si grafy (emb_chart_plotly)
## prvych par premennych. Pridaj premennu, refituj, a opakuj 2-krat. Ktore premenne si vybral?

## 4. Lasso: spusti lasso_entry_order(train, setdiff(candidate_vars, "Capacity_band"), start = "Capacity_band").

## 5. Porovnaj tri vybery (po 3 premenne ku startovacej). Ktore premenne sa objavili vo vsetkych troch,
## ktore len v jednej? Porovnaj modely cez compare_models() na train aj valid datach
## a napis kratky komentar, ktoremu vyberu by si dal prednost a preco.
