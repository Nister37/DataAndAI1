--****************
--PART 1: INDEXES
--****************

--Creation of an index on the attribute salary
CREATE INDEX ind_salary ON employees(salary);

--IDs of rows
SELECT employee_id, last_name, salary, ctid
FROM employees;
--CTID indicates the location of the row on the disk!

SELECT *
FROM employees
WHERE salary = 25000;

--Overview of all indexes in the current DB
SELECT * FROM pg_indexes WHERE tablename = 'employees';

--For each PK of a table, an index is automatically created

--Slide 20
--Regular index
CREATE INDEX ind_emp_department ON employees(department_id);
DROP INDEX ind_emp_department;

--Unique index
CREATE UNIQUE INDEX ind_dep_name ON departments(department_name);
DROP INDEX ind_dep_name;

--Composite regular index
CREATE INDEX ind_emp_sal_dep ON
employees(salary,department_id);
DROP INDEX ind_emp_sal_dep;

--Slide 22
--Deleting indexes
DROP INDEX --index name

--deleting PK indexes cannot be done with DROP INDEX
DROP INDEX pk_employees;
--ERROR MESSAGE

--slide 24
--Analyzing a query

--Searching on a composite index
SELECT * FROM employees
WHERE salary=43000 AND department_id=3;

--Analyzing the query
EXPLAIN ANALYZE
SELECT * FROM employees
WHERE salary=43000 AND department_id=3;

--slide 25
--Disallowing sequential scan!
SET enable_seqscan TO OFF;
SET enable_seqscan TO ON;

--Scan on index now > planning time low but execution time high
EXPLAIN ANALYZE
SELECT * FROM employees
WHERE salary=43000 AND department_id=3;

--Running the query multiple times > reduction in execution time

--****************************************
--PART 2: CORRELATED SUBQUERIES (slide 29)
--****************************************

--Overview of salary per employee and department
--where they work
SELECT department_id, employee_id, salary
FROM employees
ORDER BY department_id, salary DESC;

--Solution with a regular subquery
--step 1: determine max salary per department
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

--step 2: regular subquery
SELECT department_id, employee_id, salary
FROM employees
WHERE (department_id, salary) IN
( SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id)
ORDER BY department_id;

--Solution 2: correlated subquery
SELECT department_id, employee_id, salary
FROM employees e
WHERE salary =
( SELECT MAX(salary)
FROM employees
WHERE department_id =
e.department_id)
ORDER BY department_id;

--Correlated query - main query
SELECT department_id, employee_id, salary
FROM employees e
WHERE employee_id = '999444444'
ORDER BY department_id, salary DESC;

--Correlated query - inner query
SELECT MAX(salary)
FROM employees
WHERE department_id = 7;

--Slide 43
--Exercise 2
--Who earns MORE than the AVERAGE of their department?
SELECT department_id, employee_id, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
FROM employees
GROUP BY department_id);
--Result of the inner query obviously yields
--more than 1 row.. This is a problem!

--Regular subquery - adding ANY to the query
SELECT department_id, employee_id, salary
FROM employees
WHERE salary > ANY (SELECT AVG(salary)
FROM employees
GROUP BY department_id);

--Not entirely correct because employee 1 doesn't earn MORE than the average,
--he's just alone.

--Slide 45
--Correlated subquery - earning more than the department's average
SELECT department_id, employee_id, salary
FROM employees e
WHERE salary > (SELECT AVG(salary)
FROM employees
WHERE department_id = e.department_id);

--Note regarding performance!
EXPLAIN
SELECT department_id, employee_id, salary
FROM employees e
WHERE salary > (SELECT AVG(salary)
FROM employees
WHERE department_id = e.department_id);

EXPLAIN
SELECT e.department_id, e.employee_id, e.salary
FROM employees e
JOIN
( SELECT department_id, AVG(salary) avgsal
FROM employees
GROUP BY department_id ) as avsal
ON (e.department_id = avsal.department_id)
WHERE e.salary > avsal.avgsal;

--SUBQUERIES WITH EXISTS
--Slide 50
--Subqueries using [NOT] EXISTS
--Example on exists - employees who have family members?
SELECT employee_id, last_name
FROM employees e
WHERE EXISTS (
SELECT '*'
FROM family_members
WHERE employee_id = e.employee_id);

SELECT *
FROM family_members;

--NOT EXISTS - Employees who have no family members
SELECT employee_id, last_name
FROM employees e
WHERE NOT EXISTS (
SELECT 'x'
FROM family_members
WHERE employee_id = e.employee_id);

--Opposite of the previous query of course

-- slide 53
--Employees and managers using subquery with NOT IN
SELECT employee_id, last_name, department_id
FROM employees
WHERE employee_id NOT IN (
SELECT manager_id
FROM employees);

--Empty result!
--Why? Consequence of a [null] value in the manager column
--How can we fix this?

--slide 54
-- Overview of employees and their manager
SELECT employee_id, manager_id
FROM employees
ORDER BY manager_id NULLS FIRST;

--slide 55
--Solution: correlated subquery with NOT EXISTS
SELECT employee_id, last_name, department_id
FROM employees e
WHERE NOT EXISTS (
SELECT 'x' --doesn't matter as we only want TRUE or FALSE
FROM employees
WHERE manager_id = e.employee_id);

--slide 56
--Another solution using COALESCE
SELECT employee_id,last_name,department_id
FROM employees
WHERE employee_id NOT IN (
SELECT COALESCE(manager_id,'000000000')
FROM employees);
--yields an identical result!

--*************************************
--PART 3: DML with Subqueries - slide 58
--*************************************

--INSERT with Subquery
--Creation of a table ARCHIVE
CREATE TABLE archive (
department_id NUMERIC(2)
CONSTRAINT pk_archive PRIMARY KEY,
department_name VARCHAR(20)
CONSTRAINT nn_deptname NOT NULL,
manager_id CHAR(9),
mgr_start_date DATE
);

SELECT * FROM archive;

--Copying all rows from table departments
--to table archive
INSERT INTO archive
SELECT * FROM departments;

SELECT * FROM archive;

--Deleting all records from the archive table
DELETE FROM archive;

--Verifying if all records were indeed cleaned up
SELECT * FROM archive;

--A view of what is currently in the departments table
SELECT * FROM departments
ORDER BY department_id;

--Adding a few rows and columns into the empty archive table
INSERT INTO archive(department_id, department_name)
SELECT department_id, department_name
FROM departments
WHERE department_id < 4;



--Verification which records are in table archive
SELECT * FROM archive
ORDER BY department_id;



--Delete all records from the archive table
DELETE FROM archive;
--Verification that all records were indeed cleaned up
SELECT * FROM archive;


--Using functions/expressions in insert statement
INSERT INTO archive(department_id, department_name, manager_id)
SELECT  department_id ,
        UPPER(department_name),
        COALESCE(manager_id, 'none')
FROM departments;

SELECT * FROM departments;

--You did not see the operation of COALESCE in previous query
--This can be tested by running an UPDATE on departments
UPDATE departments
SET manager_id = null
WHERE manager_id = '999555555';


--Look at the results
SELECT * FROM archive
ORDER BY department_id;
--Remove all rows back
DELETE FROM archive;



-- slide 65
--INSERT: giving a value to one attribute via a nested select
INSERT INTO employees
(employee_id,last_name,first_name,salary,department_id)
VALUES
('99999999','Janssens','Jan', (SELECT ROUND(AVG(salary)) FROM employees), 1);



--How much does the new employee earn:
SELECT ROUND(AVG(salary)) FROM employees;



--Verify whether the record has been added
SELECT employee_id, last_name, first_name, salary, department_id FROM employees;
--Delete added record back
DELETE FROM employees WHERE employee_id = '99999999';



---------------------
--UPDATE met subquery
---------------------


--Update with subquery in SET statement
--Suppose you want to update for employee 999222222 and set the salary to the average of everyone
--Show the current value of salary for employee 999222222 = 25000
SELECT salary FROM employees
WHERE employee_id ='999222222';

--Let's first run the inner query to see the result = 31000
SELECT ROUND(AVG(salary) )
FROM 	employees
WHERE 	department_id = 3;

--slide 67
--Update-statement
UPDATE employees
SET salary =
	(SELECT AVG(salary)
	 FROM 	employees
	 WHERE 	department_id = 3)
WHERE employee_id ='999222222';


SELECT salary FROM employees
WHERE employee_id ='999222222';

--Reverse update
SELECT employee_id, last_name, first_name, salary, department_id FROM employees;
UPDATE employees SET salary = 25000 WHERE employee_id ='999222222';


--Employees in production department receive salary increase
--Who works for production department?
SELECT employee_id, last_name, department_id, salary
FROM employees
WHERE department_id IN (SELECT department_id
	FROM departments
	WHERE UPPER(department_name)='PRODUCTION');

-- slide 68
--Bijwerken met subquery in WHERE-clausule
UPDATE employees
SET salary = salary / 1.10
WHERE department_id IN (
	SELECT department_id
	FROM departments
	WHERE UPPER(department_name)='PRODUCTION');

--To reverse the operation you only need to change 1 character in previous query. Which one?


--Example 3 - employees receive average salary from their department
--Use a correlated subquery
UPDATE employees e
SET salary =
(SELECT AVG(salary)
 FROM employees c
 WHERE department_id = e.department_id);

SELECT department_id, salary FROM employees;



--Example 4 - Employees earning less than the average
--of the department in which they are employed will receive a 10% salary increase.

UPDATE employees e
SET salary = salary * 1.10
WHERE salary <
(SELECT AVG(salary) FROM employees
 WHERE department_id = e.department_id);

---------------------------------------
--DELETE using a subquery
---------------------------------------

--slide 70
--Example 1 - ordinary subquery
-- delete employees for which salary is less than average of dep 3.
DELETE FROM employees
WHERE salary <
(SELECT AVG(salary) FROM employees WHERE department_id = 3);



-- slide 71
--Example 2 - correlated subquery
--Delete employees for whom salary is less than the average of THEIR department
DELETE FROM employees e
WHERE salary <
(SELECT AVG(salary) FROM employees
 WHERE department_id = e.department_id);


