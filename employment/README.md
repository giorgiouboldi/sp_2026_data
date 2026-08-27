# Employment by workplace location

## `larochelle_communes_jobs.csv` — 72 rows, join on `COMMUNE`

Source: INSEE "Emploi-Activité en 2021", base `base-cc-emploi-pop-active-2021`.

This is the flip side of the population files: instead of where people *live*, it counts jobs where they're physically *located* — how many jobs sit inside each commune's boundaries, regardless of where the workers themselves reside. Useful for identifying commuting destinations (e.g. La Rochelle city center will show far more jobs than its resident working population, since people commute in).

- `jobs_total` — total number of jobs at the workplace in the commune.
- `jobs_salaried`, `jobs_salaried_female`, `jobs_salaried_parttime` — salaried jobs, and the female / part-time subsets.
- `jobs_nonsalaried`, `jobs_nonsalaried_female`, `jobs_nonsalaried_parttime` — self-employed jobs (independents, employers, family helpers combined), and the female / part-time subsets.
- `jobs_cs1_agriculteurs` … `jobs_cs6_ouvriers` — jobs by INSEE's standard socio-professional category (PCS), same 6 working categories used in [`../population/`](../population/)'s `pop_cs1`…`pop_cs6` columns (CS7 "retraités" and CS8 "autres sans activité" don't apply here — this file only counts people who hold a job).
- `jobs_agriculture`, `jobs_industry`, `jobs_construction`, `jobs_commerce_transport_services`, `jobs_public_admin_education_health` — jobs by broad sector (INSEE's 5-sector NAFG5 grouping).

**Commune level only.** INSEE doesn't publish jobs-at-workplace at IRIS or 200m-grid resolution — job locations are only released at the commune level, so there's no `larochelle_iris_jobs.csv` or `larochelle_c200_jobs.csv` to go with this one.

**Not included:** the source file also breaks every sector down further by sex, salaried/non-salaried status, and combinations of the two (e.g. jobs in construction held by women) — left out here to keep the column count manageable. It also carries the same set of variables for 2015 and 2010 (`P15_EMPLT_*`, `P10_EMPLT_*`) if you want a time series; get `base-cc-emploi-pop-active-2021_csv.zip` from [the source page](https://www.insee.fr/fr/statistiques/8202916?sommaire=8205947) for either.

Values are weighted census estimates, rounded to one decimal, same convention as the other population/income files — a non-integer job count isn't an error.

Source page: [Emploi-Population active en 2021 (communes)](https://www.insee.fr/fr/statistiques/8202916?sommaire=8205947)
