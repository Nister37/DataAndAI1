--Ex01
--A
SELECT COUNT(student_id)
FROM enrollments;

--B
SELECT COUNT(DISTINCT section_id)
FROM enrollments;

--C
SELECT SUM(capacity), ROUND(AVG(capacity)), MIN(capacity), MAX(capacity)
FROM sections;

--Ex02
SELECT MAX(cost)
FROM courses;

--Ex03
SELECT MIN(registration_date), MAX(registration_date)
FROM students;

--Ex04
SELECT COUNT(*)
FROM courses
WHERE prerequisite IS NULL;

--Ex05
SELECT COUNT(DISTINCT student_id)
FROM enrollments;

--Ex06
SELECT MIN(description), MAX(description)
FROM courses;

--Ex07
SELECT ROUND(AVG(COALESCE(cost,0)),1) "average cost"
FROM courses;

--Ex08
SELECT MAX(enroll_date)
FROM enrollments;

--Ex09
SELECT location, COUNT(section_no), SUM(capacity), MIN(capacity), MAX(capacity)
FROM sections
GROUP BY location;

--Ex10
--A
SELECT location, instructor_id, COUNT(section_no), SUM(capacity), MIN(capacity), MAX(capacity)
FROM sections
GROUP BY location, instructor_id
ORDER BY location;

--B
SELECT location, instructor_id, COUNT(section_no), SUM(capacity), MIN(capacity), MAX(capacity)
FROM sections
GROUP BY location, instructor_id
HAVING SUM(capacity)>50
ORDER BY SUM(capacity) DESC;

--C
SELECT location, instructor_id, COUNT(section_no), SUM(capacity), MIN(capacity), MAX(capacity)
FROM sections
WHERE course_no>99
GROUP BY location, instructor_id
HAVING SUM(capacity)>50
ORDER BY SUM(capacity) DESC;

--D
SELECT location, SUM(capacity)
FROM sections
WHERE location LIKE 'L5%'
GROUP BY location
HAVING COUNT(section_no)>3;

--Ex11
SELECT student_id, section_id, ROUND(AVG(numeric_grade))
FROM grades
WHERE grade_type_code='HM'
GROUP BY student_id, section_id
HAVING AVG(numeric_grade)<80
ORDER BY student_id, section_id;

--Ex12
SELECT prerequisite, COUNT(course_no)
FROM courses
GROUP BY prerequisite
ORDER BY prerequisite DESC;

--Ex13
SELECT student_id, COUNT(section_id)
FROM enrollments
GROUP BY student_id
HAVING COUNT(section_id)>2;

--Ex14
SELECT course_no, AVG(capacity), ROUND(AVG(capacity))
FROM sections
WHERE instructor_id=101
GROUP BY course_no;

--Ex15
SELECT cost, COUNT(cost)
FROM courses
GROUP BY cost
ORDER BY cost NULLS LAST;

--Ex16
SELECT enroll_date, COUNT(*)
FROM enrollments
WHERE section_id=90
GROUP BY enroll_date;

--Ex17
SELECT employer, COUNT(employer)
FROM students
GROUP BY employer
HAVING COUNT(employer)>4;

--Ex18
SELECT instructor_id, COUNT(course_no)
FROM sections
GROUP BY instructor_id
ORDER BY instructor_id;

--Ex19
SELECT section_id, MAX(numeric_grade)
FROM grades
WHERE grade_type_code='MT' AND section_id BETWEEN 85 AND 93
GROUP BY section_id;

--Ex20
SELECT student_id, ROUND(AVG(numeric_grade))
FROM grades
GROUP BY student_id
HAVING COUNT(DISTINCT section_id)>2;

--Ex21
SELECT zip, COUNT(student_id)
FROM students
GROUP BY zip
HAVING COUNT(student_id)>5;

--Ex22
SELECT c1.course_no, c1.description, COALESCE(to_char(c1.prerequisite,'999999999'),'none'), COALESCE(c2.description,'none')
FROM courses c1
LEFT OUTER JOIN courses c2 ON c1.prerequisite=c2.course_no
WHERE c1.course_no IS NOT NULL
ORDER BY c1.course_no;

--Ex23
SELECT c.course_no, c.description
FROM sections s
RIGHT OUTER JOIN courses c ON s.course_no=c.course_no
WHERE s.course_no IS NULL;

--Ex24
SELECT c.description, c.prerequisite, s.section_id, s.location
FROM courses c
LEFT OUTER JOIN sections s ON c.course_no=s.course_no
WHERe c.prerequisite=350;

--Ex25
SELECT CONCAT(i.first_name,' ',i.last_name), z.state
FROM sections s
RIGHT OUTER JOIN instructors i ON s.instructor_id=i.instructor_id
LEFT OUTER JOIN zipcodes z ON i.zip=z.zip
WHERE s.course_no IS NULL;

--Ex26
SELECT s.section_id,description unpopular_courses
FROM enrollments e
         RIGHT OUTER JOIN sections s ON (s.section_id=e. section_id)
         JOIN courses c ON (s.course_no=c.course_no)
WHERE e.section_id IS NULL;
