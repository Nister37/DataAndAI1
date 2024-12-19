--Ex01
SELECT birth_date
FROM employees
UNION ALL
SELECT birth_date
FROM family_members
ORDER BY birth_date;

--Ex02
SELECT birth_date
FROM employees
UNION ALL
SELECT birth_date
FROM family_members;

--Ex03
SELECT employee_id
FROM employees
EXCEPT
SELECT employee_id
FROM family_members;

--Ex04
SELECT employee_id
FROM employees
EXCEPT
SELECT manager_id
FROM employees;

--Ex05
SELECT employee_id, name, relationship,
CASE
   WHEN EXTRACT(YEAR FROM AGE(birth_date, current_date)) >= 18 THEN 'adult'
   ELSE 'child'
END age_category
FROM family_members;

--Ex06
SELECT
    CASE
        WHEN infix IS NOT NULL THEN
            first_name || '/' || COALESCE(REPLACE(infix,' ','/'), '/') || '/' || last_name
        ELSE first_name || '/' || COALESCE(REPLACE(infix,' ','/'), '') || last_name
END full_name
FROM employees;

--Ex07 IDK :/
--a
SELECT t.employee_id, e.first_name, e.birth_date
FROM tasks t
INNER JOIN employees e ON t.employee_id = e.employee_id;
