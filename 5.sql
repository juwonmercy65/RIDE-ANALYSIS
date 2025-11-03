--- Cancellation Rate Per City
-----Cancellation Rate = (Cancelled Rides / Total Requested Rides) per city.


WITH CityRideMetrics AS (
    SELECT
        pickup_city AS city,
        COUNT(ride_id) AS total_rides_requested,
        SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_rides
    FROM public.rides
    WHERE request_date BETWEEN '2021-06-01' AND '2024-12-31'
    GROUP BY 1
)
SELECT
    city,
    total_rides_requested,
    (cancelled_rides * 100.0) / NULLIF(total_rides_requested, 0) AS cancellation_rate_percent
FROM CityRideMetrics
ORDER BY cancellation_rate_percent DESC, total_rides_requested DESC
LIMIT 10;