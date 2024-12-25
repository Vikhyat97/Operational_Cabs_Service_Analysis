-- Business Request 2

WITH table_1 AS
(SELECT
dc.city_name,
MONTHNAME(ft.date) AS month_name,
COUNT(ft.trip_id) AS total_trips
FROM fact_trips ft
LEFT JOIN dim_city dc
ON ft.city_id = dc.city_id
GROUP BY 1,2
ORDER BY 1,2),

table_2 AS
(SELECT
dc.city_name,
MONTHNAME(mtt.month) AS month_name,
mtt.total_target_trips
FROM targets_db.monthly_target_trips mtt
LEFT JOIN dim_city dc
ON dc.city_id = mtt.city_id)

SELECT
t1.city_name,
t1.month_name,
t1.total_trips,
t2.total_target_trips,
(t1.total_trips - t2.total_target_trips)/t2.total_target_trips *100 AS percent_difference,
CASE WHEN t1.total_trips > t2.total_target_trips THEN "Above Target" ELSE "Below Target" END AS performance_status
FROM table_1 t1
LEFT JOIN table_2 t2
ON t1.city_name = t2.city_name
AND t1.month_name = t2.month_name;
