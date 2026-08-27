# Population & socio-economic data

Files here match the three geometry levels, joined the same way as the mobility data (`COMMUNE`, `IRIS`, `idINS`). Point-based equipment/amenity data lives separately in `amenities/`, and income data lives in `income/`, since neither joins the same way as these do.

**One thing to flag:** these files mix census vintages — that's how the source data exists, not something to reconcile. Communes population = INSEE's current legal population count. IRIS/c200 population = 2021 census. Don't treat different years as directly comparable without accounting for the gap.

## `larochelle_communes_population.csv` — 72 rows, join on `COMMUNE`

Source: the commune boundary file you uploaded, which already carried real INSEE figures.

- `population_1990` … `population_2020` — INSEE legal population counts from past censuses.
- `population_2026` — current official legal population figure (not a projection — INSEE names each census "vintage" by the year it takes legal effect).
- `surface_km2`, `density_2026_per_km2`.
- `code_postal`, `epci`, `canton`, `arrondissement`.

## `larochelle_iris_population.csv` — 115 rows, join on `IRIS`

Source: INSEE "Population en 2021" (base infra-communale IRIS), filtered from ~49,000 IRIS nationwide.

- `population_2021`, age bands (`pop_0_14` … `pop_75p`), socio-professional category counts (`pop_cs1_agriculteurs` … `pop_cs8_autres_sans_activite`), nationality/immigration (`pop_nationalite_francaise`, `pop_etrangers`, `pop_immigres`), `pop_menages`.

## `larochelle_c200_population.csv` — 5,723 of 32,700 grid cells, join on `idINS`

Source: INSEE "Filosofi 2021" 200m gridded data. Only cells with population appear in the source, which is why this has fewer rows than the full grid.

- `individuals`, household counts by type (`households_1person`, `households_5plus_person`, `households_owner`, `households_single_parent`, `households_collective_housing`, `households_house`), `households_poor`, `households_social_housing`.
- `sum_dwelling_surface_m2`.
- `sum_niveau_de_vie_eur` (a sum, not an average) and `avg_niveau_de_vie_eur` (= sum ÷ `individuals`, calculated here).
- `pop_0_3` … `pop_80p` — population by age band.

**Caveats from INSEE's documentation:** cells with fewer than 11 households are statistically imputed for confidentiality (~79% of inhabited cells nationwide); individual living standards are capped at the département's 5th/95th percentile before summing; values are rounded to one decimal at source; ages 18–24 can look mis-located because students are counted at their parents' address.

Income data (median income, poverty rate, inequality) is now in `income/README.md`.

Source pages, for reference: [IRIS population](https://www.insee.fr/fr/statistiques/8268806) · [Filosofi 200m grid](https://www.insee.fr/fr/statistiques/8735162?sommaire=8735243) · [Filosofi 200m documentation (PDF)](https://www.insee.fr/fr/statistiques/fichier/8735106/documentation_donnees-carroyees_filosofi2021.pdf)
