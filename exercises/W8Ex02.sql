--Ex01
SELECT COUNT(*)
FROM (SELECT student_id
FROM students
EXCEPT
SELECT student_id
FROM enrollments) AS unregistred;

--Ex02
SELECT course_no
FROM courses
EXCEPT
SELECT course_no
FROM sections;

--Ex03
--a
SELECT COUNT(*)
FROM(
SELECT s.first_name, 'student' status
FROM students s
UNION ALL
SELECT i.first_name, 'instructor' status
FROM instructors i) AS names;

--b ???
SELECT COUNT(*)
FROM(
        SELECT s.first_name, 'student' status
        FROM students s
        UNION
        SELECT i.first_name, 'instructor' status
        FROM instructors i) AS names;

--Ex04
SELECT s.first_name
FROM students s
INTERSECT
SELECT i.first_name
FROM instructors i;

--Ex05
SELECT zip_code, z.city, z.state
FROM (SELECT s.zip
    FROM students s
    INTERSECT
    SELECT i.zip
    FROM instructors i) AS zip_code
JOIN zipcodes z ON z.zip = zip_code.zip;

--Ex06
SELECT c.course_no
FROM courses c
WHERE c.prerequisite IS NOT NULL
INTERSECT
SELECT courses_counted.course_no
FROM (SELECT s.course_no, COUNT(s.course_no) quantity
      FROM sections s
      GROUP BY s.course_no) AS courses_counted
WHERE quantity >= 5;

--Ex07 skip
--Ex08 huh?
--Ex09
SELECT AVG(costs.costs)
FROM (SELECT COALESCE(c.cost, 0) costs
      FROM courses c) AS costs;

--Ex10
SELECT c.prerequisite, COUNT(*) num_course
FROM courses c
GROUP BY c.prerequisite
ORDER BY c.prerequisite DESC NULLS FIRST;

--Ex11 idk how
SELECT c.course_no, c.description, COALESCE(to_char(c.prerequisite,'999'), 'none'), COALESCE(c2.description, 'none')
FROM courses c
LEFT JOIN courses c2 ON c2.course_no = c.prerequisite
ORDER BY course_no;

--Ex12
SELECT z.city, INITCAP(z.state) state
FROM zipcodes z
WHERE TO_NUMBER(z.zip,'99999') < 5000 OR UPPER(z.state) = 'WV'
ORDER BY z.state;

--Ex13
SELECT RPAD(z.city, 20, '.')
FROM zipcodes z
WHERE UPPER(substring(z.city,1,1)) BETWEEN 'A' AND 'M'
AND z.state = 'CT';

--Ex14
SELECT s.last_name, POSITION('a' IN s.last_name) "Letter a"
FROM students s
WHERE POSITION('a' IN s.last_name) > 8;

--Ex15
SELECT s.student_id, s.last_name, s.created_date, CONCAT((CURRENT_DATE - s.created_date),' days') created_date
FROM students s
WHERE s.student_id < 106;

--Ex16
SELECT section_id
FROM enrollments
WHERE to_char(enroll_date, 'yyyy-mm') = '2021-10';

--Ex17
SELECT DISTINCT cost, round(cost * 1.5,2)::NUMERIC(9,2), round(cost * 1.5)
FROM courses
WHERE cost IS NOT NULL;

--Ex18 WRONG
SELECT z.state
FROM students s
JOIN zipcodes z ON s.zip = z.zip
EXCEPT
SELECT z.state
FROM instructors i
JOIN zipcodes z ON i.zip = z.zip;

--Ex19
