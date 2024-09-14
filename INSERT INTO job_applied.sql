INSERT INTO job_applied
(
    job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)
VALUES  (1,
'2024-02-01',
'true',
'resume_01.pdf',
'true',
'cover_letter_01.pdf',
'submitted'
),

(2,
'2024-02-11',
'false',
'resume_02.pdf',
'true',
'cover_letter_02.pdf',
'Null'
),

(3,
'2024-05-01',
'false',
'resume_03.pdf',
'false',
'cover_letter_03.pdf',
'ghosted'
),

(4,
'2024-03-09',
'true',
'resume_01.pdf',
'true',
'cover_letter_01.pdf',
'interview schedules'
),

(5,
'2024-04-04',
'true',
'resume_05.pdf',
'false',
'cover_letter_05.pdf',
'Null'
);

SELECT *
FROM job_applied;