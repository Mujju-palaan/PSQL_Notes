---Section 3. Joining Multiple Tables

CREATE table basket_a (a INT primary key, fruit_a varchar(100) not null);

create table basket_b (b int primary key, fruit_b varchar(100) not null);

insert into basket_a (a,fruit_a) values (1, 'Apple'), (2,'Orange'),(3, 'Banana'),(4,'Cucumber');

select * from basket_a;

insert into basket_b (b,fruit_b) values (1, 'Orange'), (2,'Apple'),(3, 'Watermelon'),(4,'Pear');

select * from basket_b;

----------------PostgreSQL inner join

select a,fruit_a,b,fruit_b from basket_a inner join basket_b ON fruit_a = fruit_b;
	
	select a,fruit_a,b,fruit_b from basket_a inner join basket_b ON a = b ;

----------------PostgreSQL left join

select a,fruit_a,b,fruit_b from basket_a left join basket_b on a = b ;

select a, fruit_a , b, fruit_b from basket_a left join basket_b on fruit_a = fruit_b;

select a, fruit_a ,b, fruit_b from basket_b left join basket_a on fruit_a = fruit_b;

select a,fruit_a,b,fruit_b from basket_a left join basket_b on fruit_a = fruit_b where b is null;

----------------PostgreSQL right join

select a,fruit_a,b,fruit_b from basket_a right join basket_b on fruit_a = fruit_b;
	
select a,fruit_a,b,fruit_b from basket_a right join basket_b on fruit_a = fruit_b where a is null;

----------------PostgreSQL full outer join

select a,fruit_a,b,fruit_b from basket_a full outer join basket_b on fruit_a = fruit_b;

select a,fruit_a,b,fruit_b from basket_a full outer join basket_b on fruit_a = fruit_b where a is null or b is null;


----------PostgreSQL Table Aliases

select s.f_name from students as s order by s.f_name limit 5;

select s.l_name from students as s order by s.l_name limit 5;

---2) Using table aliases in join clauses

select a.a,a.fruit_a,b.b,b.fruit_b from basket_a as a inner join basket_b as b  on fruit_a = fruit_b  order by b.b;

select a.a,a.fruit_a,b.b,b.fruit_b from basket_a as a inner join basket_b as b  on fruit_a = fruit_b  order by b.b desc;

select a.a,a.fruit_a,b.b,b.fruit_b from basket_a as a inner join basket_b as b  on a.fruit_a = b.fruit_b  AND a.a<>b.b;

----select a.a,a.fruit_a,b.b,b.fruit_b from basket_a as a inner join basket_b b using (b.b) ;


--*************2) Using PostgreSQL INNER JOIN to join three tables

create table basket_c (c int not null, fruit_c text not null);
drop table c

insert into basket_c(c,fruit_c) values (1,'Mango'),(2,'papaya'),(3,'Apple'),(4,'Orange');

select * from basket_c;

select a.a,a.fruit_a,b.b,b.fruit_b,c.c,c.fruit_c from basket_c as c 
													inner join basket_a as a using(a);
													

select * from students;
select * from colors;
select * from employee;

alter table employee rename column emp_id to id;

select e.id, e.first_name || ' ' || e.last_name as full_name,
		c.id, c.bcolor,c.fcolor,
		s.id, s.f_name || ' ' || s.l_name as stud_name
from students as s 
inner join colors as c using(id)
inner join employee as e using(id);

----2) Using PostgreSQL LEFT JOIN with WHERE clause

select s.id, s.f_name || ' ' || s.l_name,
		c.id,c.bcolor,c.fcolor
from students as s
left join colors as c using(id)
where bcolor is NULL OR fcolor is NULL
order by S.id desc;


-----PostgreSQL self-join examples

CREATE TABLE emp (
  employee_id INT PRIMARY KEY, 
  first_name VARCHAR (255) NOT NULL, 
  last_name VARCHAR (255) NOT NULL, 
  manager_id INT
  ---FOREIGN KEY (manager_id) REFERENCES employee (employee_id) ON DELETE CASCADE
);

select * from emp;
drop table emp;

insert into emp (employee_id, first_name, last_name, manager_id)
values
	(1, 'Windy', 'Hays', NULL), 
  (2, 'Ava', 'Christensen', 1), 
  (3, 'Hassan', 'Conner', 1), 
  (4, 'Anna', 'Reeves', 2), 
  (5, 'Sau', 'Norman', 2), 
  (6, 'Kelsie', 'Hays', 3), 
  (7, 'Tory', 'Goff', 3), 
  (8, 'Salley', 'Lester', 3);
  
select 
e.first_name || ' ' || e.last_name as employee,
m.first_name || ' ' || m.last_name as manager
from emp as e
inner join emp as m on m.employee_id = e.employee_id 
order by manager;


----PostgreSQL FULL OUTER JOIN

select s.f_name,s.l_name,e.employee_id from students s
full outer join emp e on e.employee_id = s.id;

select s.f_name,s.l_name,e.employee_id from students s
full outer join emp e on  s.id=e.employee_id;


create table departments (
	department_id serial primary key,
	department_name varchar(50) not null
);

CREATE TABLE employees (
  employee_id serial PRIMARY KEY, 
  employee_name VARCHAR (255), 
  department_id INTEGER
);

INSERT INTO departments (department_name) 
VALUES 
  ('Sales'), 
  ('Marketing'), 
  ('HR'), 
  ('IT'), 
  ('Production');
  
INSERT INTO employees (employee_name, department_id) 
VALUES 
  ('Bette Nicholson', 1), 
  ('Christian Gable', 1), 
  ('Joe Swank', 2), 
  ('Fred Costner', 3), 
  ('Sandra Kilmer', 4), 
  ('Julia Mcqueen', NULL);	
  
  
SELECT * FROM departments;
SELECT * FROM employees;

---1) Basic FULL OUTER JOIN examaple

select e.employee_name, d.department_name
from employees e
FULL OUTER JOIN departments d
using(department_id);


---2) Using FULL OUTER JOIN with WHERE clause example

select e.employee_name,d.department_name
from employees as e
full outer join departments as d
using(department_id)
where employee_name is null;

select e.employee_name,d.department_name
from employees as e
full outer join departments as d
using(department_id)
where employee_name is not null;

select e.employee_name,d.department_name
from employees as e
full outer join departments as d
using(department_id)
where employee_name is not null AND department_name is not NULL;

select e.employee_name,d.department_name
from employees as e
full outer join departments as d
using(department_id)
where department_name is null;

---Introduction to the PostgreSQL CROSS JOIN clause

CREATE TABLE
  T1 (LABEL CHAR(1) PRIMARY KEY);

CREATE TABLE
  T2 (score INT PRIMARY KEY);
  
 INSERT INTO
  T1 (LABEL)
VALUES
  ('A'),
  ('B');

INSERT INTO
  T2 (score)
VALUES
  (1),
  (2),
  (3);
  
select * from T1 cross join T2;


----Introduction to PostgreSQL NATURAL JOIN clause

create table categories(
	category_id serial primary key,
	category_name varchar(255) not null
);

CREATE TABLE PRODUCTS (
	product_id serial primary key,
	product_name varchar(225) not null,
	category_id int not null,
	foreign key (category_id) references categories (category_id)
);


INSERT INTO categories (category_name) 
VALUES 
  ('Smartphone'), 
  ('Laptop'), 
  ('Tablet'),
  ('VR')
RETURNING *;


INSERT INTO products (product_name, category_id) 
VALUES 
  ('iPhone', 1), 
  ('Samsung Galaxy', 1), 
  ('HP Elite', 2), 
  ('Lenovo Thinkpad', 2), 
  ('iPad', 3), 
  ('Kindle Fire', 3)
RETURNING *;
		

select * from products 
Natural join categories;

select * from products 
inner join categories using(category_id);

select * from products
NATURAL inner join categories;

select * from products 
left join categories using(category_id);

select * from products
NATURAL left join categories;

select * from products 
right join categories using(category_id);

select * from products
NATURAL right join categories;









	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	