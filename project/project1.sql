-- Project 1

CREATE TABLE Department (
    depart_id SERIAL PRIMARY KEY,
    depart_name VARCHAR(100),
    depart_city VARCHAR(100)
);


INSERT INTO Department (depart_name, depart_city) 
VALUES 
('HR', 'Cape Town'),
('IT', 'Johannesburg'),
('Finance', 'Durban');


CREATE TABLE Roles (
    role_id SERIAL PRIMARY KEY,
    role VARCHAR(100)
);


INSERT INTO Roles (role) 
VALUES 
('Manager'),
('Developer'),
('Accountant');


CREATE TABLE Salaries (
    salary_id SERIAL PRIMARY KEY,
    salary_pa NUMERIC(10, 2)
);


INSERT INTO Salaries (salary_pa) 
VALUES 
(600000.00),
(450000.00),
(500000.00);


CREATE TABLE Overtime_Hours (
    overtime_id SERIAL PRIMARY KEY,
    overtime_hours INTEGER
);


INSERT INTO Overtime_Hours (overtime_hours) 
VALUES 
(10), 
(15), 
(20);


CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    surname VARCHAR(100),
    gender VARCHAR(10),
    address TEXT,
    email VARCHAR(100) UNIQUE,
    depart_id INTEGER REFERENCES Department(depart_id),
    role_id INTEGER REFERENCES Roles(role_id),
    salary_id INTEGER REFERENCES Salaries(salary_id),
    overtime_id INTEGER REFERENCES Overtime_Hours(overtime_id)
);


INSERT INTO Employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id) 
VALUES 
('John', 'Smith', 'M', '123 Street', 'john@example.com', 1, 1, 1, 1),
('Sarah', 'Jones', 'F', '456 Avenue', 'sarah@example.com', 2, 2, 2, 2),
('Mike', 'Brown', 'M', '789 Road', 'mike@example.com', 3, 3, 3, 3);


SELECT 
    e.first_name, 
    e.surname, 
    d.depart_name, 
    r.role, 
    s.salary_pa, 
    o.overtime_hours
FROM 
    Employees e
LEFT JOIN 
    Department d ON e.depart_id = d.depart_id
LEFT JOIN 
    Roles r ON e.role_id = r.role_id
LEFT JOIN 
    Salaries s ON e.salary_id = s.salary_id
LEFT JOIN 
    Overtime_Hours o ON e.overtime_id = o.overtime_id;

