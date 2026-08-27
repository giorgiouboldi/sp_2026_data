# Income & inequality

## `larochelle_iris_income.csv` — 48 of 115 IRIS, join on `IRIS`

Source: INSEE "Revenus, pauvreté et niveau de vie en 2021 (IRIS)", disposable-income base.

- `median_income_eur`, `income_q1_eur`, `income_q3_eur`, `income_d1_eur`, `income_d9_eur` — standard of living per consumption unit, in euros.
- `poverty_rate_pct` — share of the population below 60% of the national median standard of living.
- `d9_d1_ratio`, `gini_index` — inequality measures.
- `income_share_activity_pct`, `income_share_pensions_pct`, `income_share_social_benefits_pct`, `income_share_taxes_pct` — where income comes from (work, pensions, benefits) and what's deducted in taxes.

**Only 48 of the 115 IRIS have values.** This isn't a filtering error — INSEE itself doesn't publish income figures for IRIS with too few households, to protect confidentiality. The other 67 rows just don't exist in the source file at all.

## Still missing: commune-level income

The direct file link is:
**https://www.insee.fr/fr/statistiques/fichier/7756855/indic-struct-distrib-revenu-2021-COMMUNES_csv.zip** (16 MB, from [this page](https://www.insee.fr/fr/statistiques/7756855?sommaire=7756859))

If the download still isn't working: try right-click → "save link as" instead of a normal click (INSEE's site sometimes intercepts the click with a JS download handler that can fail silently), or a different browser/network. Let me know what error you're actually seeing and I can dig further.

Source page, for reference: [IRIS income](https://www.insee.fr/fr/statistiques/8229323)
