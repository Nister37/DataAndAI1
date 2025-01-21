--Ex01
ALTER TABLE grades
ALTER COLUMN numeric_grade SET DEFAULT 0;

--Ex02
ALTER TABLE grade_conversions
ALTER COLUMN grade_point SET DEFAULT 0;

--Ex03
--a
ALTER TABLE enrollments
ADD CONSTRAINT ck_final_grade CHECK ( final_grade BETWEEN 0 AND 100) NOT VALID;
--b
UPDATE enrollments
SET final_grade=0 WHERE final_grade NOT BETWEEN 0 AND 100;
--c
ALTER TABLE enrollments
VALIDATE CONSTRAINT ck_final_grade;
--d
ALTER TABLE courses
ADD CONSTRAINT ck_cost CHECK(cost <= 2000);

ALTER TABLE students
DROP CONSTRAINT ch_salutation_stud;

--Ex04
ALTER TABLE students
    ADD CONSTRAINT ch_salutation_stud
        CHECK(salutation IN ('Rev','Ms.','Dr.','Mr.'));

ALTER TABLE instructors
    ADD CONSTRAINT ch_salutation_instr
        CHECK(salutation IN ('Rev','Ms.','Dr.','Mr.')) NOT VALID;

SELECT * from instructors where salutation NOT IN ('Rev','Ms.','Dr.','Mr.');
UPDATE instructors
SET salutation = 'TEST'
where salutation = 'Hon';

--Ex05
ALTER TABLE sections
ADD CONSTRAINT ch_capacity CHECK ( capacity BETWEEN 10 AND 25 AND capacity%5=0) NOT VALID;
--test
UPDATE sections
SET capacity=15
WHERE section_id=80;

--Ex06
ALTER TABLE students
ADD COLUMN email VARCHAR(30);

--Ex07
ALTER TABLE sections
DROP CONSTRAINT sect_inst_fk;

ALTER TABLE sections
ADD CONSTRAINT sect_inst_fk
FOREIGN KEY (instructor_id) REFERENCES instructors ON DELETE SET NULL;

--Ex08
ALTER TABLE enrollments
DROP CONSTRAINT enr_stu_fk;

ALTER TABLE enrollments
ADD CONSTRAINT enr_stu_fk FOREIGN KEY (student_id) REFERENCES students ON DELETE CASCADE;
--test
DELETE FROM students where student_id = 139;

--Ex09