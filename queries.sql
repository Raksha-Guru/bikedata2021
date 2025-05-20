CREATE OR REPLACE Table `bikedata2021.bikedata2021.bikedata2021` AS
SELECT
  ride_id,
  rideable_type,
  member_casual,
  started_at,
  ended_at,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_minutes,
  FORMAT_TIMESTAMP('%A', started_at) AS weekday_name,
FROM
  `bikedata2021.bikedata2021.bikedata2021`
WHERE
  ended_at > started_at
  AND member_casual IS NOT NULL;

  SELECT member_casual, COUNT(*) AS total_rides
FROM `bikedata2021.bikedata2021.bikedata2021`
GROUP BY member_casual;

SELECT member_casual, AVG(ride_length_minutes) AS avg_ride_duration
FROM `bikedata2021.bikedata2021.bikedata2021`
GROUP BY member_casual;

-- Ride behavior by day
WITH cleaned_data AS (
  SELECT
    member_casual,
    EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week_num, -- 1 = Sunday, 7 = Saturday
    FORMAT_DATE('%A', DATE(started_at)) AS weekday_name,
    TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_minutes
  FROM `bikedata2021.bikedata2021.bikedata2021`
  WHERE TIMESTAMP_DIFF(ended_at, started_at, MINUTE) > 0
)

SELECT
  day_of_week_num,
  weekday_name,
  member_casual,
  COUNT(*) AS total_rides,
  ROUND(AVG(ride_length_minutes), 2) AS avg_ride_length
FROM cleaned_data
GROUP BY day_of_week_num, weekday_name, member_casual
ORDER BY day_of_week_num, member_casual;








