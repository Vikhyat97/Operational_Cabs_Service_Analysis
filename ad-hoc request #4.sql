-- Business Request 4

WITH table_1 AS
(SELECT
t2.city_name,
SUM(t1.new_passengers) AS total_new_passengers
FROM fact_passenger_summary t1
LEFT JOIN dim_city t2
ON t1.city_id = t2.city_id
GROUP BY 1
ORDER BY 2 DESC),

table_2 AS
(SELECT 
*,
ROW_NUMBER() OVER(Order by total_new_passengers DESC) AS row_num
FROM table_1)

SELECT 
city_name,
total_new_passengers,
CASE WHEN row_num <= 3 THEN "Top 3" ELSE NULL END AS city_category
FROM table_2
WHERE row_num <= 3
UNION
SELECT 
city_name,
total_new_passengers,
CASE WHEN row_num >= 8 THEN "Bottom 3" ELSE NULL END AS city_category
FROM table_2
WHERE row_num >= 8;