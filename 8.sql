---Management wants to know the top 10 drivers that are qualified to receive bonuses using the criteria below;
----at least 30 rides completed,
----an average rating ≥ 4.5, and
----a cancellation rate under 5%.

WITH DriverPerformance AS (
    SELECT
        r.driver_id,
        COUNT(r.ride_id) AS total_rides,
        SUM(CASE WHEN r.status = 'completed' THEN 1 ELSE 0 END) AS completed_rides,
        SUM(CASE WHEN r.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_rides,
        AVG(d.rating) AS avg_rating -- Assuming DRIVERS.rating is updated based on feedback
    FROM public.rides AS r
    INNER JOIN public.drivers AS d ON r.driver_id = d.driver_id
    WHERE r.request_date BETWEEN '2021-06-01' AND '2024-12-31'
    GROUP BY 1
)
SELECT
    d.name AS driver_name,
    dp.completed_rides,
    dp.avg_rating,
    (dp.cancelled_rides * 100.0) / NULLIF(dp.total_rides, 0) AS cancellation_rate_percent
FROM DriverPerformance AS dp
INNER JOIN public.drivers AS d ON dp.driver_id = d.driver_id
WHERE
    dp.completed_rides >= 30
    AND dp.avg_rating >= 4.5
    AND (dp.cancelled_rides * 100.0) / NULLIF(dp.total_rides, 0) < 5.0
ORDER BY dp.completed_rides DESC, dp.avg_rating DESC
LIMIT 10;