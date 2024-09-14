--Date
--:: cast is used to convert from one datatype to the other
SELECT '2023-02-19'::Date,
'123'::INTEGER,
'TRUE'::BOOLEAN,
'3.14'::REAL;

-- To remove the time stamp from the date
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
    FROM
    job_postings_fact;

 -- Changing the time zone from 'UTC' to 'EST'   
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC'  AT TIME ZONE 'EST' AS date_time
FROM
    job_postings_fact
LIMIT 5;

--Extract gets field (e.g, year, month, day) from a date/time value
SELECT 
    job_title_short AS title,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',
    EXTRACT(YEAR FROM job_posted_date) AS YEAR,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
    LIMIT 5;

--to count how many "Data Analyst" job postings were 
--made each month and then list the months in order
-- of the number of postings, from the highest to the lowest.
SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS MONTH
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    MONTH
ORDER BY 
    job_posted_count DESC;


--A query to find the average salary both yearly
--(salary_year_avg)and hourly (salary_hour_avg)
-- for job postings that were posted after June 1, 2023.
--Group the result by job schedule type.

SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS Yearly_salary,
    AVG(salary_hour_avg) AS Salary_by_hour,
    COUNT(job_posted_date) AS date_of_job
--EXTRACT(MONTH FROM job_posted_date) AS MONTH
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'::DATE
GROUP BY

    job_schedule_type;



  --A querry to count the number of job postings for each
  -- month in 2023, adjusting the job_posted_date to be in
  -- 'America,New_York' time zone befor extracting (hint)
  --the month. Assume the job_posted_date is stored in UTC
  --Group by and order by the month.

  SELECT 
    COUNT(job_posted_date) AS count_of_job_posted,
   -- job_posted_date AT TIME ZONE 'UTC'  AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS MONTH
FROM
    job_postings_fact
GROUP BY MONTH
ORDER BY MONTH;


SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date_at_ny) AS month
FROM (
    SELECT
        job_id,
        job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York' AS job_posted_date_at_ny
    FROM
        job_postings_fact
    WHERE
        EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
) AS adjusted_dates
GROUP BY
    month
ORDER BY
    month;

    -- A querry to find companies (include company name)
    -- that have posted jobs offerring health insurance,
    --where these poastings were made in the second
    --quater of 2023. use date extraction to filter by 
    --quater.
