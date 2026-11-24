-- Schema changes for new business requirements.
-- (a) track whether each quote became a job, and why not
-- (b) record truck services: SERVICE, TASK and the SERVICE_TASK bridge table
--     (many-to-many between services and tasks, with the mechanic who did each task)

--4(a)
ALTER TABLE quote ADD (
    quote_status CHAR(1) DEFAULT 'N' NOT NULL,
    quote_reason VARCHAR2(110)
);


COMMENT ON COLUMN quote.quote_status IS
    'The status of current quote, flag whether has been assigned to a job';

COMMENT ON COLUMN quote.quote_reason IS
    'The reason why quote has not been assigned to a job before the preferred start date'
    ;

ALTER TABLE quote
    ADD CONSTRAINT chk_quote_status CHECK ( quote_status IN ( 'Y',
                                                              'N' ) );

UPDATE quote
   SET
    quote_status = 'Y'
 WHERE quote_no IN (
    SELECT quote_no
      FROM job
);

COMMIT;


desc quote;

SELECT quote_no,
       quote_status,
       quote_reason
  FROM quote
 ORDER BY quote_no;


--4(b)
DROP TABLE service_task CASCADE CONSTRAINTS PURGE;
DROP TABLE service CASCADE CONSTRAINTS PURGE;
DROP TABLE task CASCADE CONSTRAINTS PURGE;


CREATE TABLE service (
    service_no       NUMBER(5) NOT NULL,
    service_start_dt DATE NOT NULL,
    service_end_dt   DATE,
    truck_vin        CHAR(17) NOT NULL,
    CONSTRAINT service_pk PRIMARY KEY ( service_no )
);

COMMENT ON COLUMN service.service_no IS
    'service number';

COMMENT ON COLUMN service.service_start_dt IS
    'service start date and time';

COMMENT ON COLUMN service.service_end_dt IS
    'service end date and time';

COMMENT ON COLUMN service.truck_vin IS
    'truck vehicle identification number';

ALTER TABLE service
    ADD CONSTRAINT truck_service_fk FOREIGN KEY ( truck_vin )
        REFERENCES truck ( truck_vin );


CREATE TABLE task (
    task_no          NUMBER(2) NOT NULL,
    task_description VARCHAR2(200) NOT NULL,
    CONSTRAINT task_pk PRIMARY KEY ( task_no )
);

COMMENT ON COLUMN task.task_no IS
    'task number';

COMMENT ON COLUMN task.task_description IS
    'task description';


CREATE TABLE service_task (
    service_no        NUMBER(5) NOT NULL,
    task_no           NUMBER(2) NOT NULL,
    mechanic_emp_no   NUMBER(3) NOT NULL,
    service_text_note VARCHAR2(200) NOT NULL,
    CONSTRAINT service_task_pk PRIMARY KEY ( service_no,
                                             task_no )
);

COMMENT ON COLUMN service_task.service_no IS
    'service number';

COMMENT ON COLUMN service_task.task_no IS
    'task number';

COMMENT ON COLUMN service_task.mechanic_emp_no IS
    'mechanic employee number';

COMMENT ON COLUMN service_task.service_text_note IS
    'service free text note';

ALTER TABLE service_task
    ADD CONSTRAINT service_service_task_fk FOREIGN KEY ( service_no )
        REFERENCES service ( service_no );

ALTER TABLE service_task
    ADD CONSTRAINT task_service_task_fk FOREIGN KEY ( task_no )
        REFERENCES task ( task_no );

ALTER TABLE service_task
    ADD CONSTRAINT employee_service_task_fk FOREIGN KEY ( mechanic_emp_no )
        REFERENCES employee ( emp_no );


desc service;

desc task;

desc service_task;

SELECT *
  FROM service;

SELECT *
  FROM task;

SELECT *
  FROM service_task;
