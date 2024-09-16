subqueries_CTE.sql
/*
Subqueries and Common Table Expressions (CTEs): Used for organizing and simplifying complex queries
    helps break down the query into smaller, more manageable parts
    When to use one over the other?
        Subqueries are for simpler queries
        CTEs are for more complex queries
*/

SELECT *
    FROM(--Subquerry starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    ) AS january_jobs;
    --subquery ends here

--common table expression
WITH january_jobs AS (--CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    ) --CTE definition ends here

    SELECT * 
    FROM january_jobs;



-- select jobs that requires no degree
SELECT
    company_id,
    job_no_degree_mention
FROM
    job_postings_fact
WHERE
    job_no_degree_mention = true

  --Using subquery to Inserting the company_name  
SELECT 
   company_id,
   name AS company_name
FROM
     company_dim
WHERE company_id IN (
    SELECT 
       company_id
   FROM
       job_postings_fact
   WHERE
       job_no_degree_mention = true
   ORDER BY 
       company_id
)


/* Work with CTE
Find the companies that have the most job openings.
-Get the total number of job postings per company id
-Return the total number of jobs with the company name
*/
WITH company_job_count AS (
SELECT 
    company_id,
    COUNT(*) AS total_jobs
FROM
    job_postings_fact
GROUP BY 
    company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id
= company_dim.company_id
ORDER BY 
    total_jobs DESC


/*question1
Identify the top 5 skills that are most frequently
mentioned in job postings. Use a subquery to
find the skill IDs with the highest counts in the
skills_job_dim table and then join this result with
the skills_dim table to get the skill names
*/


SELECT 
    skill_id,
    skills AS name_of_skills
FROM
    skills_dim
WHERE
    skill_id IN (
SELECT  
    skill_id
FROM
    skills_job_dim
GROUP BY
    skill_id
ORDER BY skill_id DESC
LIMIT 5
)



/*2_assignment
Determine the size category ("Small", "Medium", or 'Large')
for each company by first identifying the number of job 
postings they have. Use a subquery to calculate the total
job postings per company. A company is considered 'small'
if it has less than 10 job postings, 'medium' if the number
of job postings is between 10 and 50, and 'Large' if it has
more than 50 job postings. Implement a subquery to aggregate
job counts per company before classifying them based on size.
*/

SELECT
   COUNT(company_id) AS count_company_id,
    name,
CASE
    WHEN company_id < 10 THEN 'Small'
    WHEN company_id BETWEEN 10 AND 50 THEN 'Medium'
    ELSE 'Large'
END AS size_category
FROM
    company_dim
GROUP BY
    company_id;
    

/* 
problem 7
find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings
    requiring the skill
*/
WITH remote_job_skills AS (
SELECT 
    skill_id,
    COUNT(*) AS skill_count
FROM 
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings 
ON
    job_postings.job_id = skills_to_job.job_id
WHERE 
    job_postings.job_work_from_home = true AND
    job_postings.job_title_short = 'Data Scientist'
GROUP BY
    skill_id
)
SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills
ON
    skills.skill_id = remote_job_skills.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5