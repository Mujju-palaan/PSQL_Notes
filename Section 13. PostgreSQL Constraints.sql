---Section 13. PostgreSQL Constraints

---PostgreSQL Primary Key
--1) Creating a table with a primary key that consists of one column
CREATE TABLE orders_pk(
  order_id SERIAL PRIMARY KEY, 
  customer_id VARCHAR(255) NOT NULL, 
  order_date DATE NOT NULL
);

---2) Creating a table with a primary key that consists of two columns
CREATE TABLE order_items_pk(
  order_id INT, 
  item_no SERIAL, 
  item_description VARCHAR NOT NULL, 
  quantity INTEGER NOT NULL, 
  price DEC(10, 2), 
  PRIMARY KEY (order_id, item_no)
);

---3) Adding a primary key to an existing table
CREATE TABLE products_pk (
  product_id INT, 
  name VARCHAR(255) NOT NULL,
  description TEXT, 
  price DEC(10, 2) NOT NULL
);

CREATE TABLE vendors_pk (
  name VARCHAR(255)
);

INSERT INTO vendors_pk (name) 
VALUES 
  ('Microsoft'), 
  ('IBM'), 
  ('Apple'), 
  ('Samsung')
RETURNING *;


ALTER TABLE vendors_pk 
ADD COLUMN vendor_id SERIAL PRIMARY KEY;

SELECT 
  vendor_id, 
  name 
FROM 
  vendors_pk;
  
----PostgreSQL Foreign Key
DROP TABLE IF EXISTS customers_fk;
DROP TABLE IF EXISTS contacts_fk;

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


create table contact_fk(
	contact_id int generated always as identity primary key,
	customer_id int,
	contact_name varchar(255) not null,
	phone varchar(15),
	email varchar(100),
	constraint fk foreign key(customer_id) references customers_fk(customer_id)	
);


INSERT INTO customers_fk(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contact_fk(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');
	  

DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
	  ON DELETE SET NULL
);


---------PostgreSQL DELETE CASCADE
CREATE TABLE departments_fk (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE employees_fk (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY(department_id) 
       REFERENCES departments_fk(id) 
       ON DELETE CASCADE
);

INSERT INTO departments_fk (name) 
VALUES 
    ('Engineering'),
    ('Sales')
RETURNING *;

INSERT INTO employees_fk (name, department_id) 
VALUES
    ('John Doe', 1),
    ('Jane Smith', 1),
    ('Michael Johnson', 2)
RETURNING *;


ALTER TABLE equipment 
ADD CONSTRAINT unique_equip_id 
UNIQUE USING INDEX equipment_equip_id ;
