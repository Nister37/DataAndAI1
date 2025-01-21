--Ex01
--a
SELECT COUNT(t.project_id), p.project_id
FROM projects p
JOIN tasks t ON t.project_id = p.project_id
WHERE t.hours IS NOT NULL
GROUP BY p.project_id
HAVING COUNT(t.project_id) > 2
ORDER BY p.project_id;

--b
SELECT p.project_id, p.project_name
FROM projects p
         JOIN tasks t ON t.project_id = p.project_id
WHERE t.hours IS NOT NULL
GROUP BY p.project_id
HAVING COUNT(t.project_id) > 2
ORDER BY p.project_id;

--c without join
SELECT result1.project_id, p.project_name
FROM(
    SELECT COUNT(project_id), project_id
    FROM tasks
    WHERE hours IS NOT NULL
    GROUP BY project_id
    HAVING COUNT(project_id) > 2
    ORDER BY project_id) AS result1, projects p
WHERE result1.project_id = p.project_id;

--Ex02
--a
SELECT DISTINCT t.employee_id
FROM (
    SELECT project_id
    FROM projects
    WHERE initcap(location) = 'Eindhoven') AS eindhoven, tasks t
WHERE t.project_id = eindhoven.project_id

--b subqueries
SELECT emp.employee_id, e.last_name
FROM (
    SELECT DISTINCT t.employee_id
    FROM (
             SELECT project_id
             FROM projects
             WHERE initcap(location) = 'Eindhoven') AS eindhoven, tasks t
    WHERE t.project_id = eindhoven.project_id) AS emp, employees e
WHERE e.employee_id = emp.employee_id;

--b joins
SELECT DISTINCT e.employee_id, e.last_name
FROM projects p
JOIN tasks t ON t.project_id = p.project_id
JOIN employees e ON e.employee_id = t.employee_id
WHERE initcap(p.location) = 'Eindhoven';

--Ex03
--a only subqueries
SELECT first_name, last_name
FROM (SELECT employee_id
      FROM (SELECT project_id
            FROM projects
            WHERE upper(project_name) = 'ORDERMANAGEMENT') AS ordermanagement,
           tasks
      WHERE hours > 10
        AND ordermanagement.project_id = tasks.project_id) AS emp, employees
WHERE emp.employee_id = employees.employee_id;

--b subqueries + joins
SELECT e.first_name, e.last_name
FROM (
    SELECT employee_id
    FROM projects p
    JOIN tasks t ON p.project_id = t.project_id
    WHERE upper(project_name) = 'ORDERMANAGEMENT' AND hours > 10) AS emp, employees e
WHERE emp.employee_id = e.employee_id;

--Ex04
SELECT e.employee_id, last_name
FROM (
    SELECT employee_id
    FROM family_members
    WHERE relationship IN ('DAUGHTER', 'SON')
    GROUP BY employee_id
    HAVING COUNT(employee_id) > 1) AS emp, employees e
WHERE emp.employee_id = e.employee_id
ORDER BY last_name DESC;

--Ex05
SELECT department_id, department_name
FROM departments
WHERE department_id = ANY(
    SELECT department_id sum
    FROM employees
    GROUP BY department_id
    ORDER BY sum DESC
    FETCH NEXT 1 ROW ONLY);

--Ex06 ???
SELECT *
FROM EMPLOYEES
WHERE employee_id NOT IN (SELECT manager_id
                          FROM EMPLOYEES);

--Ex07
SELECT family.employee_id, e.last_name, family.count children
FROM (
    SELECT employee_id, COUNT(*)
    FROM family_members
    WHERE relationship IN ('DAUGHTER', 'SON')
    GROUP BY employee_id) AS family, employees e
WHERE upper(e.last_name)<>'BOCK' AND e.employee_id=family.employee_id;

--Ex08
CREATE OR REPLACE VIEW v_emp_sal_dep AS
    SELECT d.department_id, sal.sum "Total salary cost per department"
    FROM (SELECT SUM(e.salary) sum, e.department_id
          FROM employees e
          GROUP BY department_id) AS sal, departments d
    WHERE sal.department_id=d.department_id;

--Ex09
CREATE OR REPLACE VIEW v_emp_child AS
    SELECT e.employee_id, CONCAT(e.first_name,' ',e.last_name) name_emp, e.birth_date, fm.name
    FROM employees e
    JOIN family_members fm ON e.employee_id = fm.employee_id
    WHERE LOWER(fm.relationship) IN ('daughter','son')
    ORDER BY 1,4;

--Ex10
--a
CREATE OR REPLACE VIEW v_emp_salary AS
    SELECT employee_id, first_name, last_name, salary
    FROM employees
    ORDER BY salary DESC;

--b
CREATE OR REPLACE VIEW v_emp_salary AS
    SELECT employee_id, first_name, last_name, salary, department_id
    FROM employees
    ORDER BY salary DESC;

--Ex11
--a
CREATE OR REPLACE VIEW v_department AS
    SELECT * FROM departments;

--b
ALTER TABLE departments
ADD COLUMN dept_telnr VARCHAR(9);

--c
SELECT view_definition
FROM INFORMATION_SCHEMA.views
WHERE table_name='v_department';

--d
CREATE OR REPLACE VIEW v_department AS
SELECT * FROM departments;

--e
DROP VIEW v_department;

ALTER TABLE departments
DROP COLUMN dept_telnr;

--f
CREATE OR REPLACE VIEW v_department AS
SELECT department_id,department_name,manager_id,mgr_start_date FROM departments;

--Ex12
CREATE OR REPLACE VIEW v_emp_salary AS
    SELECT employee_id, first_name, last_name, salary, department_id
    FROM employees
    WHERE department_id=7
    ORDER BY salary DESC;

--Ex13 idk
--Ex14
INSERT INTO v_emp_salary
VALUES('999999999','Jan','Janssens',35000,3);

--Ex15 not done!
CREATE OR REPLACE VIEW v_percentage_proportion AS
    SELECT employee_id, project_id
    FROM tasks;

SELECT *
FROM v_percentage_proportion;