# Public transportation

Real bus, boat, and train routes and stops for the area, from open GTFS feeds. Everything here is `.geojson` — points for stops, lines for routes.

## Yélo (`larochelle_yelo_bus_*`)

The La Rochelle agglomeration's own bus network — regular lines, night buses, Sunday lines, school shuttles, and the two harbor boat shuttles. 122 routes, 536 stops.

## Interurban buses (`larochelle_interurban_bus_*`)

The Charente-Maritime regional coach network — covers the rural communes Yélo doesn't reach. 12 routes, 59 stops.

## Trains (`larochelle_train_*`)

SNCF lines through La Rochelle (TGV, Intercités, TER), filtered out of the national feed. 8 routes, 9 stations. Note: SNCF doesn't publish real track geometry, so the train route lines are just straight segments between stations, not the actual rail path.

## Sources

- [Réseau urbain Yélo](https://transport.data.gouv.fr/datasets/arrets-horaires-et-parcours-theoriques-des-reseaux-naq-lro-nva-m-1)
- [Réseau interurbain Charente-Maritime](https://transport.data.gouv.fr/datasets/arrets-horaires-et-parcours-theoriques-des-reseaux-naq-cma-nva-m/?locale=fr)
- [Réseau SNCF TGV, Intercités et TER](https://transport.data.gouv.fr/datasets/horaires-sncf)

All from [transport.data.gouv.fr](https://transport.data.gouv.fr), ODbL license.

Routes only show one path per line even though most have several variants in the source (different directions, times, school days) — picked the longest one to keep it readable.

Doesn't cover the 2 Vendée communes.
