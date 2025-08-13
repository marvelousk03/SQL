CREATE TABLE profession (
    prof_id SERIAL PRIMARY KEY,
    profession VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE zip_code (
    zip_code CHAR(4) PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    CONSTRAINT chk_zip_code_length CHECK (zip_code ~ '^[0-9]{4}$')
);


CREATE TABLE status (
    status_id SERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL
);


CREATE TABLE my_contacts (
    contact_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100),
    first_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    gender VARCHAR(10),
    birthday DATE,
    prof_id INT REFERENCES profession(prof_id),
    zip_code CHAR(4) REFERENCES zip_code(zip_code),
    status_id INT REFERENCES status(status_id)
);


CREATE TABLE interests (
    interest_id SERIAL PRIMARY KEY,
    interest VARCHAR(100) NOT NULL
);


CREATE TABLE seeking (
    seeking_id SERIAL PRIMARY KEY,
    seeking VARCHAR(100) NOT NULL
);


CREATE TABLE contact_interest (
    contact_id INT REFERENCES my_contacts(contact_id),
    interest_id INT REFERENCES interests(interest_id),
    PRIMARY KEY (contact_id, interest_id)
);


CREATE TABLE contact_seeking (
    contact_id INT REFERENCES my_contacts(contact_id),
    seeking_id INT REFERENCES seeking(seeking_id),
    PRIMARY KEY (contact_id, seeking_id)
);



INSERT INTO profession (profession) VALUES
('Teacher'), ('Engineer'), ('Doctor'), ('Nurse'), ('Accountant'),
('Police Officer'), ('Software Developer'), ('Electrician'), ('Plumber'), ('Chef');


INSERT INTO zip_code (zip_code, city, province) VALUES
('2000', 'Johannesburg', 'Gauteng'),
('0002', 'Pretoria', 'Gauteng'),
('8001', 'Cape Town', 'Western Cape'),
('7600', 'Stellenbosch', 'Western Cape'),
('5201', 'East London', 'Eastern Cape'),
('6001', 'Port Elizabeth', 'Eastern Cape'),
('4001', 'Durban', 'KwaZulu-Natal'),
('3201', 'Pietermaritzburg', 'KwaZulu-Natal'),
('0700', 'Polokwane', 'Limpopo'),
('0950', 'Thohoyandou', 'Limpopo'),
('1200', 'Nelspruit', 'Mpumalanga'),
('2302', 'Secunda', 'Mpumalanga'),
('2745', 'Mahikeng', 'North West'),
('0299', 'Rustenburg', 'North West'),
('9301', 'Bloemfontein', 'Free State'),
('9460', 'Welkom', 'Free State'),
('8301', 'Kimberley', 'Northern Cape'),
('8801', 'Upington', 'Northern Cape');


INSERT INTO status (status) VALUES
('Single'), ('Married'), ('Divorced'), ('Widowed');


INSERT INTO interests (interest) VALUES
('Reading'), ('Traveling'), ('Cooking'), ('Hiking'), ('Swimming'),
('Photography'), ('Music'), ('Dancing'), ('Gaming'), ('Sports');


INSERT INTO seeking (seeking) VALUES
('Friendship'), ('Relationship'), ('Networking');


INSERT INTO my_contacts (last_name, first_name, phone, email, gender, birthday, prof_id, zip_code, status_id) VALUES
('Nkosi', 'Sipho', '0821234567', 'sipho.nkosi@example.com', 'Male', '1990-05-12', 1, '2000', 1),
('Mokoena', 'Thandi', '0832345678', 'thandi.mokoena@example.com', 'Female', '1985-07-21', 2, '8001', 2),
('Van Wyk', 'Pieter', '0843456789', 'pieter.vw@example.com', 'Male', '1992-03-18', 3, '5201', 1),
('Dlamini', 'Zanele', '0829876543', 'zanele.d@example.com', 'Female', '1995-11-02', 4, '4001', 1),
('Smith', 'John', '0611234567', 'john.smith@example.com', 'Male', '1988-08-08', 5, '0700', 2),
('Khumalo', 'Sibusiso', '0723456789', 'sibusiso.k@example.com', 'Male', '1991-01-14', 6, '1200', 3),
('Peters', 'Chantel', '0791239876', 'chantel.p@example.com', 'Female', '1987-04-30', 7, '2745', 1),
('Mabaso', 'Lerato', '0654321987', 'lerato.m@example.com', 'Female', '1993-06-15', 8, '9301', 2),
('Naidoo', 'Rajesh', '0828765432', 'rajesh.n@example.com', 'Male', '1986-02-22', 9, '8301', 4),
('Botha', 'Elsabe', '0836789123', 'elsabe.b@example.com', 'Female', '1990-09-10', 10, '8801', 1),
('Zulu', 'Sifiso', '0729876543', 'sifiso.z@example.com', 'Male', '1994-12-19', 2, '0002', 1),
('Mathebula', 'Precious', '0619872345', 'precious.m@example.com', 'Female', '1995-07-07', 4, '7600', 3),
('Adams', 'Kyle', '0781236547', 'kyle.a@example.com', 'Male', '1989-05-25', 1, '6001', 1),
('Daniels', 'Aisha', '0842347654', 'aisha.d@example.com', 'Female', '1996-11-11', 5, '3201', 1),
('Phiri', 'Bongani', '0794561237', 'bongani.p@example.com', 'Male', '1988-10-03', 6, '0950', 2);


INSERT INTO contact_interest VALUES
(1,1),(1,2),(1,3),
(2,4),(2,5),(2,6),
(3,1),(3,7),(3,8),
(4,2),(4,3),(4,9),
(5,5),(5,6),(5,10),
(6,1),(6,4),(6,7),
(7,2),(7,8),(7,9),
(8,3),(8,6),(8,10),
(9,1),(9,5),(9,8),
(10,2),(10,4),(10,9),
(11,1),(11,3),(11,7),
(12,4),(12,5),(12,8),
(13,2),(13,6),(13,10),
(14,1),(14,8),(14,9),
(15,3),(15,5),(15,7);


INSERT INTO contact_seeking VALUES
(1,1),(1,2),
(2,2),(2,3),
(3,1),(3,3),
(4,1),(4,2),
(5,2),(5,3),
(6,1),(6,2),
(7,2),(7,3),
(8,1),(8,3),
(9,1),(9,2),
(10,2),(10,3),
(11,1),(11,2),
(12,2),(12,3),
(13,1),(13,3),
(14,1),(14,2),
(15,2),(15,3);


SELECT mc.first_name, mc.last_name, p.profession, 
       z.zip_code, z.city, z.province,
       s.status,
       STRING_AGG(DISTINCT i.interest, ', ') AS interests,
       STRING_AGG(DISTINCT sk.seeking, ', ') AS seeking
FROM my_contacts mc
LEFT JOIN profession p ON mc.prof_id = p.prof_id
LEFT JOIN zip_code z ON mc.zip_code = z.zip_code
LEFT JOIN status s ON mc.status_id = s.status_id
LEFT JOIN contact_interest ci ON mc.contact_id = ci.contact_id
LEFT JOIN interests i ON ci.interest_id = i.interest_id
LEFT JOIN contact_seeking cs ON mc.contact_id = cs.contact_id
LEFT JOIN seeking sk ON cs.seeking_id = sk.seeking_id
GROUP BY mc.contact_id, mc.first_name, mc.last_name, p.profession,
         z.zip_code, z.city, z.province, s.status
ORDER BY mc.contact_id;
