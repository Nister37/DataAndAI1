

--Ex02
INSERT INTO departments(department_id, department_name)
VALUES (15, 'Human Resources');

INSERT INTO employees(employee_id, last_name, first_name, department_id)
VALUES (999999999, 'Janssens', 'Jan', 15);
UPDATE departments SET manager_id=999999999 WHERE department_id=15;

INSERT INTO projects VALUES(40, 'Training', 'Antwerp', 15);

UPDATE employees
SET department_id=15, manager_id='999999999'
WHERE employee_id='999333333';
UPDATE employees
SET department_id=15, manager_id='999333333'
WHERE employee_id='999111111';

--UPDATE tasks HERE IT'S SUPPOSED TO USE INSERT INTO
--SET hours=20
--WHERE employee_id='999333333' AND project_id=15;
--UPDATE tasks
--SET hours=10
--WHERE employee_id='999111111' AND project_id=15;

--Ex03
ALTER TABLE departments
ALTER department_name TYPE VARCHAR(25);

--Ex04
ALTER TABLE projects
ADD CONSTRAINT c_project_name CHECK(project_name=UPPER(project_name)) NOT VALID;

UPDATE projects
SET project_name=UPPER(project_name);

ALTER TABLE projects
VALIDATE CONSTRAINT c_project_name;

--Ex05
ALTER TABLE employees
ADD email VARCHAR(20) DEFAULT 'unknown';

--Ex06 WHAT CONSTRAINT????

--Ex07
ALTER TABLE employees
DROP email;

--Ex08
select * from pg_constraint where contype = 'c';

ALTER TABLE projects
DROP CONSTRAINT c_project_name;

--Ex09
ALTER TABLE family_members
DROP CONSTRAINT c_gender,
ADD CONSTRAINT c_gender CHECK(LOWER(gender) IN('f','m'));

--Ex10
ALTER TABLE departments
ADD CONSTRAINT c_fk_employees FOREIGN KEY(manager_id) REFERENCES employees;

--Ex11
DROP TABLE departments, employees, family_members, locations, projects, tasks;

--Ex12
SELECT department_id AS max_department_id
FROM departments
ORDER BY department_id DESC
FETCH NEXT 1 ROW ONLY;

--Ex13 HUH?
ALTER TABLE departments
ADD COLUMN department_id_new SERIAL PRIMARY KEY;

--Ex14
