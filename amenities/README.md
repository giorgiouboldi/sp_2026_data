# Equipment & amenities

**`larochelle_equipements.csv`** — 11,019 points: every school, shop, healthcare facility, sports facility, transit stop, and other public/private amenity INSEE tracks inside the 74 target communes.

This one's different from everything else in this repository: each row already has its own coordinates (`longitude`, `latitude`), so it's a map layer on its own — no join to [`../geo-data/`](../geo-data/) needed. In QGIS: Layer → Add Layer → Add Delimited Text Layer, point it at this CSV, and set X/Y field to `longitude`/`latitude`.

Source: INSEE's BPE (Base Permanente des Équipements) 2025, geolocated edition. Filtered from ~2.9 million points nationwide to the 74 target communes.

## Columns

- `name`, `address`, `postal_code` — as recorded by INSEE (some are chain/franchise names, some are generic like "Ecole primaire").
- `COMMUNE`, `nom_commune` — same commune code as the rest of the dataset, so this can be aggregated into commune- or IRIS-level counts (e.g. "how many pharmacies per commune") — see the root README's [Amenities section](../README.md#amenities-amenities) for how, in QGIS or Foursquare Studio.
- `domain_code` / `domain` — one of 7 broad categories: Services aux particuliers, Commerces, Enseignement, Santé, Transports et déplacements, Sports/loisirs et culture, Tourisme.
- `subdomain_code`, `type_code` — INSEE's finer classification (27 sub-domains, 217 precise equipment types in this filtered set). Left as INSEE's raw codes (e.g. `A129`) rather than translated, since the full type-level dictionary is a separate file. For readable labels, get `BPE25_anonymisee_varmod.csv` from [the same download page](https://www.insee.fr/fr/statistiques/8217525?sommaire=8217537) and join it on `type_code`.
- `geoloc_quality_code` — INSEE's raw geocoding-precision flag; not translated here since its exact meaning per value isn't in the base documentation.
- `longitude`, `latitude` — WGS84, ready to map.

About 500 rows from the original file were dropped — they had no coordinates at all (mobile/itinerant services with no fixed location).
