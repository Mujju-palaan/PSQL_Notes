---Section 6. Grouping sets, Cubes, and Rollups ---go for last table

create table sales(
	brand varchar(255) not null,
	segment varchar(255) not null,
	quantity int not null,
	PRIMARY KEY (brand,segment)
);


INSERT INTO sales (brand, segment, quantity)
VALUES
    ('ABC', 'Premium', 100),
    ('ABC', 'Basic', 200),
    ('XYZ', 'Premium', 100),
    ('XYZ', 'Basic', 300)
RETURNING *;

select * from sales;

----Introduction to PostgreSQL GROUPING SETS

select brand, segment, sum(quantity)
from sales
group by brand, segment;


select brand, sum(quantity)
from sales
group by brand;

select segment, sum(quantity) 
from sales
group by segment;


SELECT SUM (quantity) FROM sales;

------------------------------------------------
select brand,segment, sum(quantity)
from sales
group by brand, segment

UNION ALL

select brand, NULL, sum(quantity)
from sales
group by brand

UNION ALL

select NULL, segment, SUM(quantity)
from sales
group by segment

UNION ALL

select NULL,NULL, sum(quantity)
from sales;
--------------------------------------------------


----GROUPING SETS
 
select brand, segment, sum(quantity)
FROm sales
group by 
	grouping sets (
		(brand, segment),
		(brand),
		(segment),
		()
	);
	
	
	
SELECT
	GROUPING(brand) grouping_brand,
	GROUPING(segment) grouping_segment,
	brand,
	segment,
	SUM (quantity)
FROM
	sales
GROUP BY
	GROUPING SETS (
		(brand),
		(segment),
		()
	)
ORDER BY
	brand,
	segment;


----PostgreSQL CUBE examples

select * from sales;

select brand, segment, quantity, count(brand) sum
from sales 
group by 
CUBE (brand, segment, quantity);


--------NEW table (Grouping set, ROLLUP, CUBE)------------

CREATE table sale (
	continent varchar(50),
	country varchar(50),
	city varchar(50),
	units_sold int
);

insert into sale values 
('North America', 'Canada','Toronto',10000),
('North America', 'Canada','Montreal',5000),
('North America', 'Canada','Vancouver',15000),
('Asia', 'China','Hong Kong',7000),
('Asia', 'China','shanghai',3000),
('Asia', 'Japan','Tokyo',5000),
('Europe', 'UK','Paris',6000),
('Europe', 'UK','manchester',12000),
('Europe', 'France','Paris',5000);

select * from sale order by continent,country,city;

select continent, sum(units_sold) from sale group by continent;

select country, sum(units_sold) from sale group by country;

select city, sum(units_sold) from sale group by city;

select continent,country,city, SUM(units_sold) from sale
group by GROUPING SETS (continent,country,city);

select continent,country,city, SUM(units_sold) from sale
group by GROUPING SETS (continent,country,city,());

select continent,country,city, SUM(units_sold) from sale
group by ROLLUP (continent,country,city);

select continent,country,city, SUM(units_sold) from sale
group by CUBE (continent,country,city);















































































