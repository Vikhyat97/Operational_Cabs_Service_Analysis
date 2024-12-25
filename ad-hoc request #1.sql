-- Business Request 1

WITH trip_details as
(SELECT 
dc.city_name,
ft.trip_id, 
ft.distance_travelled_km,
ft.fare_amount
FROM fact_trips ft
LEFT JOIN dim_city dc
ON ft.city_id = dc.city_id)

SELECT 
city_name,
COUNT(trip_id) AS total_trips,
SUM(fare_amount)/SUM(distance_travelled_km) AS avg_fare_per_km,
SUM(fare_amount)/COUNT(trip_id) AS avg_fare_per_trip,
COUNT(trip_id)/(SELECT COUNT(trip_id) FROM trip_details)*100 AS percent_of_trips
FROM trip_details
GROUP BY 1;

select * from fact_trips;