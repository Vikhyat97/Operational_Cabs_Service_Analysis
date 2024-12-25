-- Business Request 3

WITH table_1 AS
(SELECT
t2.city_name, 
t1.trip_count, 
SUM(t1.repeat_passenger_count) AS repeat_passenger_count
FROM dim_repeat_trip_distribution t1
LEFT JOIN dim_city t2
ON t1.city_id = t2.city_id
GROUP BY 1,2)

SELECT 
city_name,
ROUND(SUM(CASE WHEN trip_count = "2-Trips" THEN repeat_passenger_count ELSE 0 END)/SUM(repeat_passenger_count)*100, 2) AS '2-Trips',
ROUND(SUM(CASE WHEN trip_count = "3-Trips" THEN repeat_passenger_count ELSE 0 END)/SUM(repeat_passenger_count)*100, 2) AS '3-Trips',
ROUND(SUM(CASE WHEN trip_count = "4-Trips" THEN repeat_passenger_count ELSE 0 END)/SUM(repeat_passenger_count)*100, 2) AS '4-Trips',
ROUND(SUM(CASE WHEN trip_count = "5-Trips" THEN repeat_passenger_count ELSE 0 END)/SUM(repeat_passenger_count)*100, 2) AS '5-Trips',
ROUND(SUM(CASE WHEN trip_count = "6-Trips" THEN repeat_passenger_count ELSE 0 END)/SUM(repeat_passenger_count)*100,2) AS '6-Trips',
ROUND(SUM(CASE WHEN trip_count = "7-Trips" THEN repeat_passenger_count ELSE 0 END)/SUM(repeat_passenger_count)*100,2) AS '7-Trips',
ROUND(SUM(CASE WHEN trip_count = "8-Trips" THEN repeat_passenger_count ELSE 0 END)/SUM(repeat_passenger_count)*100,2) AS '8-Trips',
ROUND(SUM(CASE WHEN trip_count = "9-Trips" THEN repeat_passenger_count ELSE 0 END)/SUM(repeat_passenger_count)*100,2) AS '9-Trips',
ROUND(SUM(CASE WHEN trip_count = "10-Trips" THEN repeat_passenger_count ELSE 0 END)/SUM(repeat_passenger_count)*100,2) AS '10-Trips'
FROM table_1
GROUP BY 1;