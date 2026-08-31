# Real estate prices

Residential property transaction prices, from DVF+ (Demandes de Valeurs Foncières enrichies), CEREMA's enriched version of France's public real-estate transaction register.

## `larochelle_communes_prices.csv` — 72 rows, join on `COMMUNE`

## `larochelle_iris_prices.csv` — 113 of 115 IRIS, join on `IRIS`

Both files share the same columns:

- `n_transactions_2011`, `n_transactions_2024` — number of residential sales recorded that year.
- `price_per_m2_2011_eur`, `price_per_m2_2024_eur` — average price per square meter of the transactions observed that year, in euros.
- `annual_growth_rate_pct` — average annual growth rate in price per m² between 2011 and 2024, as a percentage.

**The 2 Vendée IRIS (`851110000`, `851320000`) have no rows in the IRIS file.** This isn't a filtering error — the source has no recorded transactions there at all, so there's nothing to report at IRIS level for those two zones. (Their parent commune, `85303`, is itself outside this project's 72-commune scope and isn't in the communes file either.)

A blank cell in `price_per_m2_*_eur` or `annual_growth_rate_pct` means too few transactions that year to compute a reliable figure — this comes from the source, not from processing here.

Source: [DVF+ (CEREMA)](https://datafoncier.cerema.fr/donnees/donnee-dvf), the enriched version of the French government's Demandes de Valeurs Foncières (DVF) public property-transaction register. CEREMA is a French public agency (Centre d'études et d'expertise sur les risques, l'environnement, la mobilité et l'aménagement); DVF+ adds land-use and cadastral parcel classification on top of raw DVF to isolate genuine residential transactions.
