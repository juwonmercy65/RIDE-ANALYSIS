--- 2021 Riders Still Riding in 2024

/*SELECT
    COUNT(DISTINCT T1.rider_id) AS riders_2021_active_in_2024

FROM (
    -- Riders who signed up in 2021
    SELECT rider_id
    FROM public.riders
    WHERE EXTRACT(YEAR FROM signup_date) = 2021
) AS T1

INNER JOIN public.rides AS r
    ON T1.rider_id = r.rider_id

WHERE
    EXTRACT(YEAR FROM r.request_date) = 2024;*/
	
--- OR

/*SELECT COUNT(DISTINCT rd.rider_id) AS active_2024_riders
FROM public.riders rd
JOIN public.rides r ON rd.rider_id = r.rider_id
WHERE EXTRACT(YEAR FROM rd.signup_date) = 2021
  AND EXTRACT(YEAR FROM r.request_date) = 2024;*/
