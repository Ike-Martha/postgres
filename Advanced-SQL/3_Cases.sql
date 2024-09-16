
--CREATE TABLES FROM OTHER TABLE using the EXTRACT function
--Create three tables:
--Jan 2023 jobs
--Feb 2023 jobs
--Mar 2023 jobs

--January
CREATE TABLE january_jobs AS
    SELECT *
    FROM
    job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

--February
CREATE TABLE February_jobs AS
    SELECT *
    FROM
    job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

--March
CREATE TABLE March_jobs AS
    SELECT *
    FROM
    job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

    SELECT job_posted_date
        FROM
        March_jobs;

--April
CREATE TABLE April_jobs AS
    SELECT *
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 4;

    SELECT job_posted_date
        FROM
        April_jobs;

--May
CREATE TABLE May_jobs AS
    SELECT *
    FROM 
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 5;

SELECT job_posted_date
    FROM
    May_jobs;
