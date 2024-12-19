--Ex01
SELECT s.last_name,
       s.zip,
       z.state,
       z.city
FROM students s
JOIN zipcodes z ON s.zip=z.zip
WHERE s.zip<'03000'
ORDER BY s.zip;

--Ex02
SELECT DISTINCT s.first_name,
       s.last_name,
       s.student_id,
       e.enroll_date
FROM students s
JOIN enrollments e ON s.student_id=e.student_id
WHERE e.enroll_date < to_date('03-02-2021','dd-mm-yyyy')
ORDER BY s.last_name;

--Ex03
SELECT c.course_no,
       c.description,
       s.section_no
FROM courses c
JOIN sections s ON c.course_no=s.course_no
WHERE prerequisite IS NULL
ORDER BY c.course_no, s.section_no;

--Ex04
SELECT e.student_id, c.course_no, to_char(e.enroll_date,'mm/dd/yyyy hh12:mi AM'), s.section_id
FROM enrollments e JOIN sections s
ON e.section_id=s.section_id JOIN courses c
ON s.course_no=c.course_no
WHERE c.description='Intro to Information Systems'
ORDER BY e.student_id;

--Ex05
SELECT s.student_id "Student ID", i.instructor_id "Instructor ID", s.zip "Student ZIP", i.zip "Instructor ZIP"
FROM students s INNER JOIN instructors i
ON s.zip=i.zip;

--Ex06
SELECT 	s.course_no course
     ,s.section_no section
     ,e.student_id student
FROM enrollments e
         JOIN sections s ON (e.section_id=s.section_id)
         JOIN instructors i ON (s.instructor_id=i.instructor_id)
         JOIN courses c ON  (c.course_no=s.course_no)
WHERE i.zip='10025'
  AND prerequisite IS NULL
ORDER BY 3;

--Ex07
SELECT CONCAT(i.first_name,' ',i.last_name) name,
       i.street_address,
       CONCAT(z.city,', ',i.zip) city_state_zip,
       se.start_date_time start_date,
       se.section_no
FROM zipcodes z
JOIN instructors i ON z.zip=i.zip
JOIN sections se ON i.instructor_id=se.instructor_id
WHERE to_char(se.start_date_time,'mm-yyyy')='04-2021'
ORDER BY name;

--Ex08
SELECT DISTINCT s.student_id,
       s.first_name,
       s.last_name
FROM enrollments e
JOIN students s ON e.student_id=s.student_id
JOIN zipcodes z ON s.zip=z.zip
WHERE e.enroll_date<current_date AND z.state='CT'
ORDER BY s.student_id;

--Ex09
SELECT CONCAT(INITCAP(s.first_name),' ',INITCAP(s.last_name)) name,
       g.section_id,
       CONCAT(g.grade_type_code,' ',g.grade_code_occurrence) evaluation_type,
       g.numeric_grade grade
FROM students s
JOIN grades g ON s.student_id=g.student_id
WHERE CONCAT(INITCAP(s.first_name),' ',INITCAP(s.last_name))='Daniel Wicelinski' AND g.section_id=87;

--Ex10
SELECT g.student_id,
    g.numeric_grade,
    gc.letter_grade
FROM sections se
JOIN grades g ON se.section_id=g.section_id
JOIN grade_conversions gc ON g.numeric_grade BETWEEN gc.min_grade AND gc.max_grade
WHERE se.course_no=420 AND g.grade_type_code='FI';

--Ex11
SELECT DISTINCT s.student_id,
       s.first_name,
       s.last_name,
       g.section_id,
       gtw.percent_of_final_grade pct,
       g.grade_type_code,
       g.numeric_grade
FROM students s
JOIN grades g ON s.student_id=g.student_id
JOIN grade_type_weights gtw ON (g.section_id=gtw.section_id AND g.grade_type_code=gtw.grade_type_code)
WHERE g.numeric_grade<=80 AND g.grade_type_code='PJ'
ORDER BY s.last_name;

--Ex12
SELECT LOWER(c.description) description,
       s.section_no,
       s.location,
       s.capacity
FROM courses c
JOIN sections s ON c.course_no=s.course_no
WHERE location='L211'
ORDER BY description DESC;

--Ex13
SELECT c.description,
       se.section_no,
       se.start_date_time
FROM courses c
JOIN sections se ON c.course_no=se.course_no
JOIN enrollments e ON se.section_id=e.section_id
JOIN students s ON e.student_id=s.student_id
WHERE CONCAT(INITCAP(s.first_name),' ',INITCAP(s.last_name))='Joseph German';

--Ex14
SELECT c.course_no,
       c.description,
       se.section_id
FROM courses c
JOIN sections se ON c.course_no=se.course_no
JOIN grade_type_weights gtw ON se.section_id=gtw.section_id
WHERE gtw.grade_type_code='PA' AND gtw.percent_of_final_grade>=25
ORDER BY c.course_no;

--Ex15
SELECT s.first_name,
       s.last_name,
       g.numeric_grade
FROM students s
JOIN grades g ON s.student_id=g.student_id
WHERE g.numeric_grade>=99 AND g.grade_type_code='PJ';

--Ex16
SELECT s.student_id,
       s.first_name,
       s.last_name,
       g.section_id,
       CONCAT(g.grade_type_code,' ',g.grade_code_occurrence) quiz,
       g.numeric_grade
FROM students s
JOIN grades g ON s.student_id=g.student_id
WHERE s.zip='10956' AND g.grade_type_code='QZ';

--Ex17
SELECT c.course_no,
       se.section_no,
       i.first_name,
       i.last_name
FROM courses c
JOIN sections se ON c.course_no=se.course_no
JOIN instructors i ON se.instructor_id=i.instructor_id
WHERE c.prerequisite=20
ORDER BY c.course_no;

--Ex18
--a
--bTODO

--Ex19
SELECT c.course_no,
       c.description,
       c.prerequisite,
       pre.description
FROM courses c
JOIN courses pre ON c.prerequisite=pre.course_no
WHERE c.prerequisite IS NOT NULL
ORDER BY c.course_no;

--Ex20
SELECT s.student_id,
       s.last_name,
       s.street_address
FROM students s
JOIN students sa ON s.street_address=sa.street_address AND s.zip=sa.zip
WHERE s.student_id<>sa.student_id
ORDER BY s.student_id;

--Ex21
SELECT DISTINCT i.first_name,
       i.last_name,
       i.zip
FROM instructors i
JOIN instructors ins ON i.zip=ins.zip
WHERE i.instructor_id<>ins.instructor_id
ORDER BY i.zip;

--Ex22
SELECT s.section_id,
       to_char(s.start_date_time,'dd-MON-yyyy hh24:mi') "time",
       s.location
FROM sections s
JOIN sections se ON s.location=se.location AND s.start_date_time=se.start_date_time
WHERE s.section_id<>se.section_id
ORDER BY s.start_date_time, s.location;

--Ex23
SELECT s1.student_id,
       s1.last_name,
       s1.first_name
FROM students s1
JOIN grades g1 ON s1.student_id=g1.student_id
JOIN grades g2 ON g2.section_id=g1.section_id AND g2.grade_type_code=g1.grade_type_code
JOIN students s2 ON g2.student_id=s2.student_id
WHERE g1.grade_type_code='FI'
  AND g1.section_id=95
  AND g1.numeric_grade<g2.numeric_grade
  AND CONCAT(UPPER(s2.first_name),' ',UPPER(s2.last_name))='MARIA MARTIN'
ORDER BY s1.student_id DESC;

--Ex24
SELECT DISTINCT g1.student_id,
       g1.numeric_grade,
       g2.numeric_grade
FROM grades g1
JOIN grades g2 ON g1.student_id=g2.student_id AND g1.section_id=g2.section_id
WHERE g1.grade_type_code='MT'
AND g2.grade_type_code='FI'
AND g1.section_id=99
AND g1.numeric_grade<g2.numeric_grade
ORDER BY g1.student_id;