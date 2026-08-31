# Employment by workplace location

## `larochelle_communes_jobs.csv` — 72 rows, join on `COMMUNE`

Source: INSEE "Emploi-Activité en 2021", base `base-cc-emploi-pop-active-2021`.

The dataset counts jobs where they're physically *located* — how many jobs sit inside each commune's boundaries, regardless of where the workers themselves reside. Useful for identifying commuting destinations (e.g. La Rochelle city center will show far more jobs than its resident working population, since people commute in).

- `jobs_total` — total number of jobs at the workplace in the commune.
- `jobs_salaried`, `jobs_salaried_female`, `jobs_salaried_parttime` — salaried jobs, and the female / part-time subsets.
- `jobs_nonsalaried`, `jobs_nonsalaried_female`, `jobs_nonsalaried_parttime` — self-employed jobs (independents, employers, family helpers combined), and the female / part-time subsets.
- `jobs_cs1_agriculteurs` … `jobs_cs6_ouvriers` — jobs by INSEE's standard socio-professional category (PCS), same 6 working categories used in [`../population/`](../population/)'s `pop_cs1`…`pop_cs6` columns (CS7 "retraités" and CS8 "autres sans activité" don't apply here — this file only counts people who hold a job).
- `jobs_agriculture`, `jobs_industry`, `jobs_construction`, `jobs_commerce_transport_services`, `jobs_public_admin_education_health` — jobs by broad sector (INSEE's 5-sector NAFG5 grouping).

Source page: [Emploi-Population active en 2021 (communes)](https://www.insee.fr/fr/statistiques/8202916?sommaire=8205947)
