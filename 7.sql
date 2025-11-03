--- Top 3 Drivers in Each City by Total Revenue

WITH DriverCityRevenue AS (
    SELECT
        r.driver_id,
        r.pickup_city AS city,
        SUM(r.fare) AS total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY r.pickup_city
            ORDER BY SUM(r.fare) DESC
        ) AS city_rank
    FROM public.rides AS r
    WHERE r.status = 'completed' AND r.request_date BETWEEN '2021-06-01' AND '2024-12-31'
    GROUP BY driver_id, pickup_city
)
SELECT
    d.name AS driver_name,
    dcr.city,
    dcr.total_revenue
FROM DriverCityRevenue AS dcr
INNER JOIN public.drivers AS d ON dcr.driver_id = d.driver_id
WHERE dcr.city_rank <= 3
ORDER BY dcr.city, dcr.city_rank;