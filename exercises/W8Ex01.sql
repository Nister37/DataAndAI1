--Ex01
SELECT birth_date
FROM employees
UNION ALL
SELECT birth_date
FROM family_members
ORDER BY birth_date;

--Ex02
SELECT birth_date
FROM employees
UNION ALL
SELECT birth_date
FROM family_members;

--Ex03
SELECT employee_id
FROM employees
EXCEPT
SELECT employee_id
FROM family_members;

--Ex04
SELECT employee_id
FROM employees
EXCEPT
SELECT manager_id
FROM employees;

--Ex05
SELECT employee_id, name, relationship,
CASE
   WHEN EXTRACT(YEAR FROM AGE(birth_date, current_date)) >= 18 THEN 'adult'
   ELSE 'child'
END age_category
FROM family_members;

--Ex06
SELECT
    CASE
        WHEN infix IS NOT NULL THEN
            first_name || '/' || COALESCE(REPLACE(infix,' ','/'), '/') || '/' || last_name
        ELSE first_name || '/' || COALESCE(REPLACE(infix,' ','/'), '') || last_name
END full_name
FROM employees;

--Ex07 IDK :/
--a
SELECT e.employee_id, e.first_name, e.birth_date, coalesce(fm.relationship, 'Singel') partner
FROM employees e
LEFT JOIN family_members fm ON e.employee_id = fm.employee_id AND fm.relationship='PARTNER'
ORDER BY partner;
--b
SELECT e.employee_id, e.first_name, e.birth_date, coalesce(fm.relationship, 'Singel') partner, fm.birth_date birth_date_partner,
       CASE
           WHEN fm.birth_date < e.birth_date THEN fm.name
               ELSE e.first_name
END first_name
FROM employees e
         LEFT JOIN family_members fm ON e.employee_id = fm.employee_id AND fm.relationship='PARTNER'
ORDER BY e.first_name;

--Ex08
SELECT student_id, section_id, numeric_grade, CASE
    WHEN numeric_grade >= 90 THEN 'Excellent'
    WHEN numeric_grade >= 80 THEN 'Outstanding'
    ELSE 'could be better'
END numeric_grade
FROM grades
WHERE grade_type_code='PA' AND section_id=101;

--Ex09
SELECT last_name, registration_date, to_char(registration_date, 'dd-mm-YYYY') "REG.DATE", to_char(registration_date,'dy') "day"
FROM students
WHERE student_id IN (123,161,190);

--Ex10
SELECT course_no, COALESCE(to_char(cost, '9999'), 'Unknown cost') Cost
FROM courses
WHERE course_no > 300;

--Ex11
SELECT upper(SUBSTRING(first_name, 1, 1)) || ' ' || initcap(last_name)
FROM students
WHERE initcap(last_name) LIKE 'E%'
ORDER BY last_name;

--Ex12
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE salutation LIKE 'Ms.' AND first_name LIKE '%.%'
ORDER BY LENGTH(last_name);

--Ex13
SELECT student_id, first_name, last_name, zip
FROM students
WHERE UPPER(first_name) LIKE '%Y%' AND zip='10025' OR SUBSTRING(UPPER(last_name),1,1) BETWEEN 'W' AND 'Z';

--Ex14
SELECT description, prerequisite
FROM courses
WHERE LOWER(description) LIKE 'intro to%' AND prerequisite IS NULL;

--Ex15
SELECT LENGTH('I count so many letters in total') Total;

--Ex16
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE INITCAP(salutation) = 'Ms.' AND INITCAP(last_name) IN ('Allende','Grant');

--Ex17
SELECT last_name, first_name
FROM instructors
WHERE substring(LOWER(last_name), 2, 1) = 'o';

--Ex18
SELECT RPAD('today it is ' || to_char(current_date, 'dd/mm/yyyy'),25,'*') "What day are we?";

--Ex19
SELECT RPAD('today it is ' || to_char(current_date, 'Day'),20,'*') || ' the ' || to_char(current_date,'ddTH') "What day are we?";

--Ex20
SELECT course_no, REPLACE(description, 'Java', 'C#')
FROM courses
WHERE description LIKE '%Java%'
ORDER BY course_no;

--Ex21
SELECT section_id, grade_type_code, created_date, modified_date
FROM grade_type_weights
WHERE NULLIF(created_date,modified_date) IS NULL;

--Ex22
--a
SELECT course_no, description, COALESCE(CAST(prerequisite AS TEXT), 'No previous knowledge required') prerequisite
FROM courses
WHERE LOWER(description) LIKE 'intro%'
ORDER BY course_no;

--b
SELECT course_no, description, COALESCE('We need prerequisite: ' || CAST(prerequisite AS TEXT), 'No previous knowledge required') prerequisite
FROM courses
WHERE LOWER(description) LIKE 'intro%'
ORDER BY course_no;

--c
SELECT student_id, section_id, grade_type_code, ROUND(numeric_grade/5) numeric_grade_on_20
FROM grades
WHERE UPPER(grade_type_code)='PA';

--Ex23 bruh how am I suppose to know when it starts

--Ex24
--a
SELECT section_id, to_char(start_date_time, 'dd/mm/yyyy day')
FROM sections
WHERE section_id BETWEEN 80 AND 89;

--b no kogos chyyba pojeba*o

--Ex25
--a
SELECT student_id, section_id, to_char(enroll_date, 'dd month yyyy')
FROM enrollments
WHERE section_id=117;

--b
SELECT student_id, section_id, to_char(enroll_date, '"the "ddth" in the "IWth" week of the year "YYYY"')
FROM enrollments
WHERE section_id=117;

--Ex26