--Ex01
SELECT *
FROM projects;

--Ex02
SELECT project_name,department_id
FROM projects;

--Ex03a
SELECT 'project',project_name,'is handeled by',department_id
FROM projects;

--Ex03b
SELECT 'project' " ",project_name,'is handeled by' " ",department_id
FROM projects;

--Ex03c
SELECT 'project ' || project_name || 'is handeled by ' || department_id "projects with departaments"
FROM projects;

--Ex04
SELECT current_date - birth_date
FROM family_members;
--it shows a number of days from the birth date to current date

--Ex05
--SELECT employee_id, project_id, hours; There's no entity specified
--SELECT * FROM TASK; The entity is written with uppercase letters
--SELECT department_id, manager_id, start_date FROM departments; There's no column called start_date

--Ex06
SELECT location
FROM employees
WHERE INITCAP(location)=location;

--Ex07
SELECT department_id, location
FROM employees
WHERE INITCAP(location)=location;

--Ex08a
SELECT current_date;
--Ex08b
SELECT 150*0.85;
--Ex08c
SELECT CONCAT('SQL ','Data retrieval ','Chapter 3-4 ') AS "Best course";

--Ex09
SELECT employee_id employee, name "FIRST FAMILY MEMBER", relationship, gender
FROM family_members
WHERE employee_id='999111111';

--Ex10
SELECT *
FROM departments
WHERE department_id=3;

--Ex11
SELECT employee_id, last_name, location
FROM employees
WHERE LOWER(location)='maastricht';

--Ex12
SELECT employee_id, project_id, hours
FROM tasks
WHERE project_id=10 AND hours BETWEEN 20 AND 35;

--Ex13
SELECT project_id, hours
FROM tasks
WHERE hours<10 AND employee_id='999222222';

--Ex14
SELECT employee_id, last_name, province
FROM employees
WHERE province IN('NB','GR');

--Ex15
SELECT department_id, first_name
FROM employees
WHERE first_name IN('Suzan','Martina','Henk','Douglas')
ORDER BY department_id DESC, first_name;

--Ex16
SELECT last_name, salary, department_id
FROM employees
WHERE (department_id=7 AND salary<40000) OR employee_id='999666666';

--Ex17
SELECT last_name, department_id
FROM employees
WHERE province NOT IN('LI','NB');

--Ex18a
SELECT employee_id, project_id, hours
FROM tasks
ORDER BY hours NULLS FIRST;

--Ex18b
SELECT employee_id, project_id, hours
FROM tasks
ORDER BY hours DESC NULLS LAST;

--Ex19
SELECT last_name, location, salary
FROM employees
WHERE salary>30000 AND (LOWER(location) LIKE 'm%' OR LOWER(location) LIKE 's%');

--Ex20???
SELECT name
FROM family_members
WHERE birth_date BETWEEN '1988-01-01' AND '1988-12-31';

--Ex21
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary
FETCH NEXT 3 ROWS ONLY;

--Ex22
SELECT first_name, last_name, birth_date
FROM employees
ORDER BY birth_date
FETCH NEXT 3 ROWS ONLY;

--Ex23
SELECT employee_id, project_id, hours
FROM tasks
ORDER BY hours DESC NULLS LAST
OFFSET 3 ROWS;