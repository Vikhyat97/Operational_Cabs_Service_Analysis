-- Business Request 6

WITH table_1 AS
(SELECT
city_name,
MONTHNAME(month) AS month_name, 
total_passengers,
repeat_passengers,
ROUND(repeat_passengers/total_passengers*100, 2) AS monthly_repeat_passenger_rate
FROM fact_passenger_summary t1
LEFT JOIN dim_city t2
ON t1.city_id = t2.city_id),

table_2 AS
(SELECT 
city_name,
ROUND(SUM(repeat_passengers)/SUM(total_passengers)*100,2) AS city_repeat_passenger_rate
FROM table_1
GROUP BY 1)

SELECT 
t1.city_name,
t1.month_name,
t1.total_passengers,
t1.repeat_passengers,
t1.monthly_repeat_passenger_rate,
t2.city_repeat_passenger_rate
FROM table_1 t1
LEFT JOIN table_2 t2
ON t1.city_name = t2.city_name;
