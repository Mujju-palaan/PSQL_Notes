---Section 4. Grouping Data

select * from products;
alter table products add column price int;

insert into products(price) values (345);
		
update products set price = 80000 where product_id=1;

update products set price = 120000 where product_id=2;
update products set price = 40000 where product_id=3;
update products set price = 20000 where product_id=4;
update products set price = 10000 where product_id=5;
update products set price = 5000 where product_id=6;


select price from products 
group by price 
order by price;

select product_id, sum(price)
from products
group by product_id
order by product_id;

----3) Using PostgreSQL GROUP BY clause with the JOIN clause

select* from students;

SELECT 	f_name || ' ' || l_name as full_name,
sum(id) as sum 
from students
natural inner join products 
group by full_name
order by sum desc;


select * from products;

select product_id, count(price) 
from products
group by product_id
order by product_id;

---5) Using PostgreSQL GROUP BY with multiple columns


select product_id, category_id, sum(price)
from products
group by product_id, category_id
order by  category_id;

----Introduction to PostgreSQL HAVING clause

select product_id, sum(price) sum
from products
group by product_id
having sum(price) > 10000
order by sum;

----2) PostgreSQL HAVING clause with COUNT example

select product_id, count(product_id)
from products
group by product_id;




