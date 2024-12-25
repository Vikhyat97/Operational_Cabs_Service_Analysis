-- Business Request 5

WITH table_1 AS
(SELECT 
t2.city_name,
MONTHNAME(date) AS month_name,
SUM(fare_amount) AS revenue,
ROW_NUMBER() OVER(PARTITION BY t2.city_name ORDER BY SUM(fare_amount) DESC) AS row_num 
FROM fact_trips t1
LEFT JOIN dim_city t2
ON t1.city_id = t2.city_id
GROUP BY 1,2)

SELECT 
city_name,
month_name AS highest_revenue_month,
revenue,
ROUND(revenue/total*100,2) AS percentage_contribution
FROM(
	SELECT
	*,
	SUM(revenue) OVER(PARTITION BY city_name) AS total
	FROM table_1) AS table_2
WHERE row_num = 1;