---PostgreSQL CREATE TABLE

--Declaring NOT NULL columns

create table if not exists invioces(
	id serial primary key,
	product_id int not null,
	qty numeric not null CHECK (qty > 0),
	net_price numeric check (net_price > 0)
);

alter table invioces rename to invoices;
select * from invoices;


CREATE TABLE production_orders (
	id SERIAL PRIMARY KEY,
	description VARCHAR (40) NOT NULL,
	material_id VARCHAR (16),
	qty NUMERIC,
	start_date DATE,
	finish_date DATE
);

INSERT INTO production_orders (description)
VALUES('Make for Infosys inc.');

select * from production_orders;

UPDATE production_orders
SET qty = 1;

ALTER TABLE production_orders 
ALTER COLUMN qty
SET NOT NULL;

UPDATE production_orders
SET material_id = 'ABC',
    start_date = '2015-09-01',
    finish_date = '2015-09-01'
returning*;


ALTER TABLE production_orders 
ALTER COLUMN material_id SET NOT NULL,
ALTER COLUMN start_date SET NOT NULL,
ALTER COLUMN finish_date SET NOT NULL;

----The special case of NOT NULL constraint

CREATE TABLE users (
  id serial PRIMARY KEY, 
  username VARCHAR (50), 
  password VARCHAR (50), 
  email VARCHAR (50), 
  CONSTRAINT username_email_notnull CHECK (
    NOT (
      (
        username IS NULL 
        OR username = ''
      ) 
      AND (
        email IS NULL 
        OR email = ''
      )
    )
  )
);

INSERT INTO users (username, email)
VALUES
	('user1', NULL),
	(NULL, 'email1@example.com'),
	('user2', 'email2@example.com'),
	('user3', '');


INSERT INTO users (username, email)
VALUES
	(NULL, NULL),
	(NULL, ''),
	('', NULL),
	('', '');
	
	
--PostgreSQL UNIQUE Constraint

CREATE TABLE person (
  id SERIAL PRIMARY KEY, 
  first_name VARCHAR (50), 
  last_name VARCHAR (50), 
  email VARCHAR (50) UNIQUE
);

INSERT INTO person(first_name,last_name,email)
VALUES('john','doe','j.doe@postgresqltutorial.com
	   
INSERT INTO person(first_name,last_name,email)
VALUES('Mujju','palaan','mujju@gmail.com')
	   returning*;
	   
select * from person;
	   
-----Creating a UNIQUE constraint on multiple columns

CREATE TABLE equipment (
  id SERIAL PRIMARY KEY, 
  name VARCHAR (50) NOT NULL, 
  equip_id VARCHAR (16) NOT NULL
);
	   
	   CREATE UNIQUE INDEX CONCURRENTLY equipment_equip_id 
ON equipment (equip_id);

ALTER TABLE equipment 
ADD CONSTRAINT unique_equip_id 
UNIQUE USING INDEX equipment_equip_id;

SELECT 
  datid, 
  datname, 
  usename, 
  state 
FROM 
  pg_stat_activity;

----PostgreSQL Primary Key

CREATE TABLE orders(
  order_id SERIAL PRIMARY KEY, 
  customer_id VARCHAR(255) NOT NULL, 
  order_date DATE NOT NULL
);

CREATE TABLE order_items(
  order_id INT, 
  item_no SERIAL, 
  item_description VARCHAR NOT NULL, 
  quantity INTEGER NOT NULL, 
  price DEC(10, 2), 
  PRIMARY KEY (order_id, item_no)
);

--3) Adding a primary key to an existing table
CREATE TABLE products_pk (
  product_id INT, 
  name VARCHAR(255) NOT NULL,
  description TEXT, 
  price DEC(10, 2) NOT NULL
);

ALTER TABLE products_pk 
ADD PRIMARY KEY (product_id);

---4) Adding an auto-incremented primary key to an existing table
CREATE TABLE vendors (
  name VARCHAR(255)
);

INSERT INTO vendors (name) 
VALUES 
  ('Microsoft'), 
  ('IBM'), 
  ('Apple'), 
  ('Samsung')
RETURNING *;

ALTER TABLE vendors 
ADD COLUMN vendor_id SERIAL PRIMARY KEY;

SELECT 
  vendor_id, 
  name 
FROM 
  vendors
  
ALTER TABLE vendors
DROP CONSTRAINT vendors_pkey;  


---PostgreSQL CHECK Constraints
CREATE TABLE employees_check (
  id SERIAL PRIMARY KEY, 
  first_name VARCHAR (50) NOT NULL, 
  last_name VARCHAR (50) NOT NULL,  
  birth_date DATE NOT NULL, 
  joined_date DATE NOT NULL, 
  salary numeric CHECK(salary > 0)
);

INSERT INTO employees_check (first_name, last_name, birth_date, joined_date, salary) 
VALUES ('John', 'Doe', '1972-01-01', '2015-07-01', 100000)
returning*;

select * from employees_check;

ALTER TABLE employees_check
ADD CONSTRAINT joined_date_check
CHECK ( joined_date >  birth_date );

INSERT INTO employees_check (first_name, last_name, birth_date, joined_date, salary) 
VALUES ('John', 'Doe', '1990-01-01', '2009-01-01', 100000);

ALTER TABLE employees_check
ADD CONSTRAINT first_name_check
CHECK ( LENGTH(TRIM(first_name)) >= 3);

INSERT INTO employees_check (first_name, last_name, birth_date, joined_date, salary) 
VALUES ('Abcd', 'Doe', '1990-01-01', '2008-01-01', 100000);

select * from employees_check;

ALTER TABLE employees_check
DROP CONSTRAINT first_name_check;

----PostgreSQL Foreign Key

CREATE TABLE customers_fk(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts_fk(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
        REFERENCES customers_fk(customer_id)
);


INSERT INTO customers_fk(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC')
	  returning*;	   
	   
INSERT INTO contacts_fk(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');

DELETE FROM customers_fk
WHERE customer_id = 1;

--SET NULL
CREATE TABLE customers_fkk(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts_fkk(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers_fkk(customer_id)
	  ON DELETE SET NULL
);

INSERT INTO customers_fkk(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC')
	   returning*;	   
	   
INSERT INTO contacts_fkk(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev')
	   returning*;

DELETE FROM customers_fkk
WHERE customer_id = 1;

SELECT * FROM contacts_fkk;


----Add a foreign key constraint to an existing table
ALTER TABLE child_table 
ADD CONSTRAINT constraint_name 
FOREIGN KEY (fk_columns) 
REFERENCES parent_table (parent_key_columns);
---------------------------------------------------

CREATE TABLE account (
  user_id SERIAL PRIMARY KEY, 
  username VARCHAR (50) UNIQUE NOT NULL, 
  password VARCHAR (50) NOT NULL, 
  email VARCHAR (255) UNIQUE NOT NULL, 
  created_at TIMESTAMP NOT NULL, 
  last_login TIMESTAMP
);


	   
