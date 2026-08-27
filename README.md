# Guide to the La Rochelle commuting data

## Three levels of detail & geo layers

The data covers the La Rochelle commuting area at three sizes of area — same geography, different zoom level:

- **c200** — 200m×200m INSPIRE grid squares, identified by `idINS`. Most detail.
- **IRIS** — INSEE's neighborhood-level statistical zones, identified by `IRIS` (code_iris). Medium detail.
- **communes** — municipalities, identified by `COMMUNE` (INSEE code géographique). Least detail.

Grid squares roll up into IRIS zones, which roll up into communes.

Each level's map shape lives in `geo-data/` — geometry and join key only, no data values:

- `geo-data/larochelle_c200_boundary.geojson` (also has `has_data`, since it covers every grid square, not just the ones with data)
- `geo-data/larochelle_iris_boundary.geojson`
- `geo-data/larochelle_communes_boundary.geojson`

Every data file below (in `mobility/` and `population/`) is a plain CSV that joins onto the matching boundary file on that shared key. In QGIS: Layer → Properties → Joins (add the CSV, match the field on each side). `communes_names.csv` (at the root) maps each `COMMUNE` code to its town name if you want readable labels instead of numbers.

`amenities/` is the exception — its points already carry their own coordinates, so there's nothing to join. See the Amenities section below for how to aggregate it to a level instead.

## Mobility (`mobility/`)

Home-to-work travel times and distances. All three levels use the exact same columns (same wording as `mobility/codebook.txt`), weighted by population times jobs for each travel between a pair of individual and job:

- **distance** — weighted average road distance from home to work place, in meters
- **tt_car / tt_bike / tt_walk / tt_transit** — average weighted travel time in minutes between home and work place, by car, bike, walk, and transit
- **part_transit** — the share (0.5 means 50%) of the population who has access to the transit system; `tt_transit` is calculated for this population only
- **walktime** — average weighted travel time in minutes between home and the entry station in the transit system (bus, metro, train, ...)

Files: `larochelle_c200_mobility.csv` (5,455 rows) · `larochelle_iris_mobility.csv` (116 rows) · `larochelle_communes_mobility.csv` (73 rows).

## Population (`population/`)

Population figures at each level come from a different INSEE source, so the columns aren't identical level to level — each is listed separately.

**`larochelle_communes_population.csv`** (72 rows) — current legal population + a past-census time series:
- `population_1990` … `population_2020` — past census counts; `population_2026` — the current official legal population (not a projection — INSEE names each "vintage" by the year it takes legal effect)
- `surface_km2`, `density_2026_per_km2`
- `code_postal`, `epci`, `canton`, `arrondissement` — administrative context

**`larochelle_iris_population.csv`** (115 rows) — 2021 census, INSEE's standard age/occupation/nationality breakdown:
- `population_2021`, and by age band: `pop_0_14`, `pop_15_29`, `pop_30_44`, `pop_45_59`, `pop_60_74`, `pop_75p`
- `pop_cs1_agriculteurs` … `pop_cs8_autres_sans_activite` — population 15+ by socio-professional category (INSEE's standard PCS categories)
- `pop_nationalite_francaise`, `pop_etrangers`, `pop_immigres`, `pop_menages`

**`larochelle_c200_population.csv`** (5,723 of 32,700 cells) — 2021 Filosofi grid, different age bands and a housing/income focus instead of occupation:
- `individuals`, and by age band: `pop_0_3`, `pop_4_5`, `pop_6_10`, `pop_11_17`, `pop_18_24`, `pop_25_39`, `pop_40_54`, `pop_55_64`, `pop_65_79`, `pop_80p`
- `households`, `households_1person`, `households_5plus_person`, `households_owner`, `households_single_parent`, `households_collective_housing`, `households_house`, `households_poor`, `households_social_housing`
- `sum_dwelling_surface_m2`; `avg_niveau_de_vie_eur` (standard of living per person, a rough income indicator)

Full sourcing and data-quality caveats (small-cell imputation, rounding, etc.) are in `population/README.md`.

## Income (`income/`)

**`larochelle_iris_income.csv`** — only 48 of the 115 IRIS have values; INSEE itself withholds income figures for areas with too few households, so the rest simply aren't published, not missing due to a filtering error.

- `median_income_eur`, `income_q1_eur`, `income_q3_eur`, `income_d1_eur`, `income_d9_eur` — standard of living per consumption unit
- `poverty_rate_pct` — share below 60% of the national median
- `d9_d1_ratio`, `gini_index` — inequality measures
- `income_share_activity_pct`, `income_share_pensions_pct`, `income_share_social_benefits_pct`, `income_share_taxes_pct` — where income comes from and what's deducted in taxes

## Amenities (`amenities/`)

**`larochelle_equipements.geojson`** / **`.csv`** (11,019 points) — every school, shop, healthcare facility, sports facility, transit stop, etc. in the area, geolocated:

- `name`, `address`, `postal_code`
- `COMMUNE`, `nom_commune` — same commune code as everything else, so this can be aggregated to commune/IRIS level (see below)
- `domain` — one of 7 broad categories (Services aux particuliers, Commerces, Enseignement, Santé, Transports et déplacements, Sports/loisirs et culture, Tourisme); `subdomain_code`, `type_code` — INSEE's finer classification, left as raw codes
- `longitude`, `latitude` (CSV only — the GeoJSON has these as the point geometry instead)

Because these points have no `idINS`/`IRIS`/`COMMUNE` join key, getting counts per commune or IRIS means aggregating by location instead of joining by key:

- **QGIS:** Processing Toolbox → **"Count points in polygon"** (Vector analysis). Polygons = a `geo-data/` boundary file, Points = the amenities layer, Class field = `domain` for a count per category instead of one grand total. For sums/averages of a numeric field instead of counts, use **"Join attributes by location (summary)"**.
- **Foursquare Studio:** open the amenities dataset → "⋮ More options" → **Spatial Join**. Target = a `geo-data/` boundary layer, Join dataset = the amenities points, choose an aggregation (Count, Sum, Mean, Median, ...).

## Sources

Everything here traces back to a specific source — nothing is estimated or invented. Exact file names and data-quality caveats (small-cell imputation, income suppressed for small IRIS, etc.) are documented in each folder's own `README.md`; this is the list of providers.

- **Mobility** (`mobility/`) — provided directly for this project. The underlying home/work pairing traces to INSEE's census commuting survey: [Mobilités professionnelles : déplacements domicile-lieu de travail](https://www.insee.fr/fr/statistiques/8201899). The travel-time computation itself isn't a published dataset — it was pre-computed by whoever built the original project files, and isn't traceable further from what's here.
- **Commune boundaries & population** (`geo-data/larochelle_communes_boundary.geojson`, `population/larochelle_communes_population.csv`) — [Géoplateforme17](https://www.geoplateforme17.fr), the Charente-Maritime departmental GIS platform (run by Soluris on behalf of the Conseil Départemental), accessed via QGIS rather than a direct file download.
- **IRIS boundaries** (`geo-data/larochelle_iris_boundary.geojson`) — IGN, via [Géoportail's Contours IRIS page](https://www.geoportail.gouv.fr/donnees/contours-iris) (the WFS service actually used in QGIS is `data.geopf.fr/wfs/ows`, layer `STATISTICALUNITS.IRISGE:iris_ge` — that's an API endpoint, not a browsable page, so it 404s if opened directly in a browser).
- **IRIS & 200m-grid population** (`population/larochelle_iris_population.csv`, `population/larochelle_c200_population.csv`) — INSEE: [Population en 2021 (IRIS)](https://www.insee.fr/fr/statistiques/8268806) and [Filosofi 2021, données carroyées 200m](https://www.insee.fr/fr/statistiques/8735162?sommaire=8735243).
- **IRIS income** (`income/larochelle_iris_income.csv`) — INSEE: [Revenus, pauvreté et niveau de vie en 2021 (IRIS)](https://www.insee.fr/fr/statistiques/8229323).
- **Amenities** (`amenities/`) — INSEE: [Base Permanente des Équipements (BPE) 2025](https://www.insee.fr/fr/statistiques/8217525?sommaire=8217537).

## Other open data resources

Beyond what's in this folder, these are good starting points for finding more data for the La Rochelle area or France generally:

- **[data.gouv.fr](https://www.data.gouv.fr)** — France's national open data catalog, aggregates datasets from government bodies, agencies, and local authorities.
- **[insee.fr](https://www.insee.fr)** — French statistics institute: population, employment, housing, income, business demography, at every geographic level from IRIS to national.
- **[Géoportail](https://www.geoportail.gouv.fr)** — France's official geospatial reference data: administrative boundaries, elevation, aerial imagery, cadastre, land use. (Its underlying API, IGN's Géoplateforme at `data.geopf.fr`, is what QGIS/GIS software connects to directly — that domain has no browsable homepage, so use Géoportail if you just want to look at or download data.)
- **[transport.data.gouv.fr](https://transport.data.gouv.fr)** — France's national transit open data portal: real GTFS schedules and stops for bus/train/tram networks, including Nouvelle-Aquitaine's — directly relevant if you want to compare the modeled transit times here against a real network.
- **[Géoplateforme17](https://www.geoplateforme17.fr)** — the Charente-Maritime departmental portal already used for commune boundaries; has other local layers too (cadastre, housing, environment).
- **[PIGMA](https://portail.pigma.org)** — Nouvelle-Aquitaine's regional geographic data platform, one level up from the department.
- **[Eurostat](https://ec.europa.eu/eurostat)** — EU-wide statistics, useful if you want to compare La Rochelle to other European regions.

## Adding new data

Any new dataset that has an `idINS`, `IRIS`, or `COMMUNE` column can be joined onto the matching geometry file the same way — geometry and data stay separate on purpose. A dataset with its own coordinates instead (like amenities) gets aggregated by location rather than joined by key.
