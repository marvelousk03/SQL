SELECT * FROM teachers;


SELECT last_name, first_name, salary FROM teachers;

 SELECT DISTINCT school 
FROM teachers;

SELECT last_name, school, hire_date
FROM teachers
ORDER BY school ASC, hire_date DESC;

SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers Middle School';

SELECT school
FROM teachers
WHERE school != 'F.D. Roosevelt HS';

SELECT first_name, last_name, hire_date
FROM teachers
WHERE hire_date < '2000-01-01';

SELECT first_name, last_name, school, salary
FROM teachers
WHERE salary BETWEEN 40000 AND 65000;

