Caese.sql_2

-- A CASE expression in SQL is a way 
--to apply conditional logic within your sql queires.
--SELECT 
--CASE
--WHEN column_name = 'value1' THEN 'Description for value1'
--WHEN column_name = 'value2' THEN 'Description for value2'
--ELSE 'Other'
--END AS column_description
--FROM
--table_name;


/*
Label new column as follows:
'Anywhere' jobs as 'Remote'
'New York, 'NY' jobs as 'Local'
Otherwise 'Onsite'
*/

SELECT 
    job_title_short,
    job_location,
CASE 
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
END AS location_category
FROM 
    job_postings_fact;

--To analyze how many jobs I can apply to specificall
--the local ones also look at the onsite as well,
--focusing on Data Analyst
SELECT 
    COUNT(job_id) AS number_of_jobs,
CASE 
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
END AS location_category
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category;

    /*
I want to categorize the salary from each job posting.
To see if it fits in my desired salary range.
    .Put salary into different buckets
    .Define what's a high, standard, or low salary with our own condition
    .Why it is easy to determine which job postings are
    worth looking at based on salary. Bucketing is 
    a common practice in data analysis when viewing 
    categories.
    .I only want to look at data analyst roles
    .Order from highest to lowest
    */

SELECT 
    job_id,
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
CASE    
    WHEN salary_year_avg < 5000 OR  salary_hour_avg < 25 THEN 'Low salary'
    WHEN salary_year_avg BETWEEN 5000 AND 8000 OR salary_hour_avg BETWEEN 25 AND 40 THEN 'Standard salary'
    ELSE 'High salary'
END AS salary_category
FROM
    job_postings_fact
WHERE job_title_short = 'Data Analyst'
ORDER BY 
    salary_year_avg DESC, salary_hour_avg DESC;


SELECT *
FROM
    job_postings_fact;


