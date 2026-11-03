## Pouzi data 'train' a 'valid' z hodiny (nacitane podla 'my_homework.R').
##
## Tvoja startovacia premenna je 'Nr_of_seats'. V datasete upravenom na hodine ju najdes ako 'Nr_of_seats_grp'
## (povodna verzia 'Nr_of_seats' tam stale je, ale pouzivaj 'Nr_of_seats_grp').

## 1. Vytvor glm model 'Burning_Cost ~ Nr_of_seats_grp'.
## Interpretuj vysledok (nezabudni, ze exp(koeficient) je nasobok, nie pricitanie).
## Skus povedat, ci (a preco) vysledok dava zmysel.

## 2. Forward selection: spusti forward_select(train, valid, candidate_vars, start = "Nr_of_seats_grp") a pozri sa
## na vyvoj train_dev a valid_dev. Kolko premennych by si pridal a preco?

## 3. Poradie podla grafov: pre model z bodu 1 zavolaj rank_by_mismatch(train, candidate_vars, start = "Nr_of_seats_grp") a pozri si grafy (emb_chart_plotly na $data)
## prvych par premennych. Pridaj premennu, refituj, a opakuj 2-krat. Ktore premenne si vybral?

## 4. Lasso: spusti lasso_entry_order(train, candidate_vars, start = "Nr_of_seats_grp").

## 5. Porovnaj tri vybery (po 3 premenne ku startovacej). Ktore premenne sa objavili vo vsetkych troch,
## ktore len v jednej? Porovnaj modely cez compare_models() na train aj valid datach
## a napis kratky komentar, ktoremu vyberu by si dal prednost a preco.
