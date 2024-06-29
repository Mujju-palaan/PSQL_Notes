----Section 7. Subquery

select * from sale;

alter table sale add column country_id int;

update sale set country_id=1 where city='Toronto';


SELECT 
  country_id 
from 
  country 
where 
  country = 'United States';
  

select * from city;

SELECT 
  city 
FROM 
  city 
WHERE 
  country_id = 103 
ORDER BY 
  city;
  

select city from city 
where 
	country_id = (
		select country_id from country
		where country = 'United States'
	)
order by city;

SELECT 
  country_id 
FROM 
  country 
WHERE 
  country = 'United States';
  

-----------2) Using a subquery with the IN operator

select * from film_category;
select * from category;

select film_id from film_category
Inner join category using (category_id)
where name='Action';


select * from film;

select film_id, title from film;

SELECT 
  film_id, 
  title 
FROM 
  film 
WHERE 
  film_id IN (
    SELECT 
      film_id 
    FROM 
      film_category 
      INNER JOIN category USING(category_id) 
    WHERE 
      name = 'Action'
  ) 
ORDER BY 
  film_id;

------------PostgreSQL Correlated Subquery-----------------

SELECT film_id, title, length, rating
FROM film f
WHERE length > (
    SELECT AVG(length)
    FROM film
    WHERE rating = f.rating
);



SELECT film_id, title, length, rating
FROM film f
WHERE length > (150)


------------PostgreSQL ANY Operator It is commonly used in combination with comparison operators such as =, <, >, <=, >=, and <>.

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

CREATE TABLE managers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO employees (first_name, last_name, salary) 
VALUES
('Bob', 'Williams', 45000.00),
('Charlie', 'Davis', 55000.00),
('David', 'Jones', 50000.00),
('Emma', 'Brown', 48000.00),
('Frank', 'Miller', 52000.00),
('Grace', 'Wilson', 49000.00),
('Harry', 'Taylor', 53000.00),
('Ivy', 'Moore', 47000.00),
('Jack', 'Anderson', 56000.00),
('Kate', 'Hill',  44000.00),
('Liam', 'Clark', 59000.00),
('Mia', 'Parker', 42000.00);

INSERT INTO managers(first_name, last_name, salary) 
VALUES
('John', 'Doe',  60000.00),
('Jane', 'Smith', 55000.00),
('Alice', 'Johnson',  58000.00);


SELECT * FROM employees;

SELECT * FROM managers;

----1) Using ANY operator with the = operator example

SELECT 
  * 
FROM 
  employees 
WHERE 
  salary = ANY (
    SELECT 
      salary 
    FROM 
      managers
  );
  
 
SELECT salary FROM managers;

-----2) Using ANY operator with > operator example

select * from employees
where
	salary > ANY (
	select salary from managers
	);


select * from employees
where
	salary < ANY (
	select salary from managers
	);
	
	
----PostgreSQL ALL Operator

SELECT 
  * 
FROM 
  employees 
WHERE 
  salary < ALL(
    select 
      salary 
    from 
      managers
  )
ORDER BY salary DESC


-------------PostgreSQL EXISTS Operator
select * from payment;

SELECT 
  EXISTS(
    SELECT 
      1 
    FROM
      payment 
    WHERE 
      amount = 0
  );



























































































