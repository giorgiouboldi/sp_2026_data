library(tidyverse)
library(sf)
library(qs)
library(arrow)
library(MetricsWeighted)

load("baselayer.rda")
distances <- arrow::open_dataset(distances_file) |> 
  arrow::to_duckdb()

idINS <- arrow::open_dataset(idINS_emp_file) |> 
  arrow::to_duckdb()

data <- distances |> 
  left_join(idINS |> 
              select(id, fromidINS, toidINS, COMMUNE, DCLT), join_by(id))  |> 
  select(fromidINS, toidINS, 
         distance = distance_car,
         tt_bike = travel_time_bike,
         tt_walk = travel_time_walk,
         tt_car = travel_time_car,
         tt_transit = travel_time_transit,
         walktime = walktime,
         COMMUNE, DCLT) 

c200 <-  qs::qread(c200ze_file) |> 
  st_drop_geometry() |> 
  transmute(idINS, CODE_IRIS, ind, ind_18_64, emp, ndv = ind_snv/ind) |> 
  to_duckdb()

carreaux <- data |> 
  left_join(c200 |> select(idINS, ind_18_64), join_by(fromidINS == idINS)) |> 
  left_join(c200 |> select(idINS, emp), join_by(toidINS == idINS)) |> 
  mutate(
    walktime = if_else(walktime == 9999, NA, walktime),
    tt_transit = if_else(tt_transit == 9999, NA, tt_transit)
  ) |> 
  mutate(
    w = emp*ind_18_64,
    ok_dist = as.numeric(distance >= 0),
    ok_car = as.numeric(tt_car >= 0),
    ok_transit = as.numeric(tt_transit >= 0),
    ok_walktime = as.numeric(walktime >= 0),
    ok_bike = as.numeric(tt_bike >= 0),
    ok_walk = as.numeric(tt_walk >= 0)) |> 
  summarise(
    distance = sum(distance * w) / sum(w * ok_dist),
    tt_bike = sum(tt_bike * w) / sum(w * ok_bike),
    tt_car = sum(tt_car * w) / sum(w),
    tt_walk = sum(tt_walk * w) / sum(w * ok_walk),
    tt_transit = sum(tt_transit * w) / sum(w * ok_transit),
    part_transit = sum(ok_transit * w)/sum(ok_car * w),
    walktime = sum(walktime * w) / sum(w * ok_walktime),
    .by = c("fromidINS")) |> 
  collect() |> 
  rename(idINS = "fromidINS") |> 
  mutate(idINS = str_c("CRS3035", str_replace(idINS, "r200", "RES200m")))

communes <- data |> 
  left_join(c200 |> select(idINS, ind_18_64), join_by(fromidINS == idINS)) |> 
  left_join(c200 |> select(idINS, emp), join_by(toidINS == idINS)) |> 
  mutate(
    walktime = if_else(walktime == 9999, NA, walktime),
    tt_transit = if_else(tt_transit == 9999, NA, tt_transit)
  ) |> 
  mutate(
    w = emp*ind_18_64,
    ok_dist = as.numeric(distance >= 0),
    ok_car = as.numeric(tt_car >= 0),
    ok_transit = as.numeric(tt_transit >= 0),
    ok_walktime = as.numeric(walktime >= 0),
    ok_bike = as.numeric(tt_bike >= 0),
    ok_walk = as.numeric(tt_walk >= 0)) |> 
  summarise(
    distance = sum(distance * w) / sum(w * ok_dist),
    tt_bike = sum(tt_bike * w) / sum(w * ok_bike),
    tt_car = sum(tt_car * w) / sum(w),
    tt_walk = sum(tt_walk * w) / sum(w * ok_walk),
    tt_transit = sum(tt_transit * w) / sum(w * ok_transit),
    part_transit = sum(ok_transit * w)/sum(ok_car * w),
    walktime = sum(walktime * w) / sum(w * ok_walktime),
    .by = c("COMMUNE")) |> 
  collect()

iris <- data |> 
  left_join(c200 |> select(idINS, ind_18_64, fromIRIS = CODE_IRIS), join_by(fromidINS == idINS)) |> 
  left_join(c200 |> select(idINS, emp, toIRIS = CODE_IRIS), join_by(toidINS == idINS)) |> 
  mutate(
    walktime = if_else(walktime == 9999, NA, walktime),
    tt_transit = if_else(tt_transit == 9999, NA, tt_transit)
  ) |> 
  mutate(
    w = emp*ind_18_64,
    ok_dist = as.numeric(distance >= 0),
    ok_car = as.numeric(tt_car >= 0),
    ok_transit = as.numeric(tt_transit >= 0),
    ok_walktime = as.numeric(walktime >= 0),
    ok_bike = as.numeric(tt_bike >= 0),
    ok_walk = as.numeric(tt_walk >= 0)) |> 
  summarise(
    distance = sum(distance * w) / sum(w * ok_dist),
    tt_bike = sum(tt_bike * w) / sum(w * ok_bike),
    tt_car = sum(tt_car * w) / sum(w),
    tt_walk = sum(tt_walk * w) / sum(w * ok_walk),
    tt_transit = sum(tt_transit * w) / sum(w * ok_transit),
    part_transit = sum(ok_transit * w)/sum(ok_car * w),
    walktime = sum(walktime * w) / sum(w * ok_walktime),
    .by = c("fromIRIS")) |> 
  collect() |> 
  rename(IRIS = fromIRIS)

write_csv(iris, "data4giorgio/larochelle.iris.csv")
write_csv(communes, "data4giorgio/larochelle.commmunes.csv")
write_csv(carreaux, "data4giorgio/larochelle.c200.csv")
