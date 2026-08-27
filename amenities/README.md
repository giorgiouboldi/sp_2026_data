# Equipment & amenities

**`larochelle_equipements.geojson`** (and the same data as **`larochelle_equipements.csv`**) — 11,019 points: every school, shop, healthcare facility, sports facility, transit stop, and other public/private amenity INSEE tracks inside the 74 target communes.

This one's different from everything else in `data4giorgio`: each row already has its own coordinates, so it's a map layer on its own — you don't need to join it to `geo-data/` to put it on a map. Drop the `.geojson` straight into QGIS.

Source: INSEE's BPE (Base Permanente des Équipements) 2025, geolocated edition — the file you dropped in `original/BPE25.csv`. Filtered from ~2.9 million points nationwide.

## Columns

- `name`, `address`, `postal_code` — as recorded by INSEE (some are chain/franchise names, some are generic like "Ecole primaire").
- `COMMUNE`, `nom_commune` — same commune code as the rest of the dataset, so you *can* aggregate these into commune- or IRIS-level counts if you want (e.g. "how many pharmacies per commune").
- `domain_code` / `domain` — one of 7 broad categories: Services aux particuliers, Commerces, Enseignement, Santé, Transports et déplacements, Sports/loisirs et culture, Tourisme.
- `subdomain_code`, `type_code` — INSEE's finer classification (27 sub-domains, 217 precise equipment types in this filtered set). I left these as INSEE's raw codes (e.g. `A129`) rather than translating them, because the full type-level dictionary (hundreds of French labels) is a file I don't want to guess at from memory — if you want readable labels for these, grab `BPE25_anonymisee_varmod.csv` from [the same download page](https://www.insee.fr/fr/statistiques/8217525?sommaire=8217537) and I'll join it in.
- `geoloc_quality_code` — INSEE's raw geocoding-precision flag; higher precision generally means a smaller code, but I didn't want to assert exact meanings for each value without the source documentation.
- `longitude`, `latitude` — WGS84, ready to map (only in the CSV; the GeoJSON has these as the point geometry instead).

About 500 rows from the original file were dropped — they had no coordinates at all (mobile/itinerant services with no fixed location).
