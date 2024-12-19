--Ex01 ???
SELECT DISTINCT employee_id
FROM family_members
WHERE relationship IN ('SON', 'DAUGHTER')
  AND date_part('year',(age(current_date,birth_date)))>18;

--Ex02
SELECT employee_id, last_name, location, age(birth_date)
FROM employees
WHERE location IN('Eindhoven','Maarssen')
  AND date_part('year',(age(current_date,birth_date)))>30;

--Ex03
SELECT employee_id, age(birth_date) "age partner"
FROM family_members
WHERE relationship='PARTNER'
  AND date_part('year',(age(current_date,birth_date))) BETWEEN 35 AND 45;

--Ex04
SELECT first_name, last_name, TO_CHAR(birth_date,'DD Month YYYY') "Date of birth", TO_CHAR(birth_date + INTERVAL '65 years','day DD month YYYY') "pension"
FROM employees;

--Ex05
--a
SELECT name, TO_CHAR(birth_date, 'day dd month YYYY') "born on"
FROM family_members
ORDER BY birth_date DESC;

--b
SELECT name, TO_CHAR(birth_date, 'FMday FMdd FMmonth YYYY') "born on"
FROM family_members
ORDER BY birth_date DESC;

--c
SELECT name, TO_CHAR(birth_date, 'FM TMday FMdd FMmonth YYYY') "born on"
FROM family_members
ORDER BY birth_date DESC;

--Ex06
--a
SELECT first_name || ' ' || last_name "naam"
FROM employees;

--b
SELECT CONCAT(first_name, ' ', last_name) "naam"
FROM employees;

--c???
SELECT CONCAT(
       first_name,
       LPAD(' ', 1, ' '),
       last_name
       ) "naam",
    LENGTH(first_name)
FROM employees;

--Ex07
--a
SELECT LOWER(street)
FROM employees;

--b
SELECT TRIM(LEADING 'z' FROM LOWER(street)) "new_address"
FROM employees;

--c
SELECT RPAD(LOWER(street), 30, '*')
FROM employees;

--Ex08
SELECT first_name, last_name
FROM employees
WHERE POSITION('o' IN first_name)>0 AND POSITION('o' IN last_name)>0;

--Ex09
SELECT last_name
FROM employees
WHERE POSITION('oo' IN last_name)>0;

--Ex10
SELECT REPLACE(street, 'e', 'o')
FROM employees;

--Ex11
SELECT LOWER(CONCAT(
    SUBSTRING(employees.first_name,0,4),
    '.',
    SUBSTRING(employees.last_name,0,4),
    '@',
    departments.department_name,
    '.be'))
FROM employees
JOIN departments ON employees.department_id = departments.department_id
ORDER BY employees.first_name ASC;