---PostgreSQL ALTER TABLE

---PostgreSQL ADD COLUMN: Add One or More Columns to a Table

create table columns(id serial primary key,
					name varchar(255));
					
alter table columns
add column phone bigint;

select * from columns;

alter table columns
add column fax varchar(255),
add column email varchar(255);

INSERT INTO 
   columns (name)
VALUES
   ('Apple'),
   ('Samsung'),
   ('Sony')
RETURNING *;

alter table columns 
add column contact_name varchar(255);


UPDATE columns
SET contact_name = 'John Doe'
WHERE id = 1;

UPDATE columns
SET contact_name = 'Mary Doe'
WHERE id = 2;

UPDATE columns
SET contact_name = 'Lily Bush'
WHERE id = 3;

ALTER TABLE columns
ALTER COLUMN contact_name 
SET NOT NULL;


----DROP COLUMN: Remove One or More Columns of a Table

CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(255) NOT NULL,
    published_date DATE NOT NULL,
    description VARCHAR,
    category_id INT NOT NULL,
    publisher_id INT NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id),
    FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

CREATE VIEW book_info 
AS SELECT
    book_id,
    title,
    isbn,
    published_date,
    name
FROM
    books b
INNER JOIN publishers 
    USING(publisher_id)
ORDER BY title;

ALTER TABLE books 
DROP COLUMN category_id;

select * from books;

ALTER TABLE books 
DROP COLUMN publisher_id;

ALTER TABLE books 
DROP COLUMN publisher_id CASCADE;

ALTER TABLE books 
  DROP COLUMN isbn,
  DROP COLUMN description;
  
-----Change the data type of column

CREATE TABLE assets (
    id serial PRIMARY KEY,
    name TEXT NOT NULL,
    asset_no VARCHAR NOT NULL,
    description TEXT,
    location TEXT,
    acquired_date DATE NOT NULL
);

INSERT INTO assets(name,asset_no,location,acquired_date)
VALUES('Server','10001','Server room','2017-01-01'),
      ('UPS','10002','Server room','2017-01-01')
RETURNING *;

--1) Changing one column example
ALTER TABLE assets 
ALTER COLUMN name TYPE VARCHAR(255);

alter table assets
	alter column  location TYPE varchar(255),
	alter column description TYPE varchar(255);
	
select * from assets;

--3) Changing a column from VARCHAR to INT example
ALTER TABLE assets
ALTER COLUMN asset_no TYPE INT 
USING asset_no::integer;


-----------RENAME COLUMN: Renaming a column------------------
ALTER TABLE table_name 
RENAME COLUMN column_name TO new_column_name;


CREATE TABLE customer_groups (
  id serial PRIMARY KEY, 
  name VARCHAR NOT NULL
);

CREATE TABLE customers (
  id serial PRIMARY KEY, 
  name VARCHAR NOT NULL, 
  phone VARCHAR NOT NULL, 
  email VARCHAR, 
  group_id INT, 
  FOREIGN KEY (group_id) REFERENCES customer_groups (id)
);


CREATE VIEW customer_data AS 
SELECT 
  c.id, 
  c.name, 
  g.name customer_group 
FROM 
  customers c 
  INNER JOIN customer_groups g ON g.id = c.group_id;
  
--1) Renaming one column example
ALTER TABLE customers 
RENAME COLUMN email TO contact_email;

---2) Renaming a column that has dependent objects example
ALTER TABLE customer_groups 
RENAME COLUMN name TO group_name;

--3) Using multiple RENAME COLUMN statements to rename multiple columns example

ALTER TABLE customers 
RENAME COLUMN name TO customer_name;

ALTER TABLE customers
RENAME COLUMN phone TO contact_phone;

-----PostgreSQL DEFAULT Value
CREATE TABLE products_default(
   id SERIAL PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(19,2) NOT NULL DEFAULT 0
);

INSERT INTO products_default(name)
VALUES('Laptop')
RETURNING *;


INSERT INTO products_default(name, price)
VALUES
   ('Smartphone', DEFAULT)
RETURNING *;

select * from products_default;

INSERT INTO products_default(name, price)
VALUES
   ('Tablet', 699.99)
RETURNING *;


---2) Using DEFAULT constraint with TIMESTAMP columns
CREATE TABLE logs(
   id SERIAL PRIMARY KEY,
   message TEXT NOT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
);

INSERT INTO logs(message)
VALUES('Started the server')
RETURNING *;

----3) Using DEFAULT constraint with JSONB type
CREATE TABLE settings(
   id SERIAL PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   configuration JSONB DEFAULT '{}'
);

INSERT INTO settings(name)
VALUES('global')
RETURNING *;

----rename table name
ALTER TABLE table_name
RENAME TO new_table_name;


CREATE TABLE vendorss (
    id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);

ALTER TABLE vendorss 
RENAME TO vendor_renamed;

----1) Renaming a table that has dependent objects
CREATE TABLE customer_groups_r(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE customers_r(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    group_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES customer_groups(id) 
       ON DELETE CASCADE 
       ON UPDATE CASCADE
);

CREATE VIEW customer_data_r
AS SELECT
    c.id,
    c.name,
    g.name customer_group
FROM
    customers_r c
INNER JOIN customer_groups_r g ON g.id = c.group_id;


ALTER TABLE customer_groups_r
RENAME TO groups;


ALTER TABLE table_name 
ADD CHECK expression;













































