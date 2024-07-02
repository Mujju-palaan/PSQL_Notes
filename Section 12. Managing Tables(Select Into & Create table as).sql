--PostgreSQL CREATE TABLE AS

CREATE TABLE action_film 
AS
SELECT
    film_id,
    title,
    release_year,
    length,
    rating
FROM
    film
INNER JOIN film_category USING (film_id)
WHERE
    category_id = 1;
	
SELECT * FROM action_film
ORDER BY title;


CREATE TABLE IF NOT EXISTS film_rating (rating, film_count) 
AS 
SELECT
    rating,
    COUNT (film_id)
FROM
    film
GROUP BY
    rating;
	
select * from film_rating




























































































