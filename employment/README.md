# Employment by workplace location

Where jobs physically sit, not where the workers live.

**`larochelle_communes_jobs.csv`** — one snapshot (2021):

- `jobs_total` — total jobs at the workplace in the commune
- `jobs_salaried`, `jobs_salaried_female`, `jobs_salaried_parttime` — salaried jobs and the female/part-time subsets
- `jobs_nonsalaried`, `jobs_nonsalaried_female`, `jobs_nonsalaried_parttime` — self-employed jobs and the female/part-time subsets
- `jobs_cs1_agriculteurs` … `jobs_cs6_ouvriers` — jobs by socio-professional category (same PCS categories as `population/`'s `pop_cs1`…`pop_cs6`)
- `jobs_agriculture`, `jobs_industry`, `jobs_construction`, `jobs_commerce_transport_services`, `jobs_public_admin_education_health` — jobs by broad sector

**`larochelle_communes_jobs_timeseries.csv`** — just total jobs, but for every year INSEE has published: 1999, 2007–2022. Plus `change_pct_1999_2022` and `change_pct_2012_2022`, % change over those two periods. Pieced together from 8 different INSEE files since they don't publish one continuous series — some communes might show a jump if their boundaries changed at some point (like Cram-Chaban, see `amenities/README.md`).

Source: INSEE, "Emploi-population active" — [2021 edition](https://www.insee.fr/fr/statistiques/8202916?sommaire=8205947) for the first file, [2007](https://www.insee.fr/fr/statistiques/2044652)/[2013](https://www.insee.fr/fr/statistiques/2518836)/[2017](https://www.insee.fr/fr/statistiques/4515500?sommaire=4516095)/[2018](https://www.insee.fr/fr/statistiques/5395838?sommaire=5395900)/[2019](https://www.insee.fr/fr/statistiques/6454652?sommaire=6454687)/[2020](https://www.insee.fr/fr/statistiques/7632867?sommaire=7632977)/[2022](https://www.insee.fr/fr/statistiques/8581444?sommaire=8581612) editions for the rest.
