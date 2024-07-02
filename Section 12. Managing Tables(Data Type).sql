----Section 12. Managing Tables

---PostgreSQL Data Types (Boolean, character, numeric, temporal, array, json, UUID, and special types)
Character types such as char, varchar, and text.
Numeric types such as integer and floating-point number.
Temporal types such as date, time, timestamp, and interval
UUID for storing Universally Unique Identifiers
Array for storing array strings, numbers, etc.
JSON stores JSON data
hstore stores key-value pair
Special types such as network address and geometric data.
-------------------------------------------------------------

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR (255) NOT NULL,
    pages SMALLINT NOT NULL CHECK (pages > 0)
);

CREATE TABLE cities (
    city_id serial PRIMARY KEY,
    city_name VARCHAR (255) NOT NULL,
    population INT NOT NULL CHECK (population >= 0)
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(5,2)
);

INSERT INTO products (name, price)
VALUES ('Phone',500.215), 
       ('Tablet',500.214);

SELECT * FROM products;


INSERT INTO products (name, price)
VALUES('Phone',123456.21);


UPDATE products
SET price = 'NaN'
WHERE id = 1;


CREATE TABLE documents (
  document_id SERIAL PRIMARY KEY, 
  header_text VARCHAR (255) NOT NULL, 
  posting_date DATE NOT NULL DEFAULT CURRENT_DATE
);
INSERT INTO documents (header_text) 
VALUES ('Billing to customer XYZ')
RETURNING *;


SELECT NOW();

SELECT NOW()::date;

SELECT CURRENT_DATE;

SELECT TO_CHAR(CURRENT_DATE, 'dd/mm/yyyy');

select * from persons

SELECT 
  first_name, 
  last_name, 
  now() - dob as diff 
FROM 
  persons;
  
SELECT
	id,
	first_name,
	last_name,
	AGE(dob)
FROM
	persons;


SELECT 
  id, 
  first_name, 
  last_name, 
  age('2015-01-01', dob) 
FROM 
  persons;

SELECT
	id,
	first_name,
	last_name,
	EXTRACT (YEAR FROM dob) AS YEAR,
	EXTRACT (MONTH FROM dob) AS MONTH,
	EXTRACT (DAY FROM dob) AS DAY
FROM
	persons;


CREATE TABLE shifts (
    id serial PRIMARY KEY,
    shift_name VARCHAR NOT NULL,
    start_at TIME NOT NULL,
    end_at TIME NOT NULL
);  

INSERT INTO shifts(shift_name, start_at, end_at)
VALUES('Morning', '08:00:00', '12:00:00'),
      ('Afternoon', '13:00:00', '17:00:00'),
      ('Night', '18:00:00', '22:00:00');
	  
select * from shifts;

--PostgreSQL TIME WITH TIME ZONE type

SELECT CURRENT_TIME;

SELECT CURRENT_TIME(5);

SELECT LOCALTIME;

SELECT LOCALTIME(0);

----2) Converting time to a different time zone

SELECT LOCALTIME AT TIME ZONE 'UTC-7';

---2) Extracting hours, minutes, and seconds from a time value
SELECT
    LOCALTIME,
    EXTRACT (HOUR FROM LOCALTIME) as hour,
    EXTRACT (MINUTE FROM LOCALTIME) as minute, 
    EXTRACT (SECOND FROM LOCALTIME) as second,
    EXTRACT (milliseconds FROM LOCALTIME) as milliseconds; 

---3) Arithmetic operations on time values
SELECT time '10:00' - time '02:00' AS result;

SELECT LOCALTIME + interval '2 hours' AS result;



CREATE TABLE timestamp_demo (
    ts TIMESTAMP, 
    tstz TIMESTAMPTZ
);

SET timezone = 'America/Los_Angeles';

SHOW TIMEZONE;

INSERT INTO timestamp_demo (ts, tstz)
VALUES('2016-06-22 19:10:25-07','2016-06-22 19:10:25-07');

SELECT 
   ts, tstz
FROM 
   timestamp_demo;
   
SET timezone = 'America/New_York';

SELECT 
  ts, 
  tstz 
FROM 
  timestamp_demo;
  
SELECT TIMEOFDAY();

SHOW TIMEZONE;

SELECT timezone('America/Los_Angeles','2016-06-01 00:00');

CREATE TABLE department (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO department(name)
VALUES('IT')
RETURNING *;

UPDATE department
SET name = 'ITD'
WHERE id = 1
RETURNING *;

---PostgreSQL Interval Data Type
SET intervalstyle = 'sql_standard';
SELECT 
  INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SET intervalstyle = 'postgres';
SELECT 
  INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SET intervalstyle = 'postgres_verbose';
SELECT 
  INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SET intervalstyle = 'iso_8601';
SELECT 
  INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';


CREATE TABLE event (
    id SERIAL PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    duration INTERVAL NOT NULL
);	

INSERT INTO event (event_name, duration) 
VALUES
    ('pgConf', '1 hour 30 minutes'),
    ('pgDAY', '2 days 5 hours')
RETURNING *;

SELECT
    event_name,
    duration,
    EXTRACT(DAY FROM duration) AS days,
    EXTRACT(HOUR FROM duration) AS hours,
    EXTRACT(MINUTE FROM duration) AS minutes
FROM event;


SELECT *
FROM event
WHERE duration > INTERVAL '1 day';


SELECT
    SUM(duration) AS total_duration
FROM event
;

-------Arrays--------------
CREATE TABLE contact (
  id SERIAL PRIMARY KEY, 
  name VARCHAR (100), 
  phones TEXT []
);


INSERT INTO contact (name, phones)
VALUES('John Doe',ARRAY [ '(408)-589-5846','(408)-589-5555' ]);

INSERT INTO contact (name, phones)
VALUES('Lily Bush','{"(408)-589-5841"}'),
      ('William Gate','{"(408)-589-5842","(408)-589-58423"}')
returning*;

SELECT 
  name, 
  phones 
FROM 
  contact;


SELECT 
  name, 
  phones [ 1 ] 
FROM 
  contact;
  

SELECT 
  name 
FROM 
  contact 
WHERE 
  phones [ 2 ] = '(408)-589-58423';


UPDATE contact
SET phones [2] = '(408)-589-5843'
WHERE ID = 3
RETURNING *;

UPDATE 
  contact 
SET 
  phones = '{"(408)-589-5843"}' 
WHERE 
  id = 3
RETURNING *;

----PostgreSQL JSON {"title": "Chamber Italian", "release_year": 2006, "length": 117}

CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    properties JSONB
);

INSERT INTO products(name, properties)
VALUES('Ink Fusion T-Shirt','{"color": "white", "size": ["S","M","L","XL"]}')
RETURNING *;

INSERT INTO products(name, properties)
VALUES('ThreadVerse T-Shirt','{"color": "black", "size": ["S","M","L","XL"]}'),
      ('Design Dynamo T-Shirt','{"color": "blue", "size": ["S","M","L","XL"]}')
RETURNING *;

SELECT id, name, properties
FROM products;

SELECT 
  id, 
  name, 
  properties -> 'color' color 
FROM 
  products;


----2) Storing JSON arrays example
CREATE TABLE contacts_json(
   id SERIAL PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   phones JSONB
);

INSERT INTO contacts_json(name, phones) 
VALUES
   ('John Doe','["408-111-2222", "408-111-2223"]'),
   ('Jane Doe','["212-111-2222", "212-111-2223"]')
RETURNING *;








































