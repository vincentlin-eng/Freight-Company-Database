# Database Design and SQL (FIT2094)

My work from FIT2094 Databases at Monash University (2026): designing a database from business requirements, then building, changing and querying one in Oracle SQL.

| Folder | What it shows |
|---|---|
| [`waste-collection-design/`](waste-collection-design) | Data modelling: conceptual model → normalisation to 3NF → logical model → generated schema |
| [`freight-company/`](freight-company) | SQL: tables and constraints, data changes with transactions, schema changes, business queries |

> **Only the parts I wrote are here.** Assignment briefs, data models and starting schemas provided by the course are not included, following university policy, so the scripts will not run on their own.

---

## Part 1: Waste collection database design

A council waste collection service: **authorities** manage **streets** and sign **contracts**; each contract covers some **waste types** and **bin types**; **properties** have **bins**; trucks do **collection runs** and record the weight collected from each bin.

| File | Content |
|---|---|
| [`conceptual_model.pdf`](waste-collection-design/conceptual_model.pdf) | Entities, relationships and cardinalities (crow's foot notation) |
| [`normalisation.md`](waste-collection-design/normalisation.md) | The collection report taken from UNF to 3NF, with the partial and transitive dependencies removed at each step |
| [`assumptions.md`](waste-collection-design/assumptions.md) | Business assumptions, and why I used surrogate keys |
| [`logical_model.png`](waste-collection-design/logical_model.png) | Logical model in Oracle SQL Developer Data Modeler: 14 tables with primary, foreign and unique keys |
| [`schema.sql`](waste-collection-design/schema.sql) | `CREATE TABLE` script generated from the logical model |

---

## Part 2: Freight company SQL

A freight company prepares **quotes** for **customers**. An accepted quote becomes a **job**, and each job uses one **truck and trailer combination**. **Employees** are managers, truck dispatchers, mechanics or drivers. Each employee can have a manager, who is another employee.

### [`schema.sql`](freight-company/schema.sql): tables and constraints

I created the `employee`, `job` and `quote` tables from the given data model:

- **Primary keys** on every table
- **Foreign keys**:
  - quote → customer and employee
  - job → quote, the scheduling employee, the driver, and the truck/trailer combination
  - employee → employee (manager)
- **CHECK constraints**: `emp_role` must be `B`, `T`, `M` or `D`, and `job_payment_made` must be `Y` or `N`
- **UNIQUE constraints**: an employee's contact number and licence number

### [`sample_data.sql`](freight-company/sample_data.sql): test data

10 employees, 30 quotes and 20 jobs, loaded as one transaction. The data was generated with ChatGPT (allowed by the course for this task) from a prompt I wrote. The prompt sets what the data must cover, for example every employee role, customers with repeat quotes, quotes that never became jobs, and jobs priced above, below and equal to their quote, so that the queries below have meaningful cases to find.

### [`data_changes.sql`](freight-company/data_changes.sql): inserts, updates and deletes

- **Sequences** generate new employee, quote and job numbers
- Add a new dispatcher, then a quote and the job created from it, each step ending in `COMMIT`
- Reschedule the job and set its cost to 120% of the quote with a correlated subquery
- Cancel the job

Rows are found by business values (names, dates) through subqueries rather than hard-coded keys, so the script still works if the generated numbers change.

### [`schema_changes.sql`](freight-company/schema_changes.sql): changing the design

- **New columns on `quote`**: whether it became a job (`Y`/`N`, with a CHECK constraint) and the reason if not, then filled in for existing quotes
- **Truck servicing**: new `service` and `task` tables, joined by the `service_task` bridge table (a many-to-many relationship that also records the mechanic for each task)

### [`queries.sql`](freight-company/queries.sql): business analysis queries

| Query | Question it answers | SQL used |
|---|---|---|
| (a) | Which repeat customers have above-average quotes? | `JOIN`, `GROUP BY`, `HAVING` with a subquery, `NVL` to show a business name or a person's name |
| (b) | Who is each employee's manager, and how many jobs has each dispatcher scheduled? | Self-join on `employee`, `LEFT JOIN`, `CASE` |
| (c) | How much is each truck and trailer combination used? | `LEFT JOIN` to keep unused combinations, nested subquery for the average, `CASE` to label High Use / Standard Use / Never Used |

Some decisions I made in these queries:

- **(a) uses `HAVING`, not `WHERE`**, because both conditions depend on totals that only exist after grouping: the number of quotes and the average quote.
- **(b) uses `LEFT JOIN` for the manager**, so employees with no manager are kept and shown as "No Manager".
- **(c) counts `COUNT(j.job_no)`, not `COUNT(*)`**. With a `LEFT JOIN`, an unused combination still gives one row with `NULL` job columns. `COUNT(*)` would count that row as 1, but `COUNT(j.job_no)` correctly gives 0.

---

## Tools

Oracle SQL, SQL Developer, SQL Developer Data Modeler, draw.io
