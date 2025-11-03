---compare quarterly revenue between 2021, 2022, 2023, and 2024. Which quarter had the biggest YoY growth?
WITH QuarterlyRevenue AS (
    SELECT
        EXTRACT(YEAR FROM request_date) AS ride_year,
        EXTRACT(QUARTER FROM request_date) AS ride_quarter,
        SUM(fare) AS total_revenue
    FROM public.rides
    WHERE status = 'completed' AND request_date BETWEEN '2021-06-01' AND '2024-12-31'
    GROUP BY ride_year, ride_quarter
),
YoYGrowth AS (
    SELECT
        ride_year,
        ride_quarter,
        total_revenue,
        LAG(total_revenue, 1) OVER (
            PARTITION BY ride_quarter ORDER BY ride_year
        ) AS prev_year_revenue,
        (total_revenue - LAG(total_revenue, 1) OVER (
            PARTITION BY ride_quarter ORDER BY ride_year
        )) / LAG(total_revenue, 1) OVER (
            PARTITION BY ride_quarter ORDER BY ride_year
        ) * 100 AS yoy_growth_percent
    FROM QuarterlyRevenue
)
SELECT *
FROM YoYGrowth
WHERE yoy_growth_percent IS NOT NULL
ORDER BY yoy_growth_percent DESC;