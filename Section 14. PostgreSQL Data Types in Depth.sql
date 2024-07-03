---Section 14. PostgreSQL Data Types in Depth

---PostgreSQL Boolean Data Type with Practical Examples
CREATE TABLE stock_availability (
   product_id INT PRIMARY KEY,
   available BOOLEAN NOT NULL
);

INSERT INTO stock_availability (product_id, available) 
VALUES 
  (100, TRUE), 
  (200, FALSE), 
  (300, 't'), 
  (400, '1'), 
  (500, 'y'), 
  (600, 'yes'), 
  (700, 'no'), 
  (800, '0')
  returning*;
  
SELECT *
FROM stock_availability
WHERE available = 'yes';

SELECT *
FROM stock_availability
WHERE available;

SELECT 
  * 
FROM 
  stock_availability 
WHERE 
  available = 'no';


SELECT 
  * 
FROM 
  stock_availability 
WHERE 
  NOT available;
  
---Set the default values for Boolean columns
ALTER TABLE stock_availability 
ALTER COLUMN available
SET DEFAULT FALSE;

INSERT INTO stock_availability (product_id)
VALUES (900);

select * from stock_availability

----PostgreSQL Character Types: CHAR, VARCHAR, and TEXT
CREATE TABLE character_tests (
  id serial PRIMARY KEY, 
  x CHAR (1), 
  y VARCHAR (10), 
  z TEXT
);

INSERT INTO character_tests (x, y, z) 
VALUES 
  (
    'Yes', 'This is a test for varchar', 
    'This is a very long text for the PostgreSQL text column'
  );
  
INSERT INTO character_tests (x, y, z) 
VALUES 
  (
    'Y', 
    'This is a test for varchar', 
    'This is a very long text for the PostgreSQL text column'
  );
  
  
INSERT INTO character_tests (x, y, z) 
VALUES 
  (
    'Y', 
    'varchar(n)', 
    'This is a very long text for the PostgreSQL text column'
  )
RETURNING *;


---PostgreSQL NUMERIC Type
---1) Storing numeric values
CREATE TABLE products_n (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(5,2)
);

INSERT INTO products_n (name, price)
VALUES ('Phone',500.215), 
       ('Tablet',500.214);
	   
select * from products_n;

INSERT INTO products_n (name, price)
VALUES('Phone',123456.21);

----PostgreSQL DOUBLE PRECISION Data Type
---1) Basic double precision data type example

CREATE TABLE temperatures (
    id SERIAL PRIMARY KEY,
    location TEXT NOT NULL,
    temperature DOUBLE PRECISION
);

INSERT INTO
  temperatures (location, temperature)
VALUES
  ('Lab Room 1', 23.5),
  ('Server Room 1', 21.8),
  ('Server Room 2', 24.3)
RETURNING *;

SELECT AVG(temperature) 
FROM temperatures;

----2) Storing inexact values
CREATE TABLE t(c double precision);

INSERT INTO t(c) VALUES(0.1), (0.1), (0.1)
RETURNING *;

INSERT INTO t(c) VALUES(02344.737638643641)
RETURNING *;

---2) Inserting too small numbers
INSERT INTO t(c) 
VALUES (1E-400);

---PostgreSQL REAL Data Type
CREATE TABLE weathers(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    location VARCHAR(255) NOT NULL,
    wind_speed_mps REAL NOT NULL,
    temperature_celsius REAL NOT NULL,
    recorded_at TIMESTAMP NOT NULL
);

INSERT INTO weathers (location, wind_speed_mps, temperature_celsius, recorded_at) 
VALUES
    ('New York', 5.2, 15.3, '2024-04-19 09:00:00'),
    ('New York', 4.8, 14.9, '2024-04-19 10:00:00'),
    ('New York', 6.0, 16.5, '2024-04-19 11:00:00'),
    ('New York', 5.5, 15.8, '2024-04-19 12:00:00'),
    ('New York', 4.3, 14.2, '2024-04-19 13:00:00'),
    ('New York', 5.9, 16.1, '2024-04-19 14:00:00'),
    ('New York', 6.8, 17.3, '2024-04-19 15:00:00'),
    ('New York', 5.1, 15.6, '2024-04-19 16:00:00'),
    ('New York', 4.7, 14.8, '2024-04-19 17:00:00'),
    ('New York', 5.3, 15.9, '2024-04-19 18:00:00');
	
select * from weathers;

SELECT
  AVG(wind_speed_mps)       wind_speed,
  AVG(temperature_celsius) temperature_celsius
FROM
  weathers
WHERE
  location = 'New York'
  AND DATE(recorded_at) = '2024-04-19';


---UUID
SELECT gen_random_uuid();

CREATE TABLE contacts_uuid (
    contact_id uuid DEFAULT gen_random_uuid(),
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    phone VARCHAR,
    PRIMARY KEY (contact_id)
);

INSERT INTO contacts_uuid ( first_name, last_name, email, phone) 
VALUES 
  ('John', 'Smith', 'john.smith@example.com',  '408-237-2345'), 
  ('Jane', 'Smith', 'jane.smith@example.com', '408-237-2344'), 
  ('Alex', 'Smith', 'alex.smith@example.com', '408-237-2343')
RETURNING *;

-----PostgreSQL CREATE DOMAIN statement
CREATE TABLE mailing_list (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    CHECK (
        first_name !~ '\s'
        AND last_name !~ '\s'
    )
);

CREATE DOMAIN contact_name AS 
   VARCHAR NOT NULL CHECK (value !~ '\s');


CREATE TABLE mailing_lists (
    id serial PRIMARY KEY,
    first_name contact_name,
    last_name contact_name,
    email VARCHAR NOT NULL
);

INSERT INTO mailing_lists (first_name, last_name, email)
VALUES('Jame V','Doe','jame.doe@example.com')
returning*;

INSERT INTO mailing_list (first_name, last_name, email)
VALUES('Jane','Doe','jane.doe@example.com')
returning*;


CREATE TYPE film_summary AS (
    film_id INT,
    title VARCHAR,
    release_year SMALLINT
); 

---PostgreSQL enum
CREATE TYPE priority AS ENUM('low','medium','high');

CREATE TABLE requests(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    priority PRIORITY NOT NULL,
    request_date DATE NOT NULL
);

INSERT INTO requests(title, priority, request_date)
VALUES
   ('Create an enum tutorial in PostgreSQL', 'high', '2019-01-01'),
   ('Review the enum tutorial', 'medium', '2019-01-01'),
   ('Publish the PostgreSQL enum tutorial', 'low', '2019-01-01')
RETURNING *;

SELECT *
FROM requests
ORDER BY priority;

INSERT INTO requests(title, priority, request_date)
VALUES
   ('Revise the enum tutorial', 'urgent', '2019-01-02')
RETURNING *;

ALTER TYPE priority 
ADD VALUE 'urgent';














































































