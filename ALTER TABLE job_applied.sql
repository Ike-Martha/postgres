ALTER TABLE job_applied
ADD contact VARCHAR(50);

UPDATE job_applied
SET contact = 'Erlich Bachman'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Alozie Uzoma'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Chiagoziem Douglas'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Alozie Beulah'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Amanda James'
WHERE job_id = 5;

SELECT * FROM job_applied;