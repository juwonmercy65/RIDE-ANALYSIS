--- Average Monthly Rides & Top 5 Consistent Drivers

WITH DriverMonthlyRides AS (
    SELECT
        driver_id,
        EXTRACT(YEAR FROM request_date) AS ride_year,
        EXTRACT(MONTH FROM request_date) AS ride_month,
        COUNT(ride_id) AS monthly_rides
    FROM public.rides
    WHERE status = 'completed'
    GROUP BY driver_id, ride_year, ride_month
),
DriverConsistency AS (
    SELECT
        d.name AS driver_name,
        SUM(dmr.monthly_rides) AS total_rides,
        -- Calculate the number of distinct (Year, Month) combinations
        COUNT(DISTINCT dmr.ride_year * 100 + dmr.ride_month) AS active_months,
        (SUM(dmr.monthly_rides) * 1.0) / COUNT(DISTINCT dmr.ride_year * 100 + dmr.ride_month) AS avg_monthly_rides
    FROM public.drivers AS d
    INNER JOIN DriverMonthlyRides AS dmr ON d.driver_id = dmr.driver_id
    GROUP BY d.driver_id, d.name
)
SELECT
    driver_name,
    total_rides,
    active_months,
    ROUND(avg_monthly_rides, 2) AS avg_monthly_rides_consistency
FROM DriverConsistency
ORDER BY avg_monthly_rides DESC
LIMIT 5;