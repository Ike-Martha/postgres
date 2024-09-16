UNION.SQL
/*UNION Operators combines result sets of two or more SELECT statements into one single result set.
    UNION: Removes duplicate rows
    UNION ALL: Includes all duplicate rows
*/

-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION

--Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION

--Get jobs and companies from March jobs
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs


--UNION ALL

-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

--Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

--Get jobs and companies from March jobs
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs


/*
Practice Problem 1
.Get the corresponding skill and skill type for 
each job posting in q1
.Include those without any skills, too
.Why? Look at the skills and the type for each 
job in the first quater that has a salary > $70,000
*/

/* Problem_8.sql
Find job postings from the first quarter that have a 
salary greater that $70k
-Combine job posting tables from the first quater of
 2023 (Jan-Mar)
 -Get job postings with an average yearly slaray > $70,000
 */

SELECT 
    quater1_job_postings.job_title_short,
    quater1_job_postings.job_location,
    quater1_job_postings.job_via,
    quater1_job_postings.salary_year_avg,
    quater1_job_postings.job_posted_date::date
FROM (
    SELECT *
    FROM
        january_jobs

    UNION ALL

    SELECT *
    FROM    
        february_jobs

    UNION ALL

    SELECT *
    FROM
        march_jobs
) AS quater1_job_postings
WHERE 
    quater1_job_postings.salary_year_avg > 70000  and
   (quater1_job_postings.job_title_short = 'Data Scientist' OR 
   quater1_job_postings.job_title_short = 'Data Analyst')
ORDER BY 
    quater1_job_postings.salary_year_avg DESC

 
