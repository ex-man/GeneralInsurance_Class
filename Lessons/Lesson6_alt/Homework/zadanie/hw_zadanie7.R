## Pouzi data 'train' a 'valid' z hodiny (nacitane podla 'my_homework.R').
##
## Tvoja startovacia premenna je 'Sum_insured'. V datasete upravenom na hodine ju najdes ako 'Sum_insured_log'
## (povodna verzia 'Sum_insured' tam stale je, ale pouzivaj 'Sum_insured_log').
##
## Predstav si, ze zadavatel (stakeholder) vyslovene chce mat tuto premennu v modeli. Preto z nej vychadzame
## a vyberove metody len rozhoduju, co sa k nej este prida. V metodach je preto tvoja premenna v argumente 'base'.
## Typ vozidla ('Veh_type2_merged') tu nie je zaklad, je to obycajny kandidat, ktoreho metody mozu pridat
## (je v zozname 'hw_candidates' z 'my_homework.R').

## 1. Vytvor glm model 'Burning_Cost ~ Sum_insured_log'.
## Interpretuj vysledok (nezabudni, ze exp(koeficient) je nasobok, nie pricitanie).
## Skus povedat, ci (a preco) vysledok dava zmysel.

## 2. Forward selection: spusti forward_select(train, valid, hw_candidates, base = "Sum_insured_log") a pozri sa
## na vyvoj train_dev a valid_dev. Kolko premennych by si pridal a preco?

## 3. Poradie podla grafov: pre model z bodu 1 zavolaj rank_by_mismatch(train, hw_candidates, base = "Sum_insured_log") a pozri si grafy (emb_chart_plotly na $data)
## prvych par premennych. Pridaj vybranu premennu do 'base' (napr. base = c("<tvoja premenna>", "<pridana>")), zavolaj funkciu znova, a opakuj 2-krat. Ktore premenne si vybral?

## 4. Lasso: spusti lasso_entry_order(train, hw_candidates, base = "Sum_insured_log").

## 5. Porovnaj tri vybery (po 3 premenne ku startovacej). Ktore premenne sa objavili vo vsetkych troch,
## ktore len v jednej? Porovnaj modely cez compare_models() na train aj valid datach
## a napis kratky komentar, ktoremu vyberu by si dal prednost a preco.
