---Section 11. Import & ExporDatat 

---Import CSV File Into PostgreSQL Table

CREATE TABLE persons (
  id SERIAL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  email VARCHAR(255),
  PRIMARY KEY (id)
);

---------------------------------------------------
COPY persons(first_name, last_name, dob, email)
FROM 'C:\Users\mujah\Downloads\persons.csv'
DELIMITER ','
CSV HEADER;
--------------------------------------------------

---Import CSV file into a table using pgAdmin

TRUNCATE TABLE persons 
RESTART IDENTITY;

select * from persons;



------Export PostgreSQL Table to CSV File

insert into persons(first_name, last_name, dob, email) values ('Mujju','Palaan','1997-11-03','mujju@gmail.com');

COPY persons 
TO 'C:\Users\mujah\Downloads\persons.csv' 
DELIMITER ',' 
CSV HEADER;


insert into persons(first_name, last_name, dob, email) values ('Kefaya','Ghouri','1997-11-03','keff@gmail.com');


COPY persons(first_name,last_name,email) 
TO 'C:\Users\mujah\Downloads\persons_partial_db.csv' DELIMITER ',' CSV HEADER;


























































































































