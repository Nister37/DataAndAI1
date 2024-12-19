--Ex01
SELECT *
FROM employees
WHERE salary>30000;

SELECT employee_id, SUM(hours)
FROM tasks
GROUP BY employee_id;

--Ex02/Ex03
SELECT hours
FROM tasks
WHERE employee_id='999444444';

SELECT COUNT(hours)
FROM tasks
WHERE employee_id='999444444';
--it counts the rows with specified value of employee_id

SELECT SUM(hours)
FROM tasks
WHERE employee_id='999444444';
--it sums all the rows with the same value of employee_id from the hours column.

--Ex04
SELECT COUNT(*)
FROM tasks;
--it counts all the rows

SELECT COUNT(hours)
FROM tasks;
--it counts all the rows with inputed value (skippes the ones with NULL val)

--Ex05
SELECT COUNT(department_id) "count_projects"
FROM projects;

--Ex06
SELECT TRUNC(AVG(hours),0) "number_of_hours"
FROM tasks
WHERE project_id=30;

--Ex07
SELECT COUNT(DISTINCT employee_id) "employee_with_kids"
FROM family_members
WHERE UPPER(relationship) IN ('SON','DAUGHTER');

--Ex08
SELECT MAX(hours) "highest amount hours"
FROM tasks
WHERE project_id=20;

--Ex09
SELECT MAX(birth_date) "youngest_child"
FROM family_members
WHERE employee_id='999111111' AND relationship IN('SON','DAUGHTER');

--Ex10
SELECT TRUNC(AVG(LENGTH(last_name))) "Average length last_name"
FROM employees;

--Ex11
SELECT p.project_id, COUNT(t.employee_id)
FROM projects p
JOIN tasks t ON p.project_id=t.project_id
GROUP BY p.project_id
ORDER BY p.project_id;

--Ex12
SELECT ROUND(AVG(avg_per_employee.avg)) "avg_number_emp/project"
FROM (
    SELECT employee_id,COUNT(project_id) avg
    FROM tasks t
    GROUP BY employee_id) AS avg_per_employee;

--Ex13???
SELECT e.*
FROM departments d
JOIN locations l ON d.department_id=l.department_id
JOIN employees e ON l.location=e.location
WHERE UPPER(e.province)='LI';

--Ex14
SELECT manager_id,COUNT(employee_id)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

--Ex15
