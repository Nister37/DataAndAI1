--  1.	 
SELECT salutation, last_name, first_name, street_address
FROM instructors
Where UPPER(street_address) = '518 WEST 120TH'; 

-- 2.	 
SELECT salutation, first_name, last_name
FROM students
WHERE UPPER(last_name) = 'GRANT'
ORDER BY salutation desc, first_name;

-- 3.	
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE lower(salutation) = 'ms.' AND upper(last_name) IN ('ALLENDE', 'GRANT')
ORDER BY  last_name;

-- 4.	
SELECT *
FROM enrollments
WHERE final_grade <> 0;

-- 5.	
SELECT first_name || ' ' || last_name "Name", street_address "Address",zip "zip" 
FROM students
WHERE zip in ('10048', '11102','11209');

-- 6.	
SELECT student_id, first_name as First, last_name as Last, zip as zip
FROM students
WHERE (upper(first_name) = 'YVONNE'  AND zip = '11209') OR (upper(last_name)='ZUCKERBERG');

-- 7.	
SELECT description, prerequisite
FROM courses
Where prerequisite < 122;

-- 8.	
SELECT salutation, last_name "LAST NAME", first_name "FIRST NAME", phone
FROM instructors
Where UPPER(last_name) <> 'SCHORIN';

-- 9.	
SELECT DISTINCT first_name, last_name 
FROM students
WHERE zip = '10025'
ORDER BY student_id;

-- ERROR MESSAGE
--     ERROR:  for SELECT DISTINCT, ORDER BY expressions must appear in select list
--     LINE 3: ORDER BY student_id;

-- oplossing
-- Bij DISTINCT kan je niet sorteren op een veld dat niet in de Select staat
SELECT DISTINCT first_name, last_name FROM students
WHERE zip = '10025'
ORDER BY first_name;

-- 10.	
-- opgave
SELECT description "desc", prerequisite "pre" 
FROM courses
WHERE prerequisite IS NOT NULL 
ORDER BY description;

--oplossing
-- option 1
SELECT description "desc", prerequisite "pre"
FROM courses
WHERE prerequisite IS NOT NULL
ORDER BY "desc";

-- option 2
SELECT description "desc", prerequisite "pre"
FROM courses
WHERE prerequisite IS NOT NULL
ORDER BY 1;

-- 11.	
SELECT description, cost, prerequisite
FROM COURSES
WHERE cost = 1195 AND prerequisite IN (20,25);

-- 12.	
SELECT course_no, cost 
FROM courses
WHERE cost BETWEEN 1500 AND 1000;

-- Ondergrens moet kleiner zijn dan bovengrens.

-- 13.	

SELECT description, prerequisite FROM courses
WHERE	prerequisite NOT >= 140;

-- ERROR MESSAGE
--     ERROR:  syntax error at or near "NOT"
--     LINE 2: WHERE prerequisite NOT >= 140;

-- Oplossing
-- 		NOT Prerequisite >= 140
-- 	Of
-- 		Prerequisite < 140

-- 14.	
-- Opgave query
SELECT description FROM grade_types
WHERE description >= 'Midterm' AND description <= 'Project';

-- Oplossing query
SELECT description
FROM grade_types
WHERE UPPER(description) BETWEEN 'MIDTERM' AND 'PROJECT';

-- 15.	
-- Opgave query
SELECT city FROM zipcodes
WHERE state != 'NY' ;

-- Oplossing query
SELECT city
FROM zipcodes
WHERE NOT state = 'NY';

-- 16.	
SELECT student_id, last_name, zip
FROM students
WHERE zip BETWEEN '05000' AND '06825'
ORDER BY zip, last_name;

-- 17.	
SELECT student_id, last_name, zip 
FROM students
WHERE zip IN ('06483','06605','06798','06820')
ORDER BY zip, last_name DESC;

-- 18.	
SELECT student_id, first_name as first, last_name as last
FROM students
WHERE (upper(first_name) IN ('YVONNE', 'ANGEL', 'BRIAN' )) OR (upper(last_name) = 'TORRES')
order by 3,2;


-- 19.	
SELECT student_id, last_name as first, first_name as last, registration_date registration
FROM students
WHERE registration_date<'03-02-2021' and student_id>170
order by 2;

-- 20.	
SELECT *
FROM grade_conversions
WHERE grade_point between 3 and 4;

-- 21.	
SELECT course_no, description, prerequisite
FROM COURSES 
WHERE COURSE_NO < 100
ORDER BY prerequisite;