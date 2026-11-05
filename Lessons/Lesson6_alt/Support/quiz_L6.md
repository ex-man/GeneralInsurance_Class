# Kvíz – Lekcia 6 (12 otázok)

12 otázok, každá má 4 odpovede. Správna odpoveď je označená ✅. Typ každej odpovede (K/T/U/F) je v sekcii „Kľúč" na konci.

> Pred zdieľaním materiálov so študentmi presuň tento súbor mimo repozitára (alebo zmaž značky ✅ a sekciu „Kľúč").

---

**1. Aký je základný rozdiel medzi aktuárom a underwriterom?**

- A) Obaja pracujú len s dátami, líšia sa iba tým, že aktuár má certifikáciu
- B) Aktuár predáva poistné produkty klientom a underwriter vybavuje poistné udalosti
- C) ✅ Aktuár analyzuje dáta a predpovedá budúce poistné udalosti, underwriter posudzuje konkrétne riziko na základe skúseností a odborného úsudku
- D) Aktuár počíta, koľko kávy sa vypije na porade, a underwriter určuje, kto ju kúpi

**2. Aký časový horizont predikcie je typický pre neživotné poistenie?**

- A) ✅ Krátkodobý – najbližší rok, v ročnom cykle (výber poistného, poistné udalosti, analýza, obnova)
- B) Dlhodobý – desiatky rokov, až kým klienti nedosiahnu dôchodkový vek
- C) Strednodobý – 2 až 3 roky, kým sa vyvinú všetky poistné udalosti
- D) Do najbližšieho piatku, potom sa ide domov

**3. Čo vráti tento kód?**

```r
c(1, 4, 2, 8, -5) |>
  min(-1000, x = _) |>
  abs()
```

- A) 8
- B) ✅ 1000
- C) 5
- D) Chybu, lebo sa Rko urazilo na zápornú tisícku

**4. Portfólio má zarobené poistné (NEP) 1000, poistné udalosti 650 a administratívne náklady 300. Aké je combined ratio (COR) a underwriting result (UWR)?**

- A) COR 65 %, UWR +350
- B) COR 195 %, UWR −950
- C) COR 100 %, UWR 0 – manažment to vždy zaokrúhli tak, aby si vyplatil bonus
- D) ✅ COR 95 %, UWR +50

**5. Čo vyjadruje age-to-age faktor v trojuholníku?**

- A) Pomer vyplatených poistných udalostí k zarobenému poistnému
- B) ✅ Násobok, o ktorý vzrastie kumulatívna suma poistných udalostí z jedného roku vývoja do ďalšieho
- C) Pomer konečných (ultimate) poistných udalostí k doteraz vyplateným
- D) Vek aktuára v čase, keď poistná udalosť vznikla

**6. Čo znamená, že poistný produkt je „short tail"?**

- A) Poistné udalosti sú malé
- B) Poistné zmluvy sa uzatvárajú len na krátke obdobie
- C) ✅ Poistné udalosti sa vyvinú a vyplatia rýchlo, age-to-age faktory sa po pár rokoch blížia k 1
- D) Poisťujú sa len zvieratá s krátkym chvostom

**7. Klient A mal poistnú udalosť 5000 a bol poistený 6 mesiacov. Klient B mal tiež poistnú udalosť 5000 a bol poistený 12 mesiacov. Ktoré z tvrdení platí?**

- A) ✅ A je cca 2× rizikovejší, pretože rovnako vysokú poistnú udalosť zaznamenal za polovicu času (exposure)
- B) Obaja sú rovnako rizikoví, poistná udalosť je rovnaká
- C) B je rizikovejší, lebo bol poistený dlhšie
- D) Rizikovejší je ten, kto pri nahlasovaní poistnej udalosti plakal hlasnejšie

**8. Frekvencia je 0,10 poistnej udalosti na poistný rok a priemerná poistná udalosť (severity) je 5000. Aký je burning cost?**

- A) 50 na poistný rok
- B) 5 000,10
- C) Toľko, koľko stojí spálený toast v kancelárskej kuchynke
- D) ✅ 500 na poistný rok

**9. V GLM s log linkom má TRUCK koeficient 0,405 (oproti základnej kategórii CAR). Ako ho interpretujeme?**

- A) Riziko je o 40,5 % vyššie
- B) Priemerná poistná udalosť je o 0,405 EUR vyššia
- C) ✅ Riziko je cca 1,5× vyššie (exp(0,405) = 1,5) pri nezmenených ostatných premenných
- D) Nákladné auto má v priemere 0,405 kolesa navyše

**10. Počas trénovania modelu sa trénovacie RMSE postupne znižuje, ale validačné RMSE od istého bodu začne rásť. Čo to typicky naznačuje?**

- A) Model je príliš jednoduchý (underfitting)
- B) ✅ Model sa príliš prispôsobil trénovacím dátam (overfitting)
- C) Model sa zlepšuje, rastúce validačné RMSE môžeme ignorovať
- D) Validačné dáta sú unavené, lebo sa počítali ako posledné

**11. Skutočná rizikovosť (Actual) sa pri numerickej premennej (napr. vek vodiča) viackrát zvyšuje a znižuje, bez jasného rastúceho alebo klesajúceho trendu. Ako túto premennú najvhodnejšie upravíme pred potenciálnym vstupom do GLM s log linkom?**

- A) Orežeme extrémne hodnoty na hranice (capping)
- B) Vynásobíme premennú −1, aby sa otočil smer trendu
- C) Z grafu odstránime os, aby nebolo vidieť, že trend chýba
- D) ✅ Rozdelíme premennú na pásma (banding) a použijeme ju ako kategóriu

**12. Pozeráš sa na graf Actual vs Fitted pri premennej, ktorá ešte nie je v modeli. Ktoré pozorovanie je signálom, že ju stojí za to pridať?**

- A) ✅ Jasný trend v Actual, zatiaľ čo Fitted je takmer rovná čiara
- B) Actual je zubatý a Fitted ho nesleduje, hoci pásma majú veľmi malé exposure
- C) Actual a Fitted sa takmer prekrývajú
- D) Pekná farebná schéma grafu

---
---

# Kľúč

Pre každú otázku je pri písmene A–D uvedený typ odpovede: **K** = správna, **T** = ťažký kandidát (pôsobí pravdepodobne), **U** = viditeľne nesprávna, **F** = vtipná, ale tematicky súvisiaca.

| # | Správne | A | B | C | D | Vysvetlenie |
|---|---|---|---|---|---|---|
| 1 | C | T | U | K | F | Aktuár = dáta, underwriter = skúsenosť a úsudok (L1). Certifikácia je tiež rozdiel, ale nie základný. |
| 2 | A | K | U | T | F | Neživotné poistenie = ročný cyklus, životné = dlhodobý horizont (L1). Poistné udalosti sa síce vyvíjajú aj niekoľko rokov, ale predikujeme a ceníme na najbližší rok. |
| 3 | B | U | K | T | F | `min(-1000, x = c(1,4,2,8,-5))` = −1000, `abs` = 1000. Odpoveď 5 by platila, keby sa −1000 ignorovalo. |
| 4 | D | T | U | F | K | Loss ratio 65 % + expense ratio 30 % = COR 95 %; UWR = 1000 · (1 − 0,95) = 50. Odpoveď A zabúda na administratívne náklady (len loss ratio). |
| 5 | B | U | K | T | F | ATA faktor = pomer kumulatívnych platieb v ďalšom vs. aktuálnom roku vývoja. A je loss ratio, C je kumulatívny vývojový faktor (CDF), nie age-to-age. |
| 6 | C | U | T | K | F | Short tail = rýchly vývoj a vyplatenie, ATA faktory sa rýchlo blížia k 1 (L3 Ex36). Dĺžka zmluvy s tým nesúvisí. |
| 7 | A | K | T | U | F | Rovnaká poistná udalosť za polovicu času = burning cost 10 000 vs. 5 000 ročne (L4 exposure). |
| 8 | D | T | U | F | K | Frequency × Severity = 0,10 × 5000 = 500 (L4 Ex2). A vznikne pri zámene jednotiek (0,10 → 0,01). |
| 9 | C | T | U | K | F | exp(0,405) = 1,5, takže ×1,5 (+50 %), nie +40,5 %. Najčastejšia chyba. |
| 10 | B | T | U | K | F | Trénovacie RMSE klesá, validačné rastie = overfitting (L5 Ex2). Underfitting by mal vysoké RMSE na oboch sadách. |
| 11 | D | T | U | F | K | Banding zachytí nelineárny alebo nemonotónny vzor (L5 Ex1/Ex3). Capping rieši extrémne hodnoty, nie tvar závislosti. |
| 12 | A | K | T | U | F | Trend v Actual + plochý Fitted = kandidát na pridanie (homework hints L5). Zubatý Actual pri malom exposure je len šum. Prekrývanie je situácia pre premennú, ktorá už v modeli je. |

**Rozloženie správnych odpovedí:** A = 3 (2, 7, 12), B = 3 (3, 5, 10), C = 3 (1, 6, 9), D = 3 (4, 8, 11). Žiadne dve po sebe idúce otázky nemajú rovnaké správne písmeno.
