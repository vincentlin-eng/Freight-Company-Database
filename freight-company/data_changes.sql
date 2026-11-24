-- Data changes with sequences and transactions.
-- (a) create sequences for new keys
-- (b) add a new truck dispatcher who reports to an existing manager
-- (c) record a new quote and the job created from it
-- (d) reschedule the job and set its cost from the quote
-- (e) cancel the job
-- Rows are found by business values (names, dates), not hard-coded keys.

--3(a)
DROP SEQUENCE employee_seq;
DROP SEQUENCE quote_seq;
DROP SEQUENCE job_seq;

CREATE SEQUENCE employee_seq START WITH 300 INCREMENT BY 5;

CREATE SEQUENCE quote_seq START WITH 300 INCREMENT BY 5;

CREATE SEQUENCE job_seq START WITH 300 INCREMENT BY 5;


--3(b)
INSERT INTO employee
    (
        SELECT employee_seq.NEXTVAL,
               'Aurello',
               'Brown',
               '0431952053',
               NULL,
               'T',
               emp_no
          FROM employee
         WHERE upper(emp_gname) = upper('Sarah')
           AND upper(emp_fname) = upper('Mitchell')
           AND upper(emp_role) = 'B'
    );

COMMIT;


--3(c)
INSERT INTO quote (
    quote_no,
    quote_prepared_date,
    quote_pref_start_date,
    quote_start_location,
    quote_end_location,
    quote_cost,
    cust_no,
    emp_no
)
    SELECT quote_seq.NEXTVAL,
           TO_DATE('17-May-2026','dd-Mon-yyyy'),
           TO_DATE('25-May-2026','dd-Mon-yyyy'),
           '29 Kuranda Road, Adelaide SA 5030',
           '9 Albatros Drive, Mount Gambier SA 5270',
           1000,
           c.cust_no,
           (
               SELECT e.emp_no
                 FROM employee e
                WHERE upper(e.emp_gname) = upper('Aurello')
                  AND upper(e.emp_fname) = upper('Brown')
                  AND upper(e.emp_role) = upper('T')
           )
      FROM customer c
     WHERE upper(c.cust_gname) = 'VICTORIA'
       AND upper(c.cust_fname) = 'ELLA'
       AND upper(c.cust_bname) = upper('Flintstone Store');


INSERT INTO job (
    job_no,
    job_pickup_dt,
    job_intended_dropoff_dt,
    job_cost,
    job_payment_made,
    quote_no,
    sched_emp_no,
    driver_emp_no,
    trailer_code,
    truck_vin
)
    SELECT job_seq.NEXTVAL,
           TO_DATE('25-May-2026 09:00:00 AM','dd-Mon-yyyy hh:mi:ss AM'),
           TO_DATE('25-May-2026 02:00:00 PM','dd-Mon-yyyy hh:mi:ss AM'),
           NULL,
           'Y',
           quote_seq.CURRVAL,
           d.emp_no,
           (
               SELECT f.emp_no
                 FROM employee f
                WHERE upper(f.emp_gname) = upper('Michael')
                  AND upper(f.emp_fname) = upper('Johnson')
                  AND upper(f.emp_role) = 'D'
           ),
           'TRL08',
           '1HGBH41JXMN109186'
      FROM employee d
     WHERE upper(d.emp_gname) = upper('Aurello')
       AND upper(d.emp_fname) = upper('Brown')
       AND upper(d.emp_role) = 'T';

COMMIT;

   

--3(d)
UPDATE job
   SET job_pickup_dt = TO_DATE('25-May-2026 02:00:00 PM','dd-Mon-yyyy hh:mi:ss AM'),
       job_intended_dropoff_dt = TO_DATE('25-May-2026 07:00:00 PM','dd-Mon-yyyy hh:mi:ss AM'
       ),
       job_cost = (
           SELECT q.quote_cost * 1.2
             FROM quote q
            WHERE q.quote_no = job.quote_no
       ),
       job_payment_made = 'Y'
 WHERE quote_no = (
    SELECT q.quote_no
      FROM quote q
     WHERE q.quote_prepared_date = TO_DATE('17-May-2026','dd-Mon-yyyy')
       AND q.cust_no = (
        SELECT c.cust_no
          FROM customer c
         WHERE upper(cust_gname) = 'VICTORIA'
           AND upper(cust_fname) = 'ELLA'
           AND upper(cust_bname) = upper('Flintstone Store')
    )
);

COMMIT;

--3(e)
DELETE FROM job
 WHERE quote_no = (
    SELECT q.quote_no
      FROM quote q
     WHERE q.quote_prepared_date = TO_DATE('17-May-2026','dd-Mon-yyyy')
       AND q.cust_no = (
        SELECT c.cust_no
          FROM customer c
         WHERE upper(cust_gname) = 'VICTORIA'
           AND upper(cust_fname) = 'ELLA'
           AND upper(cust_bname) = upper('Flintstone Store')
    )
);

COMMIT;
