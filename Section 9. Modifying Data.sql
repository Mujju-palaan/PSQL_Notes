-------Section 9. Modifying Data

CREATE TABLE links (
  id SERIAL PRIMARY KEY, 
  url VARCHAR(255) NOT NULL, 
  name VARCHAR(255) NOT NULL, 
  description VARCHAR (255), 
  last_update DATE
);


INSERT INTO links (url, name)
VALUES('https://www.postgresqltutorial.com','PostgreSQL Tutorial');

SELECT	* FROM links;

INSERT INTO links (url, name)
VALUES('http://www.oreilly.com','O''Reilly Media');

SELECT * FROM links;

----3) Inserting a date value 'YYYY-MM-DD'.

INSERT INTO links (url, name, last_update)
VALUES('https://www.google.com','Google','2013-06-01');

SELECT * FROM links;

INSERT INTO links (url, name)
VALUES('https://www.postgresql.org','PostgreSQL') 
RETURNING id;

----Inserting multiple rows into a table

CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(384) NOT NULL UNIQUE
);


INSERT INTO contacts (first_name, last_name, email) 
VALUES
    ('John', 'Doe', 'john.doe@example.com'),
    ('Jane', 'Smith', 'jane.smith@example.com'),
    ('Bob', 'Johnson', 'bob.johnson@example.com');
	

SELECT * FROM contacts;


INSERT INTO contacts (first_name, last_name, email) 
VALUES
    ('Alice', 'Johnson', 'alice.johnson@example.com'),
    ('Charlie', 'Brown', 'charlie.brown@example.com')
RETURNING *;


INSERT INTO contacts (first_name, last_name, email) 
VALUES
    ('Eva', 'Williams', 'eva.williams@example.com'),
    ('Michael', 'Miller', 'michael.miller@example.com'),
    ('Sophie', 'Davis', 'sophie.davis@example.com')
RETURNING id;


------PostgreSQL UPDATE


CREATE TABLE courses(
  course_id serial PRIMARY KEY, 
  course_name VARCHAR(255) NOT NULL, 
  price DECIMAL(10,2) NOT NULL,
  description VARCHAR(500), 
  published_date date
);


INSERT INTO courses( course_name, price, description, published_date) 
VALUES 
('PostgreSQL for Developers', 299.99, 'A complete PostgreSQL for Developers', '2020-07-13'), 
('PostgreSQL Admininstration', 349.99, 'A PostgreSQL Guide for DBA', NULL), 
('PostgreSQL High Performance', 549.99, NULL, NULL), 
('PostgreSQL Bootcamp', 777.99, 'Learn PostgreSQL via Bootcamp', '2013-07-11'), 
('Mastering PostgreSQL', 999.98, 'Mastering PostgreSQL in 21 Days', '2012-06-30');

SELECT * FROM courses;



UPDATE courses
SET published_date = '2020-08-01' 
WHERE course_id = 3;

SELECT course_id, course_name, published_date
FROM courses
WHERE course_id = 3;


UPDATE courses
SET published_date = '2020-07-01'
WHERE course_id = 2
RETURNING *;

UPDATE courses
SET price = price * 1.05;

----------Introduction to the PostgreSQL UPDATE join syntax

CREATE TABLE product_segment (
    id SERIAL PRIMARY KEY,
    segment VARCHAR NOT NULL,
    discount NUMERIC (4, 2)
);


INSERT INTO 
    product_segment (segment, discount)
VALUES
    ('Grand Luxury', 0.05),
    ('Luxury', 0.06),
    ('Mass', 0.1);

select * from product_segment;

CREATE TABLE product(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    price NUMERIC(10,2),
    net_price NUMERIC(10,2),
    segment_id INT NOT NULL,
    FOREIGN KEY(segment_id) REFERENCES product_segment(id)
);


INSERT INTO 
    product (name, price, segment_id) 
VALUES 
    ('diam', 804.89, 1),
    ('vestibulum aliquet', 228.55, 3),
    ('lacinia erat', 366.45, 2),
    ('scelerisque quam turpis', 145.33, 3),
    ('justo lacinia', 551.77, 2),
    ('ultrices mattis odio', 261.58, 3),
    ('hendrerit', 519.62, 2),
    ('in hac habitasse', 843.31, 1),
    ('orci eget orci', 254.18, 3),
    ('pellentesque', 427.78, 2),
    ('sit amet nunc', 936.29, 1),
    ('sed vestibulum', 910.34, 1),
    ('turpis eget', 208.33, 3),
    ('cursus vestibulum', 985.45, 1),
    ('orci nullam', 841.26, 1),
    ('est quam pharetra', 896.38, 1),
    ('posuere', 575.74, 2),
    ('ligula', 530.64, 2),
    ('convallis', 892.43, 1),
    ('nulla elit ac', 161.71, 3);


UPDATE product
SET net_price = price - price * discount
FROM product_segment
WHERE product.segment_id = product_segment.id;

SELECT * FROM product;

---PostgreSQL DELETE

CREATE TABLE todos (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT false
);

INSERT INTO todos (title, completed) VALUES
    ('Learn basic SQL syntax', true),
    ('Practice writing SELECT queries', false),
    ('Study PostgreSQL data types', true),
    ('Create and modify tables', false),
    ('Explore advanced SQL concepts', true),
    ('Understand indexes and optimization', false),
    ('Backup and restore databases', true),
    ('Implement transactions', false),
    ('Master PostgreSQL security features', true),
    ('Build a sample application with PostgreSQL', false);

INSERT INTO todos (title) VALUES ('mujju')

SELECT * FROM todos;

---1) Using PostgreSQL DELETE to delete one row from the table

DELETE FROM todos
WHERE id = 1;

DELETE FROM todos
WHERE id = 100;

----2) Using PostgreSQL DELETE to delete a row and return the deleted row

DELETE FROM todos
WHERE id = 2
RETURNING *;

----3) Using PostgreSQL DELETE to delete multiple rows from the table

DELETE FROM todos
WHERE completed = true
RETURNING *;

---4) Using PostgreSQL DELETE to delete all rows from the table

DELETE FROM todos;


----PostgreSQL UPSERT using INSERT ON CONFLICT Statement

CREATE TABLE inventory(
   id INT PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   quantity INT NOT NULL
);

INSERT INTO inventory(id, name, price, quantity)
VALUES
	(1, 'A', 15.99, 100),
	(2, 'B', 25.49, 50),
	(3, 'C', 19.95, 75)
RETURNING *;


CREATE TABLE inventoryy(
   id INT PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   quantity INT NOT NULL
);

INSERT INTO inventoryy(id, name, price, quantity)
VALUES
	(1, 'A', 15.99, 100),
	(2, 'B', 25.49, 50),
	(3, 'C', 19.95, 75)
RETURNING *;


----1) Basic PostgreSQL INSERT … ON CONFLICT statement example

INSERT INTO inventoryy (id, name, price, quantity)
VALUES (1, 'A', 16.99, 120)
ON CONFLICT(id) 
DO UPDATE SET
  price = EXCLUDED.price,
  quantity = EXCLUDED.quantity;

select * from inventoryy;

SELECT * FROM inventoryy 
WHERE id = 1;

--2) Inserting data example

INSERT INTO inventoryy (id, name, price, quantity)
VALUES (4, 'D', 29.99, 20)
ON CONFLICT(id) 
DO UPDATE SET
  price = EXCLUDED.price,
  quantity = EXCLUDED.quantity;


SELECT * FROM inventoryy
ORDER BY id;
	

























































