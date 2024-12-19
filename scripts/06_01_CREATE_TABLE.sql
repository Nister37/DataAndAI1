SELECT *
FROM information_schema.tables;

DROP table IF EXISTS tests;
CREATE TABLE IF NOT EXISTS tests (
                                     testname VARCHAR(20) CONSTRAINT pk_tests PRIMARY KEY,
                                     digit NUMERIC(4,1) NOT NULL
);

INSERT INTO tests (testname, digit) values ( 'TOM',999.6);

SELECT *
FROM tests;

--ex1
DROP TABLE IF EXISTS students;
CREATE TABLE IF NOT EXISTS students (
                                        student_id CHAR(10) CONSTRAINT pk_students PRIMARY KEY,
                                        name VARCHAR(50) NOT NULL,
                                        street VARCHAR(100) NOT NULL,
                                        nr NUMERIC(4) NOT NULL CONSTRAINT ch_students_nr CHECK (nr > 0),
                                        postalcode NUMERIC(4) NOT NULL CONSTRAINT ch_students_postalcode
                                            CHECK (postalcode BETWEEN 1000 AND 9999),
                                        city VARCHAR(30) NOT NULL,
                                        birth_date date NOT NULL CONSTRAINT ch_students_birth_date
                                            CHECK (birth_date < CURRENT_DATE));

CREATE TABLE IF NOT EXISTS classes(
                                      class_id NUMERIC(4) CONSTRAINT pk_classes PRIMARY KEY,
                                      building CHAR(2) NOT NULL CONSTRAINT ch_classes_building
                                          CHECK (building IN ('GR', 'PH', 'SW')),
                                      floor NUMERIC(1) NOT NULL
                                          CONSTRAINT ch_classes_floor
                                              CHECK (floor BETWEEN 0 AND 5),
                                      roomnumber NUMERIC(2) NOT NULL
                                          CONSTRAINT ch_classes_roomnumber
                                              CHECK (roomnumber > 0));


DROP TABLE IF EXISTS students_classes;
CREATE TABLE IF NOT EXISTS student_classes(
                                              studentnumber CHAR(10)
                                                  CONSTRAINT fk_students_classes_classnumber
                                                      REFERENCES students(student_id),
                                              classnumber NUMERIC(4)
                                                  CONSTRAINT fk_students_classes_classnumber
                                                      REFERENCES classes(class_id),
                                              CONSTRAINT pk_student_classes
                                                  PRIMARY KEY (studentnumber, classnumber));


INSERT INTO students
(student_id, name, street, nr, postalcode, city, birth_date)
VALUES
    ('100', 'Albert Einstein', 'Mercer Street', 112, 8540, '
Princeton, New Jersey', '1879-03-14');
INSERT INTO classes (class_id, building, floor, roomnumber)
VALUES (1, 'GR', '1', 13);
INSERT INTO students_classes (studentnumber, classnumber)
VALUES (100, 1);



CREATE TABLE IF NOT EXISTS departments(
                                          department_id NUMERIC(2)
                                              CONSTRAINT pk_departments PRIMARY KEY,
                                          department_name VARCHAR(20) NOT NULL,
                                          manager_id CHAR(9),
                                          mgr_start_date DATE);

CREATE TABLE IF NOT EXISTS employees(
                                        employee_id CHAR(9)
                                            CONSTRAINT pk_employees PRIMARY KEY,
                                        last_name VARCHAR(25) NOT NULL,
                                        first_name VARCHAR(25) NOT NULL,
                                        infix VARCHAR(25),
                                        street VARCHAR(50),
                                        city VARCHAR(25),
                                        province CHAR(2),
                                        postal_code VARCHAR(7),
                                        birth_date DATE,
                                        salary NUMERIC (7,2)
                                            CONSTRAINT ch_employees_salary
                                                CHECK (salary <= 85000),
                                        parking_spot NUMERIC(4)
                                            CONSTRAINT un_employees_parking
                                                UNIQUE,
                                        gender VARCHAR(50) NOT NULL,
                                        department_id NUMERIC(2)
                                            CONSTRAINT fk_employees_department_id
                                                REFERENCES departments(department_id),
                                        manager_id CHAR(9)
                                            CONSTRAINT fk_employees_manager_id
                                                REFERENCES employees(employee_id));

CREATE TABLE IF NOT EXISTS projects(
                                       project_id NUMERIC(2)
                                           CONSTRAINT pk_projects PRIMARY KEY,
                                       project_name VARCHAR(25) NOT NULL,
                                       location VARCHAR(25),
                                       department_id NUMERIC(2)
                                           CONSTRAINT fk_projects_department_id
                                               REFERENCES departments(department_id));

CREATE TABLE IF NOT EXISTS location(
                                       department_id NUMERIC(2)
                                           CONSTRAINT fk_location_department_id
                                               REFERENCES departments(department_id),
                                       location VARCHAR(20) NOT NULL,
                                       CONSTRAINT pk_location
                                           PRIMARY KEY(department_id, location));

CREATE TABLE IF NOT EXISTS tasks(
                                    employee_id CHAR(9)
                                        CONSTRAINT fk_tasks_employee_id
                                            REFERENCES employees(employee_id),
                                    project_id NUMERIC(2)
                                        CONSTRAINT fk_tasks_project_id
                                            REFERENCES projects(project_id),
                                    hours NUMERIC(5,1),
                                    CONSTRAINT pk_tasks
                                        PRIMARY KEY (employee_id, project_id));

CREATE TABLE IF NOT EXISTS family_members(
                                             employee_id CHAR(9)
                                                 CONSTRAINT fk_family_members_employee_id
                                                     REFERENCES employees(employee_id),
                                             name VARCHAR(50),
                                             gender VARCHAR(50) NOT NULL,
                                             birth_date DATE
                                                 CONSTRAINT ch_family_members_birth_date
                                                     CHECK (birth_date BETWEEN TO_DATE('20-03-1950', 'DD-MM-YYYY')
                                                         AND TO_DATE('01-01-2025', 'DD-MM-YYYY')),
                                             relationship VARCHAR(10) NOT NULL,
                                             CONSTRAINT pk_family_members_relationship
                                                 PRIMARY KEY (employee_id, name));