--Ex01
SELECT salutation,last_name,first_name,street_address
FROM instructors
WHERE street_address='518 West 120th';

--Ex02??? bad direction of ordering
SELECT salutation, first_name, last_name
FROM students
WHERE last_name='Grant'
ORDER BY street_address, first_name;

--Ex03
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE salutation='Ms.' AND last_name='Allende' OR last_name='Grant'
ORDER BY last_name;

--Ex04
SELECT student_id, section_id, enroll_date, final_grade
FROM enrollments
WHERE NOT final_grade='0';

--Ex05
SELECT first_name "Name", street_address "Address", zip
FROM students
WHERE zip IN('10048','11102','11209');

--Ex06
SELECT student_id, first_name "first", last_name "last", zip
FROM students
WHERE (first_name='Yvonne' AND zip='11209') OR last_name='Zuckerberg';

--Ex07
SELECT description, prerequisite
FROM courses
WHERE prerequisite<122;

--Ex08
SELECT salutation, last_name "LAST NAME", first_name "FIRST NAME", phone
FROM instructors
WHERE NOT first_name='Schorin';

--Ex09
SELECT DISTINCT first_name, last_name
FROM students
WHERE zip = '10025'
ORDER BY student_id;
--The code doesn't execute because we're trying to sort based on the value which isn't selected.

--Ex10
SELECT description "desc", prerequisite "pre"
FROM courses
WHERE prerequisite IS NOT NULL
ORDER BY 1;
--OR
SELECT description "desc", prerequisite "pre"
FROM courses
WHERE prerequisite IS NOT NULL
ORDER BY "desc";

--Ex11
SELECT description, cost, prerequisite
FROM courses
WHERE cost=1195 AND prerequisite IN(20,25);

--Ex12
SELECT course_no, cost
FROM courses
WHERE cost
BETWEEN 1500 AND 1000;
--Yes, the command executed but it didn't return any rows because the BETWEEN arguments are in the wrong sequence.

--Ex13
SELECT description, prerequisite
FROM courses
WHERE prerequisite NOT >= 140;
--No, the command doesn't execute because the NOT keyword should be before the condition, not the operator.

--Ex14
SELECT description
FROM grade_types
WHERE description BETWEEN 'Midterm' AND 'Project';

--Ex15
SELECT city
FROM zipcodes
WHERE NOT state='NY';

--Ex16
SELECT student_id, last_name, zip
FROM students
WHERE zip BETWEEN '05000' AND '06825'
ORDER BY zip, last_name;

--Ex17
SELECT student_id, last_name, zip
FROM students
WHERE zip IN('06483','06605','06798','06820')
ORDER BY zip, last_name DESC;

--Ex18
SELECT student_id, first_name "first", last_name "last"
FROM students
WHERE first_name IN('Brian','Angel','Yvonne') OR last_name='Torres'
ORDER BY last_name, first_name;

--Ex19
SELECT student_id, first_name "first", last_name "last", registration_date "registration"
FROM students
WHERE registration_date<'03-02-2021';

--Ex20
SELECT letter_grade, grade_point, max_grade, min_grade
FROM grade_conversions
WHERE grade_point BETWEEN 3 AND 4;

--Ex21
SELECT course_no, description, prerequisite
FROM courses
WHERE course_no<100
ORDER BY prerequisite;