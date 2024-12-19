--Ex01
CREATE TABLE Students (
    student_id CHAR(10),
    name VARCHAR(50),
    street VARCHAR(100),
    nr NUMERIC(4),
    postalcode NUMERIC(4),
    city VARCHAR(30),
    birth_date DATE
);

--Ex02
CREATE TABLE Students (
      student_id CHAR(10) PRIMARY KEY,
      name VARCHAR(50),
      street VARCHAR(100),
      nr NUMERIC(4) CONSTRAINT ch_nr CHECK (nr>0),
      postalcode NUMERIC(4) CONSTRAINT ch_postalcode CHECK (postalcode BETWEEN 1000 AND 9999),
      city VARCHAR(30),
      birth_date DATE CONSTRAINT ch_birth_date CHECK (birth_date < CURRENT_DATE)
);

--Ex03
CREATE TABLE classes(
    class_id NUMERIC(4),
    building CHAR(2),
    floor CHAR(1),
    room_number NUMERIC(2)
);
DROP TABLE IF EXISTS classes;

--Ex04
CREATE TABLE classes(
    class_id NUMERIC(4) PRIMARY KEY,
    building CHAR(2) CONSTRAINT c_building CHECK(building IN('GR','PH','SW')),
    floor NUMERIC(1) CONSTRAINT c_floor CHECK(floor BETWEEN 0 AND 5),
    room_number NUMERIC(2) CONSTRAINT c_room_number CHECK(room_number >= 0)
);

--Ex05
CREATE TABLE student_classes(
    student_number CHAR(10),
    class_number NUMERIC(4)
);
DROP TABLE IF EXISTS students_classes;

--Ex06
CREATE TABLE student_classes(
    student_number CHAR(10) REFERENCES students(student_id) ON DELETE CASCADE,
    class_number NUMERIC(4) REFERENCES classes(class_id) ON DELETE RESTRICT ,
    CONSTRAINT pk_keys PRIMARY KEY(student_number,class_number)
);

INSERT INTO students
(student_id, name, street, nr, postalcode, city, birth_date)
VALUES
    ('100', 'Albert Einstein', 'Mercer Street', 112, 8540, '
Princeton, New Jersey', '1879-03-14');
INSERT INTO classes (class_id, building, floor, room_number)
VALUES (1, 'GR', '1', 13);
INSERT INTO student_classes (student_number, class_number)
VALUES (100, 1);