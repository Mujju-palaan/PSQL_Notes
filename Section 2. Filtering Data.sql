--------------  Section 2. Filtering Data ---------------

= ----	Equal
> ----	Greater than
< ----	Less than
>= ----	Greater than or equal
<= ----	Less than or equal
<> or != ----	Not equal
AND	 ----Logical operator AND
OR	 ------Logical operator OR
IN	------Return true if a value matches any value in a list
BETWEEN	-----Return true if a value is between a range of values
LIKE	------Return true if a value matches a pattern
IS NULL	------Return true if a value is NULL
NOT	-------Negate the result of other operators

----PostgreSQL WHERE

create table students(id serial primary key, f_name varchar(50) not null, l_name varchar(50) not null,
					phone bigint not null, address text not null, email text not null, Blood_group text not null);
					
select * from students;
drop table student;

insert into students(f_name,l_name,phone,address,email,blood_group) 
values
	('Mohammed','Mujahid',7867837866,'Dilkushnagar','mujju@gmail.com','B+'),
	('Mohammed','Muddassir',1233,'HYD','Muddassir@gmail.com','AB+'),
	('Mohammed','Muzzamil',7899333,'IDPL','Muzzamil@gmail.com','A+'),
	('Mujju','Sheikh',6789,'darga','Sheikh@gmail.com','B+'),
	('Abid','Sheikh',3456,'Nagpur','Abid@gmail.com','AB-'),
	('Yo','Homie',12345678,'Homie','Homie@gmail.com','AB+');
	
	

select f_name, l_name from students where f_name='Mujju';

select * from students where f_name = 'Mohammed';

select * from students where f_name='Mohammed' and blood_group='A+';   -----AND

select * from students where f_name='Mohammed' or l_name='Sheikh';     -----OR

select f_name,l_name from students where f_name IN ('Yo');      ------IN

select f_name,l_name from students where f_name IN ('Mujju','Abid');

select f_name,l_name from students where f_name IN ('Mujju','Abid','Yo');


----Using the WHERE clause with the LIKE operator example-----------------

select * from students;

select f_name,l_name from students where f_name like 'M%';

select f_name,l_name from students where f_name  like '%d' and l_name like '%d'

----Using the WHERE clause with the BETWEEN operator example

select f_name, length(f_name) as name_length from students             -------LIKE,AND,BETWEEN,Order by
	where f_name LIKE 'A%' AND length(f_name) between 3 AND 6        
	ORDER by name_length;

select l_name, length(l_name) as name_length from students
	where length(l_name) between 3 AND 6 Order by name_length;

-------Using the WHERE clause with the not equal operator (<>) example

select f_name, l_name from students where f_name LIKE 'M%' AND l_name <> 'Muddassir' ; 

-----PostgreSQL AND Operator

select 1 = 1 as result;

select true and true as result;

select true AND false as result;

select true AND null as result;

select false AND false as result;

select false and null as result;

select null and null as result;


---------Using the AND operator in the WHERE clause

select * from students;

select f_name, l_name, length(address) as add, address from students where length(address)<6 AND length(f_name)<=5 ;

select f_name, l_name from students where f_name LIKE 'Moh%' AND l_name LIKE 'Mu%';

select address, length(address) from students;

------PostgreSQL OR Operator

select true OR true as result;

select true OR false as result;

select true OR null as result;

select null OR null as result;

select false OR false AS result;

select false OR null as result;

select false OR false as result;

-------2) Using the OR operator in the WHERE clause  ------------------------
select * from students;

select f_name, l_name from students WHERE f_name='Mujju' OR l_name='Sheikh';

select * from students where f_name LIKE 'Mo%' OR address='Nagpur';


----------Introduction to PostgreSQL LIMIT clause

select id,f_name,l_name from students order by id LIMIT 3;

select * from students order by length(f_name)  LIMIT 3;

----2) Using the LIMIT clause with the OFFSET clause example

select * from students limit 3 OFFSET 3;     -------(OFFSET 3 : Shows the values after 3)

select * from students limit 2 offset 4;


-------3) Using LIMIT OFFSET to get top/bottom N rows

select * from students order by id desc LIMIT 4;

select f_name,length(f_name) as ff from students order by ff LIMIT 4;

select l_name,length(l_name) as ll from students order by ll LIMIT 4;

-----------PostgreSQL FETCH

select * from students order by id FETCH first row only;

select * from students order by id FETCH first 4 rows only;

select * from students order by id FETCH first 2 rows only;

select * from students order by id offset 2 fetch first 2 rows only;

 
-----------------  PostgreSQL IN operator

select id,f_name from students where id in (1,2,3);

select id,f_name,l_name from students where id in (2,4,6);

select f_name,l_name,address from students where f_name in ('Mujju','Abid');

select id,f_name,l_name from students where id = 1 or id = 2 or id = 3;

-----2) Using the PostgreSQL IN operator with a list of strings

select f_name,l_name from students where f_name in ('Mujju','Abid') order by l_name

select f_name,l_name from students where f_name in ('Mujju','Abid','Yo') order by l_name


-------3) Using the PostgreSQL IN operator with a list of dates
select * from students;

alter table students add column Date_ text;

update students set date_ = '1997-11-03' where id = 1;

update students set date_ = '2003-09-18' where id = 3;
update students set 					date_ = '1999-06-21' where id = 2;
update students set 					date_ = '1997-11-03' where id = 4;
update students set 					date_ = '2002-04-11' where id = 5;
update students set date_ = '1111-01-01' where id = 6;
					
alter table students rename column date_ to DOB;

select * from students where dob::date in ('1997-11-03','1111-01-01');

select * from students where id not in (1,2,3);

select id,f_name,l_name from students where id <> 1 and id <> 2 and id <> 3;

select id,f_name,l_name from students where id <> 1 and id <> 2 and id > 4;

----Introduction to the PostgreSQL BETWEEN operator

-----1) Using the PostgreSQL BETWEEN operator with numbers

select id,f_name,l_name from students where id between 1 AND 5 order by id;


select * from students where dob between '1997-11-03' AND '2003-09-18';


select * from students where dob between '1997-11-03' AND '2003-09-18' AND ID>3 ORDER BY dob;


----------PostgreSQL LIKE

select f_name,l_name from students where f_name LIKE 'Mo%';

select 'Apple' LIKE 'Apple' as result;

select 'Apple' LIKE 'A%' as result;

-----------2) Using the LIKE operator with table data

select f_name,l_name from students where f_name LIKE '%j%' ;

select f_name,l_name from students where l_name LIKE '%u%' order by f_name;

select f_name,l_name from students where f_name LIKE '_oham%' order by f_name;

select l_name from students where l_name LIKE '_u%' order by l_name;

---------------4) PostgreSQL NOT LIKE examples

select f_name,l_name from students where f_name Not LIKE 'Mujju' order by f_name;

select f_name,l_name from students where f_name Not LIKE 'Mo%' order by f_name;

select f_name,l_name from students where l_name Not LIKE 'S%' order by l_name;

------------ILIKE

select f_name,l_name from students where f_name  ILIKE 'MUJJU' order by f_name;  -----Mujju(case sensiii)


~~	LIKE
~~*	ILIKE
!~~	NOT LIKE
!~~*	NOT ILIKE

select * from students where f_name ~~ 'M%';

select * from students where l_name ~~* 'MUJAhid';

-----------------Introduction to NULL

select null=null as result;

select address,id from students where id is null order by id;























































	
