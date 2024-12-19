--*******************************
--DML: DATA MANIPULATION LANGUAGE
--*******************************



--INSERT
----------------------------
SELECT * FROM departments;

--SCENARIO A: List all attributes

INSERT INTO departments (department_id, department_name, 
						 manager_id, mgr_start_date)
VALUES (5, 'Sales','999444444',
        to_date('22-05-2024', 'DD-MM-YYYY'));


--SCENARIO A: If NO LISTING attributes > --respect the order!

INSERT INTO departments 
VALUES (6, 'Development', '999444444',
		to_date('22-05-2024', 'DD-MM-YYYY'));

--SCENARIO C: Can also list only some attributes
-- ALWAYS include the NOT NULL attributes!!!

-- ERROR: we had already added a department with primary key 5
INSERT INTO departments
(department_id, department_name)
VALUES  (5, 'Sales');

INSERT INTO departments
(department_id, department_name)
VALUES  (99, 'Sales');



--Adding multiple rows at once

INSERT INTO departments (	department_id,  	department_name,
                             manager_id,  	mgr_start_date)
VALUES
    (12, 	'Sales',    '999444444',	to_date('22-05-2024', 'DD-MM-YYYY')),
    (13, 	'HR',       '999555555',	to_date('23-05-2024', 'DD-MM-YYYY')),
    (14, 	'AfterCare','999666666',	to_date('24-05-2024', 'DD-MM-YYYY'));



--Select *
SELECT * FROM departments
ORDER BY department_id;



--UPDATE - modifying EXISTING rows/records/tuples
------------------------------------------------------

--Update using 1 table
----------------------------------

SELECT * FROM departments
ORDER BY department_id;



--Changing the content of a row (!)
UPDATE departments
SET mgr_start_date = now()
WHERE department_id >8 ;


SELECT * FROM departments
ORDER BY department_id;



--Change contents of multiple rows simultaneously
UPDATE departments
SET mgr_start_date = now()
WHERE department_id > 8;

--For all rows for which the condition is true, the update is performed
SELECT * FROM departments
ORDER BY department_id;



--Update with 2 tables ------------------------
-- Make an update where dept_id > 8 and parkingspot = 3 (is in employees table!)

SELECT * FROM employees;

SELECT * FROM departments
ORDER BY department_id;



UPDATE departments d
SET mgr_start_date = current_date - interval '1 day'
FROM employees e
WHERE d.manager_id = e.employee_id
AND d.department_id > 8
AND e.parking_spot = 3;

--This does not work with an ON clause (!!!)

SELECT * FROM departments
ORDER BY department_id;



--Update with 3 tables -----------------------
--Update on manager_start date where department_id is
--greater than 7 and with the manager who has a relationship 'SON'.

SELECT * FROM departments
ORDER BY department_id;

SELECT *
FROM family_members;
--but you have to go through departments, to employees and then to family_members so 3 tables!

UPDATE departments d
SET mgr_start_date = current_date - interval '2 day'
FROM employees e
JOIN family_members fm ON e.employee_id = fm.employee_id
WHERE d.manager_id = e.employee_id
AND d.department_id > 7
AND fm.relationship = 'SON';
--only the join clauses of the updated table are now included in the where

SELECT * FROM departments
ORDER BY department_id;



--DELETE - delete 1 or more records.
------------------------------------------------

DELETE FROM departments
WHERE department_id = 5;

DELETE FROM departments
WHERE department_id IN (10, 11, 12, 13, 14, 99);

--All rows that meet the condition are removed



--Delete using multiple tables ---------------------------------------------
--Suppose you want to delete departments for which employee Susan works
--For which department does Susan work?

SELECT department_id
FROM employees
WHERE lower(first_name) = 'suzan';

--If you look it up first, you can try this:
DELETE FROM departments
WHERE department_id = 3;
--GIVES ERROR!! Referenced rows!



--Or you can try it in 1 instruction
--The dependent rows in table employees are not deleted.
DELETE FROM departments d
USING employees e
WHERE d.department_id = e.department_id
AND lower(first_name) = 'suzan';

--A DEPARTMENT CAN BE DELETED ONLY IF THERE ARE NO LONGER ANY EMPLOYEES WORKING FOR IT!



--********************
--GO TO SLIDE 24 !!!
--********************




--**************************************************
--TRUNCATE table - completely empty a table!
--**************************************************



-- **************************************
-- DROP Tables
-- **************************************

--Dropping table that exists
DROP TABLE projects;

--Projects has dependencies!


--Dropping a table that does not exist = error message
DROP TABLE consumer;


--Dropping non-existent table with addition IF EXISTS = nothing removed but successful query
DROP TABLE IF EXISTS consumer;

--Dropping a table that exists with CASCADE
DROP TABLE departments CASCADE;


--Dropping table without CASCADE
DROP TABLE IF EXISTS employees;


--Drop All tables
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS tasks CASCADE;
DROP TABLE IF EXISTS family_members CASCADE;




--*******************************************
--ALTER TABLE
--*******************************************

-- Since tables were deleted in previous section,
-- it is appropriate to completely recreate the database via following scripts:
--
-- _pg_CRE_ENTERPRISE_EN.sql
-- _pg_FILL_ENTERPRISE_EN.sql

-- ADD/REMOVE columns to/from a table
--------------------------------------------------
-- ADD 1 column
ALTER TABLE employees
    ADD COLUMN food_allergy VARCHAR(30);
-- REMOVE 1 COLUMN
ALTER TABLE employees
    DROP COLUMN food_allergy;

-- ADD multiple columns
ALTER TABLE employees
    ADD COLUMN food_allergy VARCHAR(30),
    ADD COLUMN diet VARCHAR(30);

-- REMOVE multiple columns
ALTER TABLE employees
    DROP food_allergy,
    DROP diet;

--Add 1 column with constraint
ALTER TABLE employees
    ADD COLUMN food_allergy VARCHAR(30)
        CONSTRAINT ch_emp2_food_all
            CHECK(food_allergy = UPPER(food_allergy));

--Delete 1 column and constraint separately
ALTER TABLE employees
    DROP CONSTRAINT IF EXISTS ch_emp2_food_all,
    DROP COLUMN IF EXISTS food_allergy CASCADE;

--slide 48
ALTER TABLE employees
    ALTER COLUMN parking_spot
        SET DATA TYPE NUMERIC(5);

ALTER TABLE employees
    ALTER COLUMN salary
        SET DEFAULT 0;

-----------------------EXTRA -----------------------------
-- EXAMPLE DEFAULT VALUES SET/DROP (after slide 50)
--Adjusting default values
--The default values can be found at the column level in menu

SELECT * FROM departments;

ALTER TABLE departments
    ALTER COLUMN mgr_start_date
        SET DEFAULT to_date('01-01-2021', 'DD-MM-YYYY');

ALTER TABLE departments
    ALTER COLUMN manager_id
        SET DEFAULT '999666666';

--Now what happens after this query?
INSERT INTO departments (department_id, department_name)
VALUES (8, 'IT');

SELECT * FROM departments;

--Dropping default values

ALTER TABLE departments
    ALTER COLUMN mgr_start_date
        DROP DEFAULT;

ALTER TABLE departments
    ALTER COLUMN manager_id
        DROP DEFAULT;

DELETE FROM departments
WHERE department_id = '8';
-----------------------EXTRA -----------------------------

--slide 50
--  Customize not null (drop or set)
-- Look at the properties in the table first

ALTER TABLE employees
    ALTER COLUMN last_name
        DROP NOT NULL;

ALTER TABLE employees
    ALTER COLUMN last_name
        SET NOT NULL;

--54
ALTER TABLE employees
    ALTER COLUMN parking_spot
        SET NOT NULL;

--You want to add a constraint to an existing table
-- E.g., to enforce that the last_name is always capitalized
-- BUT the current data may not yet meet the constraint...
ALTER TABLE employees
    ADD CONSTRAINT ch_emp_lastname
        CHECK(last_name=UPPER(last_name)) NOT VALID;

--Validate = activate the constraint
ALTER TABLE employees
    VALIDATE CONSTRAINT ch_emp_lastname;
--Error message because last_name now just start with a capital letter
-- First modify, then validate constraint.

-----------------------EXTRA -------------------------------
--RENAME
------------------------------------
--Renaming a table
ALTER TABLE IF EXISTS departments
    RENAME TO department;

-- Back to the original name
ALTER TABLE IF EXISTS department
    RENAME TO departments;

--Renaming an attribute
ALTER TABLE IF EXISTS departments
    RENAME COLUMN department_id TO banana;

ALTER TABLE employees
    RENAME COLUMN department_id TO apple;


--Renaming a constraint
ALTER TABLE projects
    RENAME CONSTRAINT pk_projects TO pk_sleutel_projects;
-----------------------EXTRA -------------------------------

--56
ALTER TABLE employees
    DROP CONSTRAINT ch_emp_lastname,
    ADD CONSTRAINT ch_emp_lastname
        CHECK(last_name=INITCAP(last_name)) ;




-- Refresh your Enterprise Database:
--
-- _pg_CRE_ENTERPRISE_EN.sql
-- _pg_FILL_ENTERPRISE_EN.sql

--Practical use of identity columns
-----------------------------------

CREATE TABLE employees3 (
    employee_id NUMERIC(9)
        CONSTRAINT pk_emp3 PRIMARY KEY ,
    last_name VARCHAR(25)
        CONSTRAINT nn_last_name NOT NULL
);


CREATE TABLE family_members3 (
     family_id NUMERIC(9)
         CONSTRAINT pk_fam_mem3 PRIMARY KEY ,
     name VARCHAR(50),
     employee_id NUMERIC(9)
         CONSTRAINT fk_fam3_emp_id REFERENCES employees3(employee_id)
);

DROP TABLE employees3;
DROP TABLE IF EXISTS employees3 CASCADE;

CREATE TABLE employees3 (
                            employee_id INTEGER
                                GENERATED ALWAYS AS IDENTITY
                                CONSTRAINT pk_emp3 PRIMARY KEY ,
                            last_name VARCHAR(25) CONSTRAINT nn_last_name NOT NULL
);

INSERT INTO employees3 (last_name) VALUES('Johnson');

INSERT INTO employees3 (employee_id, last_name) VALUES(100, 'Johnson');

SELECT * FROM employees3;

DROP TABLE IF EXISTS employees3 CASCADE;

CREATE TABLE employees3 (
                            employee_id INTEGER
                                GENERATED BY DEFAULT AS IDENTITY
                                CONSTRAINT pk_emp3 PRIMARY KEY ,
                            last_name VARCHAR(25) CONSTRAINT nn_last_name NOT NULL
);

INSERT INTO employees3 (last_name) VALUES('Johnson');

INSERT INTO employees3 (employee_id, last_name) VALUES(100, 'Johnson');

SELECT * FROM employees3;

INSERT INTO employees3 (employee_id, last_name) VALUES(NULL, 'Johnson');

DROP TABLE IF EXISTS family_members3;

CREATE TABLE family_members3 (
                                 family_id INTEGER
                                     GENERATED BY DEFAULT AS IDENTITY
                                     CONSTRAINT pk_fam_mem3 PRIMARY KEY ,
                                 name VARCHAR(50),
                                 employee_id INTEGER
                                     CONSTRAINT fk_fam3_emp_id REFERENCES employees3(employee_id)
);

--Attention to the data types! from NUMBER to INTEGER above
--change one column to an identity column
ALTER TABLE IF EXISTS family_members3
    ALTER COLUMN employee_id
        SET NOT NULL,
    ALTER COLUMN employee_id
        ADD GENERATED ALWAYS AS IDENTITY (START WITH 5);

--change the options of an identity column
ALTER TABLE IF EXISTS family_members3
    ALTER COLUMN employee_id
        SET GENERATED BY DEFAULT
        RESTART WITH 10;

--change an identity column to a normal column
-- Change the IDENTITY column
ALTER TABLE IF EXISTS family_members3
    ALTER COLUMN employee_id
        DROP IDENTITY IF EXISTS;
-- with IF EXISTS no modification
ALTER TABLE IF EXISTS family_members3
    ALTER COLUMN employee_id
        DROP IDENTITY;

