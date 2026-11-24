-- Sample data for the employee, quote and job tables (one transaction).
-- Generated with ChatGPT, which the course allowed for this task.
-- The comment below is the prompt I wrote: it sets the coverage the data
-- needed (roles, repeat customers, unused quotes, jobs above/below quote)
-- and the rules it had to follow.

/*
Indicate if AI was used (Yes/No): Yes

If AI was used:
I used ChatGPT (chatgpt.com) to generate Oracle SQL INSERT statements for the EMPLOYEE, QUOTE and JOB tables.
And also the sample data based on the prompt.

I used these prompts:
Please help me generate Oracle SQL INSERT statements for the EMPLOYEE, QUOTE and JOB tables. This is for sample data only.
The task says I need to load the EMPLOYEE, QUOTE and JOB tables with my own test data. As a minimum, the data should include:
* 10 EMPLOYEE entries
    * involved at least 2 managers, 2 truck dispatchers, 1 mechanic and 2 drivers
* 30 QUOTE entries
    * involved at least 5 different customers and 2 truck dispatchers
    * involved at least 2 customers who place at minimum 2 quotes
* 20 JOB entries
    * involved at least 10 truck/trailer combinations
    * involved at least 5 truck/trailer combinations that are used in at least 2 jobs
    * involved at least 2 quotes that have never been placed as job
    * involved at least 5 jobs that have slightly higher or lower cost than the quote
    * involved at least 5 jobs that have the same cost as the quote
The task also says the inserted data must conform to these rules:
* Treat all the data as a single transaction.
* The primary key values for this data should be hardcoded values, not sequences.
* If the primary key attribute’s data type is numeric, it must use values below 100.
* Dates used must be chosen between 1 May 2026 and 31 July 2026.
* The data added must be sensible, for example the drop-off time must be after the pickup time, only employees with the role Driver can drive the truck, and the job must align with the quote.
Here are my actual table structures. Please strictly use these column names and do not invent or rename any columns.
EMPLOYEE: emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager
QUOTE: quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no
JOB: job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, sched_emp_no, driver_emp_no, trailer_code, truck_vin
Please also include Sarah Mitchell as a manager and Michael Johnson as a driver, because they are needed in a later task.
For QUOTE, please use existing customer numbers from my database. You can use these customer numbers:1, 2, 8, 12, 18
For JOB, please only use real truck/trailer combinations from my database. Do not randomly mix truck_vin and trailer_code. 
Please use simple Oracle SQL only. Use TO_DATE for dates and datetime values. Do not use sequences, PL/SQL, WITH, views, SET ECHO, or SPOOL.
Please end with one COMMIT only.
*/

--------------------------------------
--INSERT INTO employee
--------------------------------------

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (1, 'Sarah', 'Mitchell', '0411111111', NULL, 'B', NULL);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (2, 'David', 'Smith', '0411111112', NULL, 'B', NULL);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (3, 'Emily', 'Chen', '0411111113', NULL, 'T', 1);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (4, 'James', 'Wilson', '0411111114', NULL, 'T', 2);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (5, 'Robert', 'Brown', '0411111115', NULL, 'M', 1);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (6, 'Mark', 'Taylor', '0411111116', NULL, 'M', 2);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (7, 'Michael', 'Johnson', '0411111117', 'DLIC0000001', 'D', 1);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (8, 'Chris', 'Evans', '0411111118', 'DLIC0000002', 'D', 2);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (9, 'Anna', 'Lee', '0411111119', 'DLIC0000003', 'D', 1);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (10, 'Jessica', 'Jones', '0411111120', 'DLIC0000004', 'D', 2);


--------------------------------------
--INSERT INTO quote
--------------------------------------

INSERT INTO quote VALUES (1, TO_DATE('01-May-2026', 'DD-Mon-YYYY'), TO_DATE('08-May-2026', 'DD-Mon-YYYY'), '10 Collins Street, Melbourne VIC 3000', '25 King Street, Melbourne VIC 3000', 900, 1, 3);
INSERT INTO quote VALUES (2, TO_DATE('02-May-2026', 'DD-Mon-YYYY'), TO_DATE('09-May-2026', 'DD-Mon-YYYY'), '12 Queen Street, Melbourne VIC 3000', '8 Swanston Street, Melbourne VIC 3000', 950, 1, 4);
INSERT INTO quote VALUES (3, TO_DATE('03-May-2026', 'DD-Mon-YYYY'), TO_DATE('10-May-2026', 'DD-Mon-YYYY'), '15 Bourke Street, Melbourne VIC 3000', '33 Flinders Street, Melbourne VIC 3000', 1000, 1, 3);
INSERT INTO quote VALUES (4, TO_DATE('04-May-2026', 'DD-Mon-YYYY'), TO_DATE('11-May-2026', 'DD-Mon-YYYY'), '40 Elizabeth Street, Melbourne VIC 3000', '77 Lygon Street, Carlton VIC 3053', 1100, 1, 4);
INSERT INTO quote VALUES (5, TO_DATE('05-May-2026', 'DD-Mon-YYYY'), TO_DATE('12-May-2026', 'DD-Mon-YYYY'), '5 Chapel Street, South Yarra VIC 3141', '19 Toorak Road, South Yarra VIC 3141', 1200, 1, 3);

INSERT INTO quote VALUES (6, TO_DATE('06-May-2026', 'DD-Mon-YYYY'), TO_DATE('13-May-2026', 'DD-Mon-YYYY'), '20 George Street, Sydney NSW 2000', '44 Pitt Street, Sydney NSW 2000', 1350, 7, 4);
INSERT INTO quote VALUES (7, TO_DATE('07-May-2026', 'DD-Mon-YYYY'), TO_DATE('14-May-2026', 'DD-Mon-YYYY'), '60 Market Street, Sydney NSW 2000', '10 York Street, Sydney NSW 2000', 1400, 7, 3);
INSERT INTO quote VALUES (8, TO_DATE('08-May-2026', 'DD-Mon-YYYY'), TO_DATE('15-May-2026', 'DD-Mon-YYYY'), '81 Kent Street, Sydney NSW 2000', '22 Park Street, Sydney NSW 2000', 1450, 7, 4);
INSERT INTO quote VALUES (9, TO_DATE('09-May-2026', 'DD-Mon-YYYY'), TO_DATE('16-May-2026', 'DD-Mon-YYYY'), '13 Harris Street, Pyrmont NSW 2009', '90 Riley Street, Darlinghurst NSW 2010', 1500, 7, 3);
INSERT INTO quote VALUES (10, TO_DATE('10-May-2026', 'DD-Mon-YYYY'), TO_DATE('18-May-2026', 'DD-Mon-YYYY'), '5 Bridge Road, Richmond VIC 3121', '71 Church Street, Richmond VIC 3121', 1550, 7, 4);

INSERT INTO quote VALUES (11, TO_DATE('11-May-2026', 'DD-Mon-YYYY'), TO_DATE('19-May-2026', 'DD-Mon-YYYY'), '18 Murray Street, Perth WA 6000', '92 Hay Street, Perth WA 6000', 1600, 8, 3);
INSERT INTO quote VALUES (12, TO_DATE('12-May-2026', 'DD-Mon-YYYY'), TO_DATE('20-May-2026', 'DD-Mon-YYYY'), '30 William Street, Perth WA 6000', '7 Milligan Street, Perth WA 6000', 1650, 8, 4);
INSERT INTO quote VALUES (13, TO_DATE('13-May-2026', 'DD-Mon-YYYY'), TO_DATE('21-May-2026', 'DD-Mon-YYYY'), '14 King William Street, Adelaide SA 5000', '66 Grenfell Street, Adelaide SA 5000', 1700, 8, 3);
INSERT INTO quote VALUES (14, TO_DATE('14-May-2026', 'DD-Mon-YYYY'), TO_DATE('22-May-2026', 'DD-Mon-YYYY'), '21 North Terrace, Adelaide SA 5000', '39 Rundle Street, Adelaide SA 5000', 1750, 8, 4);
INSERT INTO quote VALUES (15, TO_DATE('15-May-2026', 'DD-Mon-YYYY'), TO_DATE('23-May-2026', 'DD-Mon-YYYY'), '6 Hindley Street, Adelaide SA 5000', '84 Pulteney Street, Adelaide SA 5000', 1800, 8, 3);

INSERT INTO quote VALUES (16, TO_DATE('16-May-2026', 'DD-Mon-YYYY'), TO_DATE('24-May-2026', 'DD-Mon-YYYY'), '11 Ann Street, Brisbane QLD 4000', '50 Queen Street, Brisbane QLD 4000', 1850, 12, 4);
INSERT INTO quote VALUES (17, TO_DATE('18-May-2026', 'DD-Mon-YYYY'), TO_DATE('25-May-2026', 'DD-Mon-YYYY'), '28 Edward Street, Brisbane QLD 4000', '73 Albert Street, Brisbane QLD 4000', 1900, 12, 3);
INSERT INTO quote VALUES (18, TO_DATE('19-May-2026', 'DD-Mon-YYYY'), TO_DATE('26-May-2026', 'DD-Mon-YYYY'), '9 Eagle Street, Brisbane QLD 4000', '41 Wharf Street, Brisbane QLD 4000', 1950, 12, 4);
INSERT INTO quote VALUES (19, TO_DATE('20-May-2026', 'DD-Mon-YYYY'), TO_DATE('27-May-2026', 'DD-Mon-YYYY'), '62 Creek Street, Brisbane QLD 4000', '16 Mary Street, Brisbane QLD 4000', 2000, 12, 3);
INSERT INTO quote VALUES (20, TO_DATE('21-May-2026', 'DD-Mon-YYYY'), TO_DATE('28-May-2026', 'DD-Mon-YYYY'), '25 Adelaide Street, Brisbane QLD 4000', '47 George Street, Brisbane QLD 4000', 2050, 12, 4);

INSERT INTO quote VALUES (21, TO_DATE('22-May-2026', 'DD-Mon-YYYY'), TO_DATE('29-May-2026', 'DD-Mon-YYYY'), '17 Collins Street, Melbourne VIC 3000', '88 Spencer Street, Melbourne VIC 3000', 2100, 18, 3);
INSERT INTO quote VALUES (22, TO_DATE('23-May-2026', 'DD-Mon-YYYY'), TO_DATE('30-May-2026', 'DD-Mon-YYYY'), '31 La Trobe Street, Melbourne VIC 3000', '52 Russell Street, Melbourne VIC 3000', 2150, 18, 4);
INSERT INTO quote VALUES (23, TO_DATE('24-May-2026', 'DD-Mon-YYYY'), TO_DATE('31-May-2026', 'DD-Mon-YYYY'), '19 Exhibition Street, Melbourne VIC 3000', '70 Spring Street, Melbourne VIC 3000', 2200, 18, 3);
INSERT INTO quote VALUES (24, TO_DATE('25-May-2026', 'DD-Mon-YYYY'), TO_DATE('01-Jun-2026', 'DD-Mon-YYYY'), '44 St Kilda Road, Melbourne VIC 3004', '12 Domain Road, Melbourne VIC 3004', 2250, 18, 4);
INSERT INTO quote VALUES (25, TO_DATE('26-May-2026', 'DD-Mon-YYYY'), TO_DATE('02-Jun-2026', 'DD-Mon-YYYY'), '73 Queens Road, Melbourne VIC 3004', '35 Clarendon Street, Southbank VIC 3006', 2300, 18, 3);

INSERT INTO quote VALUES (26, TO_DATE('01-Jun-2026', 'DD-Mon-YYYY'), TO_DATE('08-Jun-2026', 'DD-Mon-YYYY'), '9 Victoria Street, Hobart TAS 7000', '21 Davey Street, Hobart TAS 7000', 2400, 1, 4);
INSERT INTO quote VALUES (27, TO_DATE('05-Jun-2026', 'DD-Mon-YYYY'), TO_DATE('12-Jun-2026', 'DD-Mon-YYYY'), '18 Smith Street, Darwin NT 0800', '40 Mitchell Street, Darwin NT 0800', 2500, 7, 3);
INSERT INTO quote VALUES (28, TO_DATE('10-Jun-2026', 'DD-Mon-YYYY'), TO_DATE('17-Jun-2026', 'DD-Mon-YYYY'), '51 London Circuit, Canberra ACT 2601', '6 Northbourne Avenue, Canberra ACT 2601', 2600, 8, 4);
INSERT INTO quote VALUES (29, TO_DATE('15-Jun-2026', 'DD-Mon-YYYY'), TO_DATE('22-Jun-2026', 'DD-Mon-YYYY'), '14 Macquarie Street, Sydney NSW 2000', '90 Oxford Street, Sydney NSW 2000', 2700, 12, 3);
INSERT INTO quote VALUES (30, TO_DATE('20-Jun-2026', 'DD-Mon-YYYY'), TO_DATE('27-Jun-2026', 'DD-Mon-YYYY'), '8 King Street, Perth WA 6000', '55 Wellington Street, Perth WA 6000', 2800, 18, 4);


--------------------------------------
--INSERT INTO job
--------------------------------------

INSERT INTO job VALUES (1, TO_DATE('08-May-2026 09:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('08-May-2026 14:00:00', 'DD-Mon-YYYY HH24:MI:SS'), NULL, 'Y', 1, 3, 7, 'TRL01', '1HGBH41JXMN109186');
INSERT INTO job VALUES (2, TO_DATE('09-May-2026 10:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('09-May-2026 15:00:00', 'DD-Mon-YYYY HH24:MI:SS'), NULL, 'Y', 2, 4, 8, 'TRL01', '1HGBH41JXMN109186');

INSERT INTO job VALUES (3, TO_DATE('10-May-2026 08:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('10-May-2026 13:00:00', 'DD-Mon-YYYY HH24:MI:SS'), NULL, 'Y', 3, 3, 9, 'TRL01', '2FMDK3GC8BBA12345');
INSERT INTO job VALUES (4, TO_DATE('11-May-2026 11:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('11-May-2026 16:00:00', 'DD-Mon-YYYY HH24:MI:SS'), NULL, 'N', 4, 4, 10, 'TRL01', '2FMDK3GC8BBA12345');

INSERT INTO job VALUES (5, TO_DATE('12-May-2026 09:30:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('12-May-2026 14:30:00', 'DD-Mon-YYYY HH24:MI:SS'), NULL, 'Y', 5, 3, 7, 'TRL01', '3VWFE21C04M000001');
INSERT INTO job VALUES (6, TO_DATE('13-May-2026 08:30:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('13-May-2026 13:30:00', 'DD-Mon-YYYY HH24:MI:SS'), 1420, 'Y', 6, 4, 8, 'TRL01', '3VWFE21C04M000001');

INSERT INTO job VALUES (7, TO_DATE('14-May-2026 09:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('14-May-2026 15:00:00', 'DD-Mon-YYYY HH24:MI:SS'), 1340, 'N', 7, 3, 9, 'TRL02', '2FMDK3GC8BBA12345');
INSERT INTO job VALUES (8, TO_DATE('15-May-2026 10:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('15-May-2026 16:00:00', 'DD-Mon-YYYY HH24:MI:SS'), 1530, 'Y', 8, 4, 10, 'TRL02', '2FMDK3GC8BBA12345');

INSERT INTO job VALUES (9, TO_DATE('16-May-2026 09:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('16-May-2026 14:00:00', 'DD-Mon-YYYY HH24:MI:SS'), 1460, 'Y', 9, 3, 7, 'TRL02', '5FNRL5H40BB098765');
INSERT INTO job VALUES (10, TO_DATE('18-May-2026 08:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('18-May-2026 13:00:00', 'DD-Mon-YYYY HH24:MI:SS'), 1650, 'N', 10, 4, 8, 'TRL02', '5FNRL5H40BB098765');

INSERT INTO job VALUES (11, TO_DATE('19-May-2026 09:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('19-May-2026 14:00:00', 'DD-Mon-YYYY HH24:MI:SS'), NULL, 'Y', 11, 3, 9, 'TRL03', '2C4RDGCG8ER123789');
INSERT INTO job VALUES (12, TO_DATE('20-May-2026 10:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('20-May-2026 15:00:00', 'DD-Mon-YYYY HH24:MI:SS'), 1740, 'Y', 12, 4, 10, 'TRL03', '3VWFE21C04M000001');
INSERT INTO job VALUES (13, TO_DATE('21-May-2026 08:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('21-May-2026 13:00:00', 'DD-Mon-YYYY HH24:MI:SS'), 1820, 'Y', 13, 3, 7, 'TRL04', '1FTFW1ET5DFC10112');
INSERT INTO job VALUES (14, TO_DATE('22-May-2026 11:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('22-May-2026 17:00:00', 'DD-Mon-YYYY HH24:MI:SS'), 1680, 'N', 14, 4, 8, 'TRL04', '4T1BF1FK5CU123456');
INSERT INTO job VALUES (15, TO_DATE('23-May-2026 09:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('23-May-2026 14:00:00', 'DD-Mon-YYYY HH24:MI:SS'), NULL, 'Y', 15, 3, 9, 'TRL05', '1HGBH41JXMN109186');
INSERT INTO job VALUES (16, TO_DATE('24-May-2026 08:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('24-May-2026 13:00:00', 'DD-Mon-YYYY HH24:MI:SS'), 1960, 'Y', 16, 4, 10, 'TRL05', '5FNRL5H40BB098765');
INSERT INTO job VALUES (17, TO_DATE('25-May-2026 09:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('25-May-2026 14:00:00', 'DD-Mon-YYYY HH24:MI:SS'), 1830, 'Y', 17, 3, 7, 'TRL03', '2C4RDGCG8ER123789');
INSERT INTO job VALUES (18, TO_DATE('26-May-2026 10:00:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('26-May-2026 15:00:00', 'DD-Mon-YYYY HH24:MI:SS'), NULL, 'N', 18, 4, 8, 'TRL04', '1FTFW1ET5DFC10112');
INSERT INTO job VALUES (19, TO_DATE('27-May-2026 08:30:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('27-May-2026 13:30:00', 'DD-Mon-YYYY HH24:MI:SS'), 2100, 'Y', 19, 3, 9, 'TRL05', '1HGBH41JXMN109186');
INSERT INTO job VALUES (20, TO_DATE('28-May-2026 09:30:00', 'DD-Mon-YYYY HH24:MI:SS'), TO_DATE('28-May-2026 14:30:00', 'DD-Mon-YYYY HH24:MI:SS'), NULL, 'Y', 20, 4, 10, 'TRL05', '5FNRL5H40BB098765');

COMMIT;
