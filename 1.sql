SELECT
    r.distance_km,
    d.name AS driver_name,
    rd.name AS rider_name,
    r.pickupcity,
    r.dropoffcity,
    p.method AS payment_method
FROM public.rides AS r
INNER JOIN public.drivers AS d ON r.driverid = d.driverid
INNER JOIN public.riders AS rd ON r.rider_id = rd.rider_id
LEFT JOIN public.payments AS p ON r.rideid = p.rideid  -- LEFT JOIN to ensure the ride is included even if payment is missing
WHERE r.status = 'completed' -- Only completed rides should have a distance
  AND r.distance_km > 0
  AND r.request_date >= '2021-06-01' AND r.request_date <= '2024-12-31'
ORDER BY r.distance_km DESC
LIMIT 10;