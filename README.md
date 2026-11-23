# Freight Company Database (FIT2094)

Part of my Oracle SQL work for a freight and logistics company database, from FIT2094 Databases at Monash University.

> **Only the parts I wrote are here.** The data model and the starting schema with sample data were provided by the course and are not included, following university policy. Because of this, the scripts will not run on their own.

## The business

A freight company prepares **quotes** for **customers**. An accepted quote becomes a **job**, and each job uses one **truck and trailer combination**. **Employees** are managers, truck dispatchers, mechanics or drivers. Each employee can have a manager, who is another employee.

## `schema.sql`: tables and constraints

I created the `employee`, `job` and `quote` tables from the given data model:

- **Primary keys** on every table
- **Foreign keys**:
  - quote → customer and employee
  - job → quote, the scheduling employee, the driver, and the truck/trailer combination
  - employee → employee (manager)
- **CHECK constraints**: `emp_role` must be `B`, `T`, `M` or `D`, and `job_payment_made` must be `Y` or `N`
- **UNIQUE constraints**: an employee's contact number and licence number

## `queries.sql`: business analysis queries

| Query | Question it answers | SQL used |
|---|---|---|
| (a) | Which repeat customers have above-average quotes? | `JOIN`, `GROUP BY`, `HAVING` with a subquery, `NVL` to show a business name or a person's name |
| (b) | Who is each employee's manager, and how many jobs has each dispatcher scheduled? | Self-join on `employee`, `LEFT JOIN`, `CASE` |
| (c) | How much is each truck and trailer combination used? | `LEFT JOIN` to keep unused combinations, nested subquery for the average, `CASE` to label High Use / Standard Use / Never Used |

Some decisions I made in these queries:

- **(a) uses `HAVING`, not `WHERE`**, because both conditions depend on totals that only exist after grouping: the number of quotes and the average quote.
- **(b) uses `LEFT JOIN` for the manager**, so employees with no manager are kept and shown as "No Manager".
- **(c) counts `COUNT(j.job_no)`, not `COUNT(*)`**. With a `LEFT JOIN`, an unused combination still gives one row with `NULL` job columns. `COUNT(*)` would count that row as 1, but `COUNT(j.job_no)` correctly gives 0.

## Tools

Oracle SQL, SQL Developer
