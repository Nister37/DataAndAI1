
-- ************************************************************
-- Preparation
-- ************************************************************
-- _PG_CRE_ENTERPRISE_NL.sql
-- _PG_FILL_ENTERPRISE_NL.sql

-- ************************************************************
-- Introduction
-- ************************************************************
-- Single line statement
SELECT employee_id,last_name,first_name,department_id FROM employees WHERE department_id=7 ORDER BY employee_id;

-- Multi line statement(s)
SELECT  employee_id,last_name,first_name, department_id
FROM employees
WHERE department_id=7
ORDER BY employee_id;

SELECT  employee_id,
        last_name,
        first_name,
        department_id
FROM employees
WHERE department_id=7
ORDER BY employee_id;

-- Preferred use of comma, allows moving fields around easier
SELECT   employee_id
        ,last_name
        ,first_name
FROM employees
WHERE department_id=7
ORDER BY employee_id;

-- ************************************************************
-- FROM
-- ************************************************************
SELECT employee_id,last_name,first_name,department_id
FROM employees;
--WHERE department_id=7
--ORDER BY employee_id;

-- exception : SELECT without FROM 
-- see also https://modern-sql.com/use-case/select-without-from 
SELECT 2+2;
SELECT CURRENT_DATE;
SELECT 	CURRENT_DATE , 3*2;

-- ************************************************************
-- SELECT
-- ************************************************************
-- alle columns
SELECT * 
FROM departments;

-- specific columns
SELECT employee_id,last_name,first_name
FROM employees;

-- concatenate
SELECT employee_id
	,last_name || ' ' || first_name
FROM employees;

-- concatenate & column alias
SELECT employee_id
	,last_name || ' ' || first_name as full_name
FROM employees;

-- column alias (converted to lower case)
SELECT  employee_id EmployeeNumber,
        last_name AS familyName,   
        first_name AS FirstNamE
FROM employees;

-- column alias (use white spaces, character cases and other symbol)
SELECT  employee_id "Employee {number}"
		,last_name  AS "Employee {Family name}"
		,first_name AS "Employee {First name}"
FROM employees;

-- mathematical computations
SELECT employee_id, last_name, salary, salary*1.1  as raise
FROM employees;

-- functions
SELECT sum(salary)
FROM employees;

--
-- DISTINCT
--
-- Example 1
SELECT department_id 
FROM employees;

SELECT DISTINCT department_id 
FROM employees;

-- Example 2
SELECT department_id dept, salary 
FROM employees; 

SELECT DISTINCT department_id dept, salary 
FROM employees; 

-- ************************************************************
-- WHERE
-- ************************************************************
--
-- Comparators
--
-- Example 1
SELECT employee_id,last_name,first_name,department_id
FROM employees
WHERE department_id=3;

-- Example 2
SELECT employee_id,last_name,first_name,birth_date 
FROM employees
WHERE birth_date < '31-12-1980';

SELECT employee_id,last_name,first_name,birth_date 
FROM employees 
WHERE birth_date='20-jun-1981';

--
-- BETWEEN...AND
--
-- Example 1
SELECT employee_id,last_name,first_name,salary
FROM employees
WHERE salary BETWEEN 25000 AND 40000;

SELECT employee_id,last_name,first_name,salary
FROM employees 
WHERE salary>=25000 AND salary<=40000;

-- Example 2
SELECT employee_id,last_name,first_name,birth_date 
FROM employees 
WHERE birth_date BETWEEN '1-JAN-1980' AND '31-DEC-1989'; 

-- Example 3
SELECT employee_id,last_name,first_name
FROM employees 
WHERE last_name BETWEEN 'A' AND 'K';

-- 
-- Upper/Lowercase
-- 
SELECT employee_id, first_name FROM employees;


SELECT employee_id, INITCAP(first_name) FROM employees;

SELECT employee_id FROM employees WHERE first_name='WILLEM';
SELECT employee_id FROM employees WHERE first_name='Willem';
SELECT employee_id FROM employees WHERE UPPER(first_name)='WILLEM';
SELECT employee_id FROM employees WHERE LOWER(first_name)='willem';
SELECT employee_id FROM employees WHERE INITCAP(first_name)='Willem';

-- some other examples with operators
SELECT employee_id,first_name FROM employees WHERE first_name<>'Willem';
SELECT employee_id,first_name FROM employees WHERE first_name!='Willem';
SELECT employee_id,first_name FROM employees WHERE NOT (first_name='Willem');

--
-- LIKE
--
SELECT employee_id,last_name
FROM employees
WHERE LOWER(last_name) LIKE '%m%';

SELECT employee_id,last_name
FROM employees 
WHERE UPPER(last_name) LIKE '%M%';

--
-- AND OR NOT
--
SELECT 
		employee_id 
	    , salary
	    , department_id
FROM employees
WHERE department_id=3 
	AND salary>30000;

SELECT employee_id, department_id, salary
FROM employees
WHERE NOT(department_id=3 AND salary>30000);

SELECT employee_id, department_id, salary
FROM employees
WHERE department_id=3 
OR salary>30000;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary>30000 AND department_id=1 OR department_id=3;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary>30000 AND (department_id=1 OR department_id=3);


--
-- IN
--
SELECT employee_id,first_name,salary
FROM employees 
WHERE salary=25000 
OR    salary=30000 
OR    salary=43000;

SELECT employee_id, first_name, salary 
FROM employees 
WHERE salary IN(25000 , 30000 ,43000); 

SELECT employee_id, first_name, salary 
FROM employees 
WHERE first_name IN('Suzan','Martina'); 

SELECT employee_id, first_name, birth_date
FROM employees 
WHERE birth_date IN ('10-NOV-1977','1-SEP-1965'); 

--
-- IS NULL en IS NOT NULL
--
SELECT employee_id, last_name, manager_id
FROM employees
WHERE manager_id IS NULL ;

SELECT employee_id, manager_id
	,UPPER(last_name) || ' ' || first_name as name
FROM employees
WHERE manager_id IS NOT NULL;


SELECT *
FROM tasks;

SELECT *
FROM tasks
WHERE hours IS NOT NULL;

SELECT *
FROM tasks
WHERE hours=NULL;        -- Nope!

SELECT *
FROM tasks
WHERE hours IS NOT NULL;

SELECT *
FROM tasks
WHERE hours!=NULL;       -- Nope!

SELECT *
FROM tasks
WHERE NOT hours=NULL;    -- Nope!

--
-- Quotes
--
SELECT  employee_id, last_name, salary, birth_date,
        manager_id "Manager"
FROM    employees
WHERE   salary < 30000
AND     last_name = 'Muiden'
AND     birth_date < '31-JAN-2000';

-- ************************************************************
-- ORDER BY
-- ************************************************************
SELECT * FROM departments ORDER BY department_id ASC;

SELECT * FROM departments ORDER BY department_id DESC;

SELECT employee_id, last_name, first_name, department_id
FROM employees
ORDER BY department_id, last_name;

SELECT employee_id ,last_name AS "a very very long columnname", first_name fname
		,department_id department
FROM employees
ORDER BY department DESC, "a very very long columnname" ASC;

SELECT employee_id
	,last_name 		AS  "a very long columnname"
	,first_name 	AS fname
	,department_id  AS department
FROM employees
ORDER BY 
	department DESC
	,"a very long columnname" ASC;


SELECT employee_id
	, last_name "a very long columnname"
	, first_name fname
	, department_id department
FROM employees
ORDER BY 4 DESC, 2 ASC;

--
-- ORDER BY en NULL
--
SELECT *
FROM tasks
ORDER BY hours ;

SELECT *
FROM tasks
ORDER BY hours NULLS FIRST;

-- ************************************************************
-- SELECT FETCH 
-- ************************************************************
-- ************************************************************
-- FETCH - NEXT
-- ************************************************************
SELECT last_name FROM employees ORDER BY last_name;
SELECT last_name FROM employees ORDER BY last_name FETCH NEXT 3 ROWS ONLY;

-- ************************************************************
-- FETCH - OFFSET
-- ************************************************************
SELECT last_name FROM employees ORDER BY last_name;
SELECT last_name FROM employees ORDER BY last_name OFFSET 3 ROWS;

-- Make sure to use ()   
SELECT last_name FROM employees ORDER BY last_name OFFSET (2*2) ROWS;


-- ************************************************************
-- FETCH - OFFSET - NEXT
-- ************************************************************
SELECT last_name FROM employees ORDER BY last_name OFFSET 3 ROWS FETCH NEXT 4 ROWS ONLY;

-- Pagination
SELECT last_name FROM employees ORDER BY last_name OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY;
SELECT last_name FROM employees ORDER BY last_name OFFSET 2 ROWS FETCH NEXT 2 ROWS ONLY;
SELECT last_name FROM employees ORDER BY last_name OFFSET 4 ROWS FETCH NEXT 2 ROWS ONLY;
SELECT last_name FROM employees ORDER BY last_name OFFSET 6 ROWS FETCH NEXT 2 ROWS ONLY;

-- ************************************************************
-- FETCH - WITH TIES
-- ************************************************************
SELECT last_name, salary FROM employees ORDER BY salary DESC;
SELECT last_name, salary FROM employees ORDER BY salary DESC FETCH NEXT 2 ROWS ONLY;
SELECT last_name, salary FROM employees ORDER BY salary DESC FETCH NEXT 2 ROWS WITH TIES;



SELECT last_name, salary FROM employees ORDER BY salary DESC, last_name ASC fetch next 6 rows with ties;

-- ************************************************************
-- FETCH - syntax
-- ************************************************************
SELECT last_name FROM employees ORDER BY last_name FETCH NEXT 1 ROWS ONLY;
SELECT last_name FROM employees ORDER BY last_name FETCH FIRST 1 ROW ONLY;
