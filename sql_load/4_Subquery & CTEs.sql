--Subquery & CTEs
/*SELECT
      job_postings_fact.company_id,
      company_dim.name,
      job_postings_fact.job_title_short,
      job_postings_fact.job_no_degree_mention
From
     job_postings_fact
LEFT JOIN
     company_dim
ON
     job_postings_fact.company_id = company_dim.company_id          
WHERE
     job_no_degree_mention = true;     
*/

--Subquery to get the company_id of companies that have job postings mentioning no degree requirement, and then select the company_id and name from the company_dim table for those companies.

/*SELECT
      company_id,
      name AS company_name
FROM
      company_dim
WHERE
      company_id IN (
            SELECT
                  company_id
            FROM
                  job_postings_fact
            WHERE
                  job_no_degree_mention = true
            ORDER BY
                  company_id

      );            
*/

--CTE to get the company_id of companies that have job postings mentioning no degree requirement, and then select the company_id and name from the company_dim table for those companies.

/*WITH no_degree_companies AS (
      SELECT
            company_id
      FROM
            job_postings_fact
      WHERE
            job_no_degree_mention = true
)
SELECT
      company_id,
      name AS company_name
FROM
      company_dim
WHERE
      company_id IN (SELECT company_id FROM no_degree_companies)
ORDER BY
      company_id;
*/

/*
Find the companies that have the most job openings.
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/

WITH company_job_count AS 
(SELECT
      company_id,
      COUNT(*) AS total_jobs
FROM
      job_postings_fact
GROUP BY 
      company_id)

SELECT 
      company_dim.name AS company_name,
      company_job_count.total_jobs
FROM
      company_dim
LEFT JOIN
      company_job_count
ON
      company_dim.company_id = company_job_count.company_id
ORDER BY 
      company_job_count.total_jobs DESC;      