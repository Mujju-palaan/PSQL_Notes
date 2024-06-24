--------------  Section 2. Filtering Data -------------------and

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
					
select * from students ;
drop table student;

insert into students(f_name,l_name,phone,address,email,blood_group) 
values
	('Mohammed','Mujahid',7867837866,'Dilkushnagar','mujju@gmail.com','B+'),
	('Mohammed','Muddassir',1233,'HYD','Muddassir@gmail.com','AB+'),
	('Mohammed','Muzzamil',7899333,'IDPL','Muzzamil@gmail.com','A+'),
	('Mujju','Sheikh',6789,'darga','Sheikh@gmail.com','B+'),
	('Abid','Sheikh',3456,'Nagpur','Abid@gmail.com','AB-'),
	('Yo','Homie',12345678,'Homie','Homie@gmail.com','AB+');
	
	




	
