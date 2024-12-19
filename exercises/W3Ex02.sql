--Ex01
SELECT city, INITCAP(state) "state"
FROM zipcodes
WHERE to_number(zip,'99999')<5000 OR state='WV'
ORDER BY state, city;

--Ex02
SELECT RPAD(city,20,'.') "CITY"
FROM zipcodes
WHERE (UPPER(SUBSTRING(city,1,1)) BETWEEN 'A' AND 'M') AND
      UPPER(state)='CT';

--Ex03
SELECT last_name, POSITION('a' IN last_name) "Letter a"
FROM students
WHERE POSITION('a' IN last_name)>8;

--Ex04
SELECT student_id, last_name, created_date, CONCAT(CURRENT_DATE - created_date,' dagen geleden') created_date
FROM students
WHERE student_id<106;

--Ex05
SELECT DISTINCT section_id
FROM enrollments
WHERE created_date BETWEEN '2021-10-01' AND '2021-10-31';

--Ex06
SELECT DISTINCT cost, cost*1.5 "kost + 50%", ROUND(cost*1.5) "Kost + 50 met afonding"
FROM courses
WHERE cost <> 0;

--Ex07
SELECT last_name, registration_date, to_char(registration_date, 'DD-MM-YYYY'), to_char(registration_date, 'dy')
FROM students
WHERE student_id IN(123,161,190);

--Ex08
SELECT CONCAT(SUBSTRING(first_name,1,1),' ',last_name) Naam
FROM students
WHERE SUBSTRING(last_name,1,1)='E'
ORDER BY last_name;

--Ex09
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE first_name LIKE '%.%' AND salutation='Ms.'
ORDER BY LENGTH(last_name);

--Ex10
SELECT student_id, first_name voornaam, last_name achternaam, zip
FROM students
WHERE LOWER(first_name) LIKE '%y%' AND zip='10025' OR UPPER(SUBSTRING(last_name,1,1)) BETWEEN 'W' AND 'Z';

--Ex11
SELECT description, prerequisite
FROM courses
WHERE description LIKE 'Intro to%' AND prerequisite IS NULL;

--Ex12
SELECT LENGTH('I count this amount of letters') "Total letters";

--Ex13
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE salutation='Ms.' AND last_name IN('Allende','Grant')
ORDER BY LENGTH(last_name);

--Ex14
SELECT first_name, last_name
FROM instructors
WHERE SUBSTRING(last_name,2,1)='o';

--Ex15
SELECT CONCAT('Today it is ',RPAD(TO_CHAR(current_date,'dd/mm/yyyy'),14,'*')) "Which day today?";

--Ex16
SELECT CONCAT('Today it is ',RPAD(TO_CHAR(current_date,'FMDay'),10,'*'), ' the ',TO_CHAR(current_date,'ddTH')) "Which day is it?";

--Ex17
SELECT course_no, REPLACE(description,'Java','C#')
FROM courses
ORDER BY course_no;

--Ex18
SELECT student_id, section_id, grade_type_code, ROUND(numeric_grade/5) numeric_grade_op_20
FROM grades
WHERE grade_type_code='PA'
ORDER BY student_id;

--Ex19
SELECT EXTRACT(MONTH FROM age(current_date,'01-09-2024')) "Months passed AY"

--Ex20
SELECT section_id, TO_CHAR(start_date_time, 'dd/mm/yyyy day')
FROM sections
WHERE section_id BETWEEN 80 AND 89;

--Ex21
--a
SELECT student_id, section_id, TO_CHAR(enroll_date, 'dd month yyyy') entries
FROM enrollments
WHERE section_id=117;

--b
SELECT student_id, section_id, CONCAT('The ',
                                      TO_CHAR(enroll_date, 'ddth'),
                                      ' in the ',
                                      TO_CHAR(enroll_date, 'wwth'),
                                      ' of the year ',
                                      to_char(enroll_date, 'yyyy'))
FROM enrollments
WHERE section_id=117;