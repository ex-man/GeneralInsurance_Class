## Pouzi data 'train' a 'valid' z hodiny (nacitane cez load_l6_data, viz 'my_homework.R').
##
## Tvoja startovacia premenna je 'Sum_insured'. V datasete upravenom na hodine ju najdes ako 'Sum_insured_log'
## (povodna verzia 'Sum_insured' tam stale je, ale pouzivaj 'Sum_insured_log').

## 1. Vytvor glm model 'Burning_Cost ~ Veh_type2_merged + Sum_insured_log'.
## Interpretuj vysledok (nezabudni, ze exp(koeficient) je nasobok, nie pricitanie).
## Skus povedat, ci (a preco) vysledok dava zmysel.

## 2. Forward selection: spusti forward_select(train, valid, candidate_vars, start = "Sum_insured_log") a pozri sa
## na vyvoj train_dev a valid_dev. Kolko premennych by si pridal a preco?

## 3. Poradie podla grafov: pre model z bodu 1 zavolaj mismatch_rank() a pozri si grafy (emb_chart_plotly)
## prvych par premennych. Pridaj premennu, refituj, a opakuj 2-krat. Ktore premenne si vybral?

## 4. Lasso: spusti lasso_entry_order(train, setdiff(candidate_vars, "Sum_insured_log"), start = "Sum_insured_log").

## 5. Porovnaj tri vybery (po 3 premenne ku startovacej). Ktore premenne sa objavili vo vsetkych troch,
## ktore len v jednej? Porovnaj modely cez compare_models() na train aj valid datach
## a napis kratky komentar, ktoremu vyberu by si dal prednost a preco.
