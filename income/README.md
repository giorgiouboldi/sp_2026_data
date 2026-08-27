# Income & inequality

## `larochelle_iris_income.csv` — 48 of 115 IRIS, join on `IRIS`

Source: INSEE "Revenus, pauvreté et niveau de vie en 2021 (IRIS)", disposable-income base.

- `median_income_eur`, `income_q1_eur`, `income_q3_eur`, `income_d1_eur`, `income_d9_eur` — standard of living per consumption unit, in euros.
- `poverty_rate_pct` — share of the population below 60% of the national median standard of living.
- `d9_d1_ratio`, `gini_index` — inequality measures.
- `income_share_activity_pct`, `income_share_pensions_pct`, `income_share_social_benefits_pct`, `income_share_taxes_pct` — where income comes from (work, pensions, benefits) and what's deducted in taxes.

**Only 48 of the 115 IRIS have values.** This isn't a filtering error — INSEE itself doesn't publish income figures for IRIS with too few households, to protect confidentiality. The other 67 rows just don't exist in the source file at all.

## `larochelle_communes_income.csv` — 72 rows, join on `COMMUNE`

Source: INSEE "Revenus, pauvreté et niveau de vie en 2021 (communes)", disposable-income base — same underlying FILOSOFI product as the IRIS file above, same columns, at commune level instead.

**Suppression here is column-by-column, not row-by-row** — a real difference from the IRIS file. Every one of the 72 communes has a `median_income_eur` value; INSEE just doesn't publish the finer statistics for communes with too few tax households:

- `median_income_eur` — present for all 72 communes.
- `income_q1_eur`, `income_q3_eur`, `income_d1_eur`, `income_d9_eur`, `d9_d1_ratio`, `gini_index`, `income_share_activity_pct`, `income_share_pensions_pct`, `income_share_social_benefits_pct`, `income_share_taxes_pct` — present for 29 of 72 communes (the ones with enough households to clear INSEE's confidentiality threshold for the full breakdown).
- `poverty_rate_pct` — present for only 16 of 72 communes; this one has the highest disclosure threshold of the set.

A blank cell always means "not published for this commune," never a processing error — same rule as the IRIS file.

Source page: [Revenus, pauvreté et niveau de vie en 2021 (communes)](https://www.insee.fr/fr/statistiques/7756855?sommaire=7756859)
