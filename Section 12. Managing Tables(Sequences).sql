----PostgreSQL Sequences

Create Sequence tbl_emp_seq
	start with 1
	increment by 1
	minvalue 1
	maxvalue 10
	cycle;
	
select nextval('tbl_emp_seq');

drop sequence tbl_emp_seq;

Create Sequence tbl_emp_seq_nocycle
	start with 1
	increment by 1
	minvalue 1
	maxvalue 10
	no cycle;
	
select nextval('tbl_emp_seq_nocycle');

create table emp(
	emp_id int default nextval('tbl_emp_seq'),
	emp_name varchar(50),
	salary numeric(5,2)
);
insert into emp(emp_name,salary)
values ('Mujju',100.56),
		('Sohail',200.87),
		('Keff',500.99);
		
select * from emp;


CREATE SEQUENCE mysequence
INCREMENT 5
START 100;

SELECT nextval('mysequence');


CREATE SEQUENCE three
INCREMENT -1
MINVALUE 1 
MAXVALUE 3
START 3
CYCLE;

SELECT nextval('three');


CREATE TABLE order_details(
    order_id SERIAL,
    item_id INT NOT NULL,
    item_text VARCHAR NOT NULL,
    price DEC(10,2) NOT NULL,
    PRIMARY KEY(order_id, item_id)
);

CREATE SEQUENCE order_item_id
START 10
INCREMENT 10
MINVALUE 10
OWNED BY order_details.item_id;

INSERT INTO 
    order_details(order_id, item_id, item_text, price)
VALUES
    (100, nextval('order_item_id'),'DVD Player',100),
    (100, nextval('order_item_id'),'Android TV',550),
    (100, nextval('order_item_id'),'Speaker',250);
	
	
SELECT
    order_id,
    item_id,
    item_text,
    price
FROM
    order_details;
	
------Listing all sequences in a database
SELECT
    relname sequence_name
FROM 
    pg_class 
WHERE 
    relkind = 'S';
	
----PostgreSQL DROP SEQUENCE statement examples
DROP TABLE order_details;


