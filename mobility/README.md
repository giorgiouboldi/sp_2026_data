# Mobility

Home-to-work travel times and distances. Same columns at all three levels, weighted by population × jobs for each home-work pair:

- `distance` — weighted average road distance, in meters
- `tt_car` / `tt_bike` / `tt_walk` / `tt_transit` — weighted average travel time, in minutes
- `part_transit` — share of the population with any transit access at all; `tt_transit` is only averaged over that group
- `walktime` — average time from home to the nearest transit entry point

Files: `larochelle_c200_mobility.csv`, `larochelle_iris_mobility.csv`, `larochelle_communes_mobility.csv`. [`source/`](source/) has the original codebook and the script these were built from.

**Professional km driven** — a second, smaller set of files (`*_kmpro.csv`), one column each:

- `km_pa` — km driven by car per year, per working person, for commuting
- `f_i`, `ind_18_64` (c200 only) — working / working-age population in the cell

**Before mapping `tt_transit`:** check `part_transit` first — most communes are under 1%, so `tt_transit` there is basically meaningless. A cutoff around 0.1 splits the real numbers from the noise.
