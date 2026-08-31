# Energy consumption & housing quality

Annual electricity and gas consumption, plus a housing-quality snapshot (share of homes heated electrically, and counts of poorly-insulated "energy sieve" homes), from Agence ORE (Observatoire des Réseaux Électriques et gaziers, France's grid-operator data hub) and data.gouv.fr.

**Important caveat, flagged by the data provider: this covers electricity and gas only. Oil (fioul) and wood/biomass heating are not captured anywhere in this file.** A commune or IRIS with a lot of oil- or wood-heated housing will show comparatively low or misleading consumption here — this is a real limitation of the source data, not a processing gap.

## `larochelle_communes_energy.csv` — 72 communes, join on `COMMUNE`

## `larochelle_iris_energy.csv` — 113 of 115 IRIS, join on `IRIS`

Unlike every other file in this repository, these are **not one row per zone** — each zone has multiple rows, one per `year` × `energy_type` combination:

- `year` — 2011 through 2024.
- `energy_type` — `electricity` or `gas`.
- `sites` — number of metered delivery points for that energy type, year, and zone.
- `consumption_mwh` — total annual consumption, in MWh.
- `consumption_avg_mwh_per_site` — average consumption per site, in MWh.

`electricity` rows exist for every zone across all 14 years. `gas` rows exist only where a gas network actually reaches the zone — most zones have none at all, and even where gas is present the year range is sometimes shorter than 2011–2024. This reflects real gas-network coverage, not missing data.

The remaining columns are a 2024 snapshot, repeated identically on every row for a given zone (so they carry the same value whether the row is an `electricity` row or a `gas` row for that zone/year — join on `COMMUNE`/`IRIS` alone if you just want the snapshot once):

- `population_2024` — population used as the denominator for the snapshot figures.
- `electric_heating_share_pct` — share of housing whose main heating source is electric, as of 2024.
- `residences_principales_2024` — number of primary residences.
- `dpe_de_count_2024`, `dpe_fg_count_2024` — number of homes rated D/E and F/G respectively on France's DPE (Diagnostic de Performance Énergétique) energy-performance scale; F/G are the "passoires énergétiques" (energy sieves), the worst-insulated homes.

**The 2 Vendée IRIS (`851110000`, `851320000`) have no rows in the IRIS file** — no consumption records exist for them in the source, the same gap as in the real-estate data.

Sources:

- Consumption (`sites`, `consumption_mwh`, `consumption_avg_mwh_per_site`, `electric_heating_share_pct`): [Agence ORE](https://opendata.agenceore.fr) — "Consommation annuelle d'électricité et de gaz par IRIS", the French grid and gas-network operators' joint open-data hub.
- Housing quality (`population_2024`, `residences_principales_2024`, `dpe_de_count_2024`, `dpe_fg_count_2024`): [Nombre de passoires énergétiques par IRIS](https://www.data.gouv.fr/fr/datasets/nombre-de-passoires-energetiques-par-iris-dpe-apres-juillet-2021/) on data.gouv.fr, based on DPE records issued after July 2021 (the revised, more reliable DPE methodology).
