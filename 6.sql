--- Identify riders who have taken more than 10 rides but never paid with cash.
SELECT
    rd.rider_id,
    rd.name,
    COUNT(r.ride_id) AS total_rides_completed
FROM public.riders AS rd
INNER JOIN public.rides AS r ON rd.rider_id = r.rider_id
INNER JOIN public.payments AS p ON r.ride_id = p.ride_id
WHERE r.status = 'completed'
GROUP BY rd.rider_id, rd.name
HAVING COUNT(r.ride_id) > 10 -- Taken more than 10 completed rides
   AND SUM(CASE WHEN p.method = 'Cash' THEN 1 ELSE 0 END) = 0; -- Never paid with cash