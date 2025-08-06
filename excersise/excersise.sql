CREATE TABLE books (
	book_name varchar(50), 
	author_name varchar(50)  
);

SELECT * FROM books;

INSERT INTO books (book_name, author_name)
VALUES 
	('Iron Flame', 'Rebecca Yarros' );

ALTER TABLE books ADD COLUMN pages integer;

INSERT INTO books (pages)
VALUES 
	(365);

UPDATE books 
SET pages = 365


--didn't work
DELETE FROM books
WHERE id = 2;

--right method to delete a row
DELETE FROM books
WHERE book_name IS NULL AND author_name IS NULL AND pages = 365;


CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    facility VARCHAR(100)
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR (100) UNIQUE,
    is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO department (name, facility)
VALUES
    ('SQL', 'Home'),
    ('MERN', 'Office');

ALTER TABLE employees
ADD COLUMN department_id integer,
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id)
REFERENCES department(department_id);


INSERT INTO employees (full_name, email, department_id) 
VALUES
	('Alexander Badenhorst', 'alex@example.com', 1),
	('Courtney Cook', 'courtsey_of_courtney@funmail.io', 2),
	('Cadee Rousseau', 'codee.withcadee@byte.com', 1),
	('David Koen', 'teachinator.david@brainboost.edu', 1),
	('Ethan Hurwitz', 'ethanator@hackmail.com', 1),
	('Lindokuhle Yende', 'lindo.logic@neuralhub.org', 1),
	('Marvelous Kahundahunda', 'absolutely.marvelous@wow.com', 1),
	('Pierre Kahundahunda', 'pierrefect.code@bonjour.dev', 1),
	('Ronny Mputla', 'run.run.ronny@speedmail.net', 1),
	('Sibusiso Makhiwane', 'sibu.saves@galaxymail.com', 1),
	('Tom Vuma', 'tom.tornado@scriptstorm.dev', 1),
	('Ulrich Snyman', 'ultimatecoding@master.com', 1);

SELECT * FROM department
SELECT * FROM employees

COPY (
    SELECT 
        e.full_name, 
        e.email, 
        d.name AS department_name
    FROM employees e
    JOIN department d ON e.department_id = d.department_id
) TO 'C:\Bootcamp\sql\mycode\excersise\joined_employees_departments.csv' CSV HEADER;

SELECT 
    e.employee_id,
    e.full_name,
    e.email,
    d.name AS department_name,
    d.facility
FROM 
    employees e
JOIN 
    department d
ON 
    e.department_id = d.department_id;

ALTER TABLE employees
ADD COLUMN score INTEGER;

UPDATE employees SET score = 78 WHERE full_name = 'Alexander Badenhorst';
UPDATE employees SET score = 81 WHERE full_name = 'Cadee Rousseau';
UPDATE employees SET score = 85 WHERE full_name = 'David Koen';
UPDATE employees SET score = 76 WHERE full_name = 'Ethan Hurwitz';
UPDATE employees SET score = 94 WHERE full_name = 'Lindokuhle Yende';
UPDATE employees SET score = 89 WHERE full_name = 'Marvelous Kahundahunda';
UPDATE employees SET score = 92 WHERE full_name = 'Pierre Kahundahunda';
UPDATE employees SET score = 74 WHERE full_name = 'Ronny Mputla';
UPDATE employees SET score = 75 WHERE full_name = 'Sibusiso Makhiwane';
UPDATE employees SET score = 80 WHERE full_name = 'Tom Vuma';
UPDATE employees SET score = 87 WHERE full_name = 'Ulrich Snyman';
UPDATE employees SET score = 65 WHERE full_name = 'Courtney Cook';

SELECT 
    percentile_cont(.9) 
    WITHIN GROUP (ORDER BY score) AS percentile_90_score
FROM employees;

SELECT full_name, score
FROM employees
WHERE score = (
    SELECT MAX(score) FROM employees
);

SELECT full_name, score
FROM employees
WHERE score = (SELECT MIN(score) FROM employees);


SELECT full_name, score
FROM employees
WHERE score = (
    SELECT ROUND(AVG(score)) FROM employees
);


--SELECT full_name, score
--FROM employees
--ORDER BY score DESC
--LIMIT 3;


--Challenge

-- Step 1: Create roles table
CREATE TABLE roles (
	role_id BIGSERIAL PRIMARY KEY,
	role_name VARCHAR(50),
	role_description TEXT,
	salaries INTEGER
);

-- Step 2: Create employees2 table (remove role_name column)
CREATE TABLE employees2 (
	emp_id BIGSERIAL PRIMARY KEY,
	emp_name VARCHAR(50),
	birthdate DATE,
	role_id BIGINT REFERENCES roles(role_id),
	sales INTEGER
);

-- Step 3: Insert role data
INSERT INTO roles (role_name, role_description, salaries)
VALUES 
('Graphic Designer', 'Helps with video editing, photo editing and market advertisement designs', 35000),
('Videographer', 'Helps with all digital media productions', 18000),
('Social Marketer', 'Helps with social media strategies and social data', 26000),
('Sales Rep', 'Helps promote and sign clients', 20000);

-- Step 4: View roles (optional)
SELECT * FROM employees2;

-- Step 5: Insert employee data (using correct role_id)
-- Make sure role_id values match the auto-generated IDs from the roles table
-- Assuming: 1 = Graphic Designer, 2 = Videographer, 3 = Social Marketer, 4 = Sales Rep
INSERT INTO employees2 (emp_name, birthdate, role_id, sales)
VALUES 
('Aragorn', '1994-08-24', 4, 22),
('Gandalf', '1982-05-11', 1, 0),
('Frodo', '1990-01-18', 2, 0),
('Legolas', '1998-04-22', 3, 0),
('Gimli', '2000-11-08', 4, 10),
('Samwise', '2001-01-01', 4, 9),
('Pippin', '1999-09-26', 4, 18),
('Merry', '2005-08-07', 3, 0);

DROP TABLE roles;
DROP TABLE employees2;

	SELECT 
    e.emp_name,
    e.birthdate,
    r.role_name,
    r.salaries AS base_salary,
    e.sales,
    CASE 
        WHEN r.role_name = 'Sales Rep' AND e.sales > 10 THEN r.salaries + (e.sales - 10) * 200
        ELSE r.salaries
    END AS adjusted_salary
FROM 
    employees2 e
JOIN 
    roles r ON e.role_id = r.role_id

SELECT *
FROM employees2 e
WHERE AGE(CURRENT_DATE, e.birthdate) >= INTERVAL '27 years';

--chapter15 exercise

CREATE OR REPLACE FUNCTION multiply(num1 numeric, num2 numeric)
RETURNS numeric AS $$
BEGIN
    RETURN (num1 *  num2);
END;
$$ LANGUAGE plpgsql;

SELECT multiply(4, 4);



