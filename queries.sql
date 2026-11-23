-- (a) Repeat customers with above-average quotes
--     Customers with more than one quote whose average quote is higher
--     than the average of all quotes.
SELECT c.cust_no,
       nvl(
           c.cust_bname,
           c.cust_gname
           || ' '
           || c.cust_fname
       ) AS customer_name,
       COUNT(q.quote_no) AS num_quotes,
       to_char(
           avg(q.quote_cost),
           '$9,990.00'
       ) AS avg_quoted_cost
  FROM customer c
  JOIN quote q
ON c.cust_no = q.cust_no
 GROUP BY c.cust_no,
          nvl(
              c.cust_bname,
              c.cust_gname
              || ' '
              || c.cust_fname
          )
HAVING COUNT(q.quote_no) > 1
   AND AVG(q.quote_cost) > (
    SELECT AVG(quote_cost)
      FROM quote
)
 ORDER BY AVG(q.quote_cost) DESC,
          c.cust_no;



-- (b) Employees, their role, their manager and jobs dispatched
--     Self-join on employee to find each manager; CASE turns role codes
--     into names; dispatchers also show how many jobs they scheduled.
SELECT e.emp_no,
       e.emp_gname
       || ' '
       || e.emp_fname AS emp_name,
       CASE upper(e.emp_role)
           WHEN 'B' THEN
               'Manager'
           WHEN 'T' THEN
               'Truck Dispatcher'
           WHEN 'M' THEN
               'Mechanic'
           WHEN 'D' THEN
               'Driver'
           ELSE
               'Unknown'
       END AS emp_role_full,
       CASE
           WHEN em.emp_no IS NULL THEN
               'No Manager'
           ELSE
               em.emp_gname
               || ' '
               || em.emp_fname
       END AS manager_name,
       CASE upper(e.emp_role)
           WHEN 'T' THEN
               to_char(count(j.job_no))
           ELSE
               ' '
       END AS jobs_dispatched
  FROM employee e
  LEFT JOIN employee em
ON e.emp_no_manager = em.emp_no
  LEFT JOIN job j
ON j.sched_emp_no = e.emp_no
 GROUP BY e.emp_no,
          e.emp_gname
          || ' '
          || e.emp_fname,
          e.emp_role,
          em.emp_no,
          em.emp_gname
          || ' '
          || em.emp_fname
 ORDER BY e.emp_no;




-- (c) Truck and trailer combination usage
--     LEFT JOIN keeps combinations that were never used; a nested
--     subquery gives the average number of jobs per combination.
SELECT t.truck_vin,
       t.truck_rego,
       tr.trailer_code,
       lpad(
           to_char(
               tr.trailer_purchase_cost,
               '$999,990.00'
           ),
           21,
           ' '
       ) AS trailer_purchase_cost,
       COUNT(j.job_no) AS num_jobs,
       CASE
           WHEN COUNT(j.job_no) = 0 THEN
               lpad(
                   'No jobs',
                   17,
                   ' '
               )
           ELSE
               lpad(
                   to_char(
                       sum(q.quote_cost),
                       '$999,990.00'
                   ),
                   17,
                   ' '
               )
       END AS total_quoted_cost,
       CASE
           WHEN COUNT(j.job_no) > (
               SELECT AVG(job_counts)
                 FROM (
                   SELECT jo.trailer_code,
                          jo.truck_vin,
                          COUNT(jo.job_no) AS job_counts
                     FROM job jo
                    GROUP BY jo.trailer_code,
                             jo.truck_vin
               )
           )                   THEN
               'High Use'
           WHEN COUNT(j.job_no) = 0 THEN
               'Never Used'
           ELSE
               'Standard Use'
       END AS usage
  FROM combination c
  JOIN truck t
ON c.truck_vin = t.truck_vin
  JOIN trailer tr
ON c.trailer_code = tr.trailer_code
  LEFT JOIN job j
ON c.truck_vin = j.truck_vin
   AND c.trailer_code = j.trailer_code
  LEFT JOIN quote q
ON q.quote_no = j.quote_no
 GROUP BY t.truck_vin,
          t.truck_rego,
          tr.trailer_code,
          tr.trailer_purchase_cost
 ORDER BY COUNT(j.job_no) DESC,
          t.truck_vin,
          tr.trailer_code;
