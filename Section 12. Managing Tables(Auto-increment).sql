---Using PostgreSQL SERIAL to Create Auto-increment Column(SMALLSERIAL,SERIAL,BIGSERIAL)

---Introduction to the PostgreSQL SERIAL pseudo-type

CREATE TABLE table_name(
    id SERIAL
);

---------------------------------
CREATE SEQUENCE table_name_id_seq;

CREATE TABLE table_name (
    id integer NOT NULL DEFAULT nextval('table_name_id_seq')
);

ALTER SEQUENCE table_name_id_seq
OWNED BY table_name.id;
---------------------------------------

CREATE TABLE fruits(
   id SERIAL PRIMARY KEY,
   name VARCHAR NOT NULL
);

INSERT INTO fruits(name) 
VALUES('Orange');

INSERT INTO fruits(id,name) 
VALUES(DEFAULT,'Apple')
returning*;

SELECT * FROM fruits;

---2) Getting the sequence name
SELECT currval(pg_get_serial_sequence('fruits', 'id'));

---3) Retrieving the generated value
INSERT INTO fruits(name) 
VALUES('Banana')
RETURNING id;

--4) Adding a serial column to an existing table
CREATE TABLE baskets(
    name VARCHAR(255) NOT NULL
);

ALTER TABLE baskets
ADD COLUMN id SERIAL PRIMARY KEY;





























































