CREATE TABLE departments(
    department_id NUMERIC(2) PRIMARY KEY,
    department_name VARCHAR(20) NOT NULL,
    manager_id CHAR(9),
    mgr_start_date DATE
);

CREATE TABLE employees(
    employee_id CHAR(9) PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    infix VARCHAR(25),
    street VARCHAR(50),
    city VARCHAR(25),
    province CHAR(2),
    postal_code VARCHAR(7),
    birth_date DATE,
    salary NUMERIC(5,2) CONSTRAINT c_salary CHECK(salary <= 85000),
    parking_spot NUMERIC(4) CONSTRAINT c_parking_spot CHECK(parking_spot <= 9999) UNIQUE,
    gender CHAR(1),
    department_id NUMERIC(2) REFERENCES departments(department_id),
    manager_id CHAR(9) REFERENCES employees(employee_id)
);

CREATE TABLE projects(
    project_id NUMERIC(2) PRIMARY KEY,
    project_name VARCHAR(25) NOT NULL,
    location VARCHAR(25),
    department_id NUMERIC(2) REFERENCES departments(department_id)
);

CREATE TABLE location(
    department_id NUMERIC(2) REFERENCES departments(department_id),
    location VARCHAR(20),
    CONSTRAINT pk_location PRIMARY KEY(department_id,location)
);

CREATE TABLE tasks(
      employee_id CHAR(9) REFERENCES employees(employee_id),
      project_id NUMERIC(2) REFERENCES projects(project_id),
      hours NUMERIC(5,1),
      CONSTRAINT pk_tasks PRIMARY KEY(employee_id,project_id)
);

CREATE TABLE family_members(
    employee_id CHAR(9) REFERENCES employees(employee_id),
    name VARCHAR(50),
    gender CHAR(1),
    birth_date DATE,
    relationship VARCHAR(10),
    CONSTRAINT pk PRIMARY KEY(employee_id, name)
);
