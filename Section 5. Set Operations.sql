---Section 5. Set Operations

---Introduction to PostgreSQL UNION operator

CREATE TABLE top_rated_films(
  title VARCHAR NOT NULL, 
  release_year SMALLINT
);

CREATE TABLE most_popular_films(
  title VARCHAR NOT NULL, 
  release_year SMALLINT
);

INSERT INTO top_rated_films(title, release_year) 
VALUES 
   ('The Shawshank Redemption', 1994), 
   ('The Godfather', 1972), 
   ('The Dark Knight', 2008),
   ('12 Angry Men', 1957);

INSERT INTO most_popular_films(title, release_year) 
VALUES 
  ('An American Pickle', 2020), 
  ('The Godfather', 1972), 
  ('The Dark Knight', 2008),
  ('Greyhound', 2020);
  
  
select * from top_rated_films;

select * from most_popular_films;

----1) Basic PostgreSQL UNION example

select * from top_rated_films
UNION
select * from most_popular_films
order by release_year;

--2) PostgreSQL UNION ALL example

select * from top_rated_films
UNION ALL
select * from most_popular_films;


--Introduction to PostgreSQL INTERSECT operator

---1) Basic INTERSECT operator example

select * from most_popular_films
INTERSECT
select * from top_rated_films;


select * from most_popular_films
INTERSECT
select * from top_rated_films
order by release_year;

---Introduction to the PostgreSQL (EXCEPT) operator

---1) Basic EXCEPT operator example

SELECT * FROM top_rated_films
EXCEPT 
SELECT * FROM most_popular_films;

--2) Using the EXCEPT operator with the ORDER BY clause

SELECT * FROM top_rated_films
EXCEPT 
SELECT * FROM most_popular_films
ORDER BY title;

SELECT * FROM top_rated_films
EXCEPT 
SELECT * FROM most_popular_films
ORDER BY release_year;































































































