--Ex01
SELECT d.department_id
     ,department_name
     ,project_id
     ,project_name
     ,location
FROM departments d
INNER JOIN projects p ON d.department_id=p.department_id
ORDER BY department_id;

--Ex02???
SELECT e.department_id,
       e.manager_id,
       e.last_name,
       e.salary,
       e.parking_spot
FROM employees e;

--Ex03
SELECT p.project_name,
       p.location,
       CONCAT(e.first_name,' ',e.last_name) full_name,
       p.department_id
FROM projects p
INNER JOIN tasks t ON p.project_id=t.project_id
INNER JOIN employees e ON t.employee_id=e.employee_id
ORDER BY department_id;

--Ex04
SELECT p.project_name,
       p.location,
       CONCAT(e.first_name,' ',e.last_name) full_name,
       e.department_id "Departament of Employee",
       p.department_id "Departament supporting the project"
FROM projects p
         INNER JOIN tasks t ON p.project_id=t.project_id
         INNER JOIN employees e ON t.employee_id=e.employee_id
WHERE p.location='Eindhoven' OR p.department_id=3
ORDER BY p.department_id;

--Ex05
SELECT CONCAT(e.first_name,' ',e.last_name),
       f.name,
       f.gender,
       to_char(f.birth_date,'dd-mm-yyyy') "Date of Birth"
FROM employees e
INNER JOIN family_members f ON e.employee_id=f.employee_id
ORDER BY f.birth_date ASC;

--Ex06???
SELECT e.last_name,
       e.location,
       o.last_name,
       o.location
FROM employees e
JOIN employees o ON e.employee_id=o.employee_id
WHERE e.last_name='Jochems';