# Quiz L1-L5 (kandidati na vyber)

20 otazok, kazda ma 4 odpovede. Vyber si 10, ktore pouzijes. Spravne odpovede a typ kazdej odpovede su az na konci (sekcia "Kluc").

> Pred zdielanim materialov so studentmi tento subor presun mimo repozitara (alebo smaz sekciu "Kluc").

---

## Lesson 1

**1. Aky je zakladny rozdiel medzi aktuarom a underwriterom?**

- A) Obaja pracuju len s datami, lisia sa iba tym, ze aktuar ma certifikaciu
- B) Aktuar predava poistne produkty klientom a underwriter vybavuje skody
- C) Actuary analyzuje data a predpoveda buduce skody, underwriter posudzuje konkretne riziko na zaklade skusenosti a odborneho usudku
- D) Actuary pocita, kolko kavy sa vypije na porade, a underwriter urcuje, kto ju kupi

**2. Aky casovy horizont predikcie je typicky pre General (nezivotne) poistenie?**

- A) Kratkodoby - najblizsi rok, v rocnom cykle (vyber poistneho, skody, analyza, obnova)
- B) Dlhodoby - desiatky rokov, az kym klienti nedosiahnu dochodkovy vek
- C) Vzdy len minuly rok, buducnost sa neodhaduje
- D) Do najblizsieho piatku, potom sa ide domov

**3. Co vrati tento kod?**

```r
c(1, 4, 2, 8, -5) |>
  min(-1000, x = _) |>
  abs()
```

- A) 8
- B) 1000
- C) 5
- D) It's over 9000!

---

## Lesson 2

**4. Portfolio ma zasluzene poistne (NEP) 1000, skody 650 a naklady 300. Aky je combined ratio (COR) a underwriting result (UWR)?**

- A) COR 65 %, UWR +350
- B) COR 195 %, UWR -950
- C) COR 42 %, lebo 42 je odpoved na vsetko
- D) COR 95 %, UWR +50

**5. Cim sa lisi broker (makler) od agenta?**

- A) Broker zastupuje poistovnu a agent zastupuje klienta
- B) Broker zastupuje klienta a porovnava ponuky viacerych poistovni, agent zastupuje (zvycajne jednu) poistovnu
- C) Broker predava len zivotne poistenie a agent len nezivotne
- D) Broker obchoduje na burze a agent je Agent 007

**6. 12-mesacna poistka zacina 1. oktobra. Kolko percent z jej poistneho je do konca roka zasluzene (earned)?**

- A) 75 %
- B) 100 %, poistne sa plati vopred
- C) 25 %
- D) Zavisi od toho, kolko dni v oktobri prsalo

---

## Lesson 3

**7. Co vyjadruje age-to-age faktor v trojuholniku?**

- A) Nasobok, o ktory vzrastie kumulativna suma skod z jedneho roku vyvoja do dalsieho
- B) Pomer vyplatenych skod k zasluzenemu poistnemu
- C) Priemerny vek vodicov v danom roku
- D) Vek aktuara v case, ked skoda vznikla

**8. V trojuholniku ma jeden rocnik zakladnu sumu 106, ktora vyskoci na 4285 (cca 40-nasobok). Preco pri priemerovani faktorov pouzivame vazeny priemer s vahami podla objemu platieb?**

- A) Aby novsie roky mali vacsiu dolezitost nez starsie
- B) Aby bol vypocet rychlejsi
- C) Lebo vazeny priemer je zdravsi, ma menej kalorii
- D) Aby rocniky s malym objemom nemali neprimerane velky vplyv na vysledok

**9. Co znamena, ze linia biznisu je "short tail"?**

- A) Skody sa vyvinu a vyplatia rychlo, age-to-age faktory sa po par rokoch blizia k 1
- B) Skody su male
- C) Poistne zmluvy su kratke
- D) Poistuju sa len zvierata s kratkym chvostom

**10. Strata 1000 sa vyplati o 2 roky. Aka je jej sucasna hodnota pri urokovej sadzbe 5 %?**

- A) 900
- B) cca 907
- C) cca 1102,5
- D) Presne 1000, zvysok si poistovna necha na kavu

---

## Lesson 4

**11. Klient A mal skodu 5000 a bol poisteny 6 mesiacov. Klient B mal tiez skodu 5000 a bol poisteny 12 mesiacov. Co plati?**

- A) Obaja su rovnako rizikovi, skoda je rovnaka
- B) B je rizikovejsi, lebo bol poisteny dlhsie
- C) Rizikovejsi je ten, ktoremu poistovna menej sympatizuje
- D) A je cca 2x rizikovejsi, pretoze rovnaku skodu sposobil za polovicu casu (exposure)

**12. Spajame poistky so skodami pomocou left_join. Jedna poistka ma 2 skody. Co sa stane, ak skody pred spojenim nezagregujeme?**

- A) Poistka s viac skodami sa z vysledku vypusti
- B) R vypise chybu, lebo kluc nie je jedinecny
- C) Riadok poistky sa zduplikuje, a napr. sum(Premium_earned) ju zapocita dvakrat
- D) Klient zaplati poistne dvakrat aj v skutocnosti

**13. Frekvencia je 0,10 skody na poistny rok a priemerna skoda (severity) je 5000. Aky je burning cost?**

- A) 50 000
- B) 5 000,1
- C) Akurat tak na dovolenku
- D) 500 na poistny rok

**14. Poistka A: exposure 1,0 a skoda 1000. Poistka B: exposure 0,1 a skoda 500. Aky je burning cost portfolia A + B?**

- A) cca 1364
- B) 3000 (priemer 1000 a 5000)
- C) 6000 (sucet 1000 a 5000)
- D) Presne 42

**15. Preco nemozeme vsetkym klientom uctovat rovnaku priemernu cenu (adverse selection)?**

- A) Poistovna by si vybrala len tych najlepsich klientov
- B) Klienti by si pri uzatvarani poistky vyberali ponuky nahodne
- C) Dobri klienti by odisli k lacnejsej konkurencii a zostali by nam tie horsie rizika
- D) Agent by si vybral nevhodnu farbu kravaty

---

## Lesson 5

**16. V GLM s log linkom ma TRUCK koeficient 0,405 (oproti zakladnej kategorii CAR). Ako ho interpretujeme?**

- A) Riziko je o 40,5 % vyssie
- B) Riziko je cca 1,5x vyssie (exp(0,405) = 1,5), pri nezmenenych ostatnych premennych
- C) Priemerna skoda je o 0,405 EUR vyssia
- D) Nakladne auto ma 0,405 kolesa navyse

**17. Model ma RMSE na trenovacich datach 3 a na validacnych datach 40. Co to typicky naznacuje?**

- A) Model je prilis jednoduchy (underfitting)
- B) Validacna sada ma iny pocet stlpcov
- C) Model sa prilis prisposobil trenovacim datam (overfitting)
- D) Validacne data su unavene, lebo sa pocitali ako posledne

**18. Skutocna rizikovost (Actual) sa podla numerickej premennej raz zvysuje a raz znizuje bez jasneho trendu. Co z feature engineeringu je najvhodnejsie?**

- A) Orezat extremne hodnoty na hranice (capping)
- B) Rozdelit premennu na pasma (banding) a pouzit ju ako kategoriu
- C) Zmazat validacnu sadu
- D) Pridat do dat nahodne cisla, aby sa trend vyhladil

**19. Preco pouzivame Tweedie rozdelenie pre burning cost?**

- A) Burning cost ma vela presnych nul (poistky bez skody) a kladne sumy inak - Tweedie je zlozene Poisson-Gamma rozdelenie
- B) Pretoze je to Gamma rozdelenie, ktore je vhodne pre kladne sumy (nuly nie su problem)
- C) Pretoze burning cost je pocet skod
- D) Pretoze vsetko je normalne

**20. Pri premennej, ktora este nie je v modeli, hladas v grafe Actual vs Fitted ako signal, ze ju stoji za to pridat:**

- A) Actual a Fitted sa takmer prekryvaju
- B) Najvyssi stlpec exposure je pri strednej hodnote
- C) Peknu farebnu schemu grafu
- D) Jasny trend v Actual, zatial co Fitted je takmer rovna ciara

---
---

# Kluc

Pre kazdu otazku je pri pismene A-D uvedeny typ odpovede: **K** = spravna, **T** = tazky kandidat, **U** = nepravdepodobna, **F** = vtipna/nesuvisiaca.

| # | Spravne | A | B | C | D | Vysvetlenie |
|---|---|---|---|---|---|---|
| 1 | C | T | U | K | F | Actuary = data, underwriter = skusenost a usudok (L1). Certifikacia je tiez rozdiel, ale nie zakladny. |
| 2 | A | K | T | U | F | General = rocny cyklus, Life = dlhodoby horizont (L1). |
| 3 | B | U | K | T | F | `min(-1000, x = c(1,4,2,8,-5))` = -1000, `abs` = 1000. Odpoved 5 by platila, keby sa -1000 ignorovalo. |
| 4 | D | T | U | F | K | LR 65 % + ER 30 % = COR 95 %; UWR = 1000 * (1 - 0,95) = 50. Odpoved A zabuda na naklady (len LR). |
| 5 | B | T | K | U | F | Broker = klient, agent = poistovna (L2). Odpoved A je prehodena. |
| 6 | C | T | U | K | F | Oktober az december = 3 z 12 mesiacov = 25 %. 75 % je este nezasluzena cast. |
| 7 | A | K | T | U | F | ATA faktor = pomer kumulativnych platieb v dalsom vs. aktualnom roku vyvoja. B je loss ratio. |
| 8 | D | T | U | F | K | Maly objem (106 -> 4285) by v nevazenom priemere skreslil vysledok (L3 Ex1). |
| 9 | A | K | T | U | F | Short tail = rychly vyvoj/vyplata, ATA faktory sa rychlo blizia k 1 (L3 Ex36). |
| 10 | B | T | K | U | F | 1000 / 1,05^2 = 907,03. A je jednoduche (nie zlozene) urocenie, C je opacny smer (compounding). |
| 11 | D | T | U | F | K | Rovnaka skoda za polovicu casu = burning cost 10 000 vs 5 000 rocne (L4 exposure). |
| 12 | C | T | U | K | F | Fan-out pri nezagregovanych skodach (L4 Ex1). Left join poistku nevypusti a chybu nevypise. |
| 13 | D | T | U | F | K | Frequency x Severity = 0,10 x 5000 = 500 (L4 Ex2). A (50 000) je 100x privelka suma, vznikne pri zamene jednotiek (napr. frekvencia v percentach: 5 000 x 10). |
| 14 | A | K | T | U | F | (1000 + 500) / (1,0 + 0,1) = 1363,6. Pravidlo z L4: scitaj citatel a menovatel zvlast, potom deli. B je priemer pomerov, C je sucet pomerov. |
| 15 | C | T | U | K | F | Adverse selection (L4 Modeling Motivation): dobre rizika odidu, zostanu horsie. A je opak. |
| 16 | B | T | K | U | F | exp(0,405) = 1,5, takze x1,5 (+50 %), nie +40,5 %. Najcastejsia chyba. |
| 17 | C | T | U | K | F | Velky rozdiel medzi train a valid = overfitting (L5 Ex2). |
| 18 | B | T | K | U | F | Pozor: v tejto otazke je K = B, T = A (capping), U = C, F = D. Banding zachyti nelinearny alebo nemonotonny vzor (L5 Ex1/Ex3). |
| 19 | A | K | T | U | F | Tweedie 1 < p < 2 = Poisson-Gamma, nuly aj kladne sumy (L5 GLM motivation). Gamma nepripusta nuly. |
| 20 | D | T | U | F | K | Trend v Actual + plochy Fitted = kandidat na pridanie (homework hints L5). Prekryvanie je situacia pre premennu uz v modeli. |

**Rozlozenie spravnych odpovedi:** A = 5 (2, 7, 9, 14, 19), B = 5 (3, 5, 10, 16, 18), C = 5 (1, 6, 12, 15, 17), D = 5 (4, 8, 11, 13, 20).

Po vybere 10 otazok skontroluj, ci sa spravne odpovede stale rozkladaju rovnomerne medzi A-D.
