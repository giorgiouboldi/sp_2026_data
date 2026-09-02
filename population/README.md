# Population & socio-economic data

Files here match the three geometry levels in [`../geo-data/`](../geo-data/), joined the same way as the mobility data (`COMMUNE`, `IRIS`, `idINS`). Point-based equipment/amenity data lives separately in [`../amenities/`](../amenities/), and income data lives in [`../income/`](../income/), since neither joins the same way as these do.

**One thing to flag:** these files mix census vintages — that's how the source data exists, not something to reconcile. Communes population = INSEE's current legal population count. IRIS/c200 population = 2021 census. Don't treat different years as directly comparable without accounting for the gap.

## `larochelle_communes_population.csv` — 72 rows, join on `COMMUNE`

Source: the commune boundary file from Géoplateforme17 (see the root [README's Sources section](../README.md#sources)), which already carried real INSEE figures.

- `population_1990` … `population_2020` — INSEE legal population counts from past censuses.
- `population_2026` — current official legal population figure (not a projection — INSEE names each census "vintage" by the year it takes legal effect).
- `surface_km2`, `density_2026_per_km2`.
- `code_postal`, `epci`, `canton`, `arrondissement`.

Not included: `distance_littoral` / `temps_acces_littoral` (distance/time to the coast), present in the source file but with units that aren't documented anywhere in it.

## `larochelle_iris_population.csv` — 115 rows, join on `IRIS`

Source: INSEE "Population en 2021" (base infra-communale IRIS), filtered from ~49,000 IRIS nationwide.

- `population_2021`, age bands (`pop_0_14` … `pop_75p`), socio-professional category counts (`pop_cs1_agriculteurs` … `pop_cs8_autres_sans_activite`), nationality/immigration (`pop_nationalite_francaise`, `pop_etrangers`, `pop_immigres`), `pop_menages`.

## `larochelle_c200_population.csv` — 5,723 of 32,700 grid cells, join on `idINS`

Source: INSEE "Filosofi 2021" 200m gridded data. Only cells with population appear in the source, which is why this has fewer rows than the full grid.

- `individuals`, household counts by type (`households_1person`, `households_5plus_person`, `households_owner`, `households_single_parent`, `households_collective_housing`, `households_house`), `households_poor`, `households_social_housing`.
- `sum_dwelling_surface_m2`.
- `sum_niveau_de_vie_eur` (a sum, not an average) and `avg_niveau_de_vie_eur` (= sum ÷ `individuals`, calculated for this dataset).
- `pop_0_3` … `pop_80p` — population by age band.

**Caveats from INSEE's documentation:** cells with fewer than 11 households are statistically imputed for confidentiality (~79% of inhabited cells nationwide); individual living standards are capped at the département's 5th/95th percentile before summing; values are rounded to one decimal at source; ages 18–24 can look mis-located because students are counted at their parents' address.

## `larochelle_c200_population_2017.csv` — 5,674 grid cells, join on `Idcar_200m` (= `idINS`)

Same kind of data as the 2021 grid file above, but the 2017 Filosofi edition, kept as the raw source columns (French names, untranslated) rather than the curated set above — useful if you want to compare 2017 vs 2021 at grid level, or need a column the 2021 file doesn't carry (building age, for one).

- `Idcar_200m` — the grid cell ID, same format as `idINS` elsewhere.
- `Ind` — individuals; `Men` — households; `Men_1ind`/`Men_5ind` — 1-person/5+-person households; `Men_prop` — owner-occupied; `Men_fmp` — single-parent; `Men_pauv` — poor households; `Men_coll`/`Men_mais` — collective housing/houses.
- `Ind_snv` — sum of standard of living (income); `Men_surf` — sum of dwelling surface.
- `Log_av45`/`Log_45_70`/`Log_70_90`/`Log_ap90` — dwellings by construction period (before 1945, 1945–70, 1970–90, after 1990); `Log_inc` — dwellings with unknown construction date; `Log_soc` — social housing.
- `Ind_0_3` … `Ind_80p` — population by age band; `Ind_inc` — individuals with unknown age.
- `I_est_200`/`I_est_1km` — imputation flags (1 = this cell's/its parent 1km cell's values are imputed, not directly observed).
- `Idcar_1km`/`Idcar_nat` — the parent 1km and "natural level" grid cell this one belongs to.
- `Groupe` — cells with fewer than 11 households get merged into a group and share one set of values, for confidentiality; this is that group's ID.
- `lcog_geo` — commune code(s) the cell overlaps (concatenated if it straddles more than one).

Source: [Filosofi 2017, données carroyées 200m](https://www.insee.fr/fr/statistiques/6215138?sommaire=6215217), filtered from the full metropolitan France file to this study area's grid cells. [Full documentation (PDF)](https://www.insee.fr/fr/statistiques/fichier/6215647/documentation_DonneesCarroyees_filosofi2017.pdf) if you need more than what's above.

Income data (median income, poverty rate, inequality) is in [`../income/README.md`](../income/README.md).

Source pages, for reference: [IRIS population](https://www.insee.fr/fr/statistiques/8268806) · [Filosofi 2021 200m grid](https://www.insee.fr/fr/statistiques/8735162?sommaire=8735243) · [Filosofi 2021 documentation (PDF)](https://www.insee.fr/fr/statistiques/fichier/8735106/documentation_donnees-carroyees_filosofi2021.pdf)
