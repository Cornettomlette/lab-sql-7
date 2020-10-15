/*Instructions
Which last names are not repeated?
Which last names appear more than once?
Rentals by employee.
Films by year.
Films by rating.
Mean length by rating.
Which kind of movies (rating) have a mean duration of more than two hours?
List movies and add information of average duration for their rating and original language.
Which rentals are longer than expected?*/

USE sakila;

-- 1) Which last names are not repeated?
SELECT last_name, count(actor_id) AS lastname_count FROM actor
GROUP BY last_name
HAVING count(actor_id) = 1;

SELECT last_name, count(customer_id) AS lastname_count FROM customer
GROUP BY last_name
HAVING lastname_count = 1;

-- 2) Which last names appear more than once?
SELECT last_name, count(actor_id) AS lastname_count FROM actor
GROUP BY last_name
HAVING count(actor_id) > 1;

SELECT last_name, count(customer_id) AS lastname_count FROM customer
GROUP BY last_name
HAVING lastname_count > 1;

-- 3) Rentals by employee.
SELECT rental.staff_id, staff.first_name, staff.last_name, count(rental.rental_id) FROM rental
INNER JOIN staff ON rental.staff_id = staff.staff_id
GROUP BY staff_id, first_name, last_name;

/*SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;*/

-- 4) Films by year.
SELECT release_year, count(film_id) FROM film
GROUP BY release_year;

-- 5) Films by rating.
SELECT rating, count(film_id) FROM film
GROUP BY rating;

-- 6) Mean length by rating.
SELECT rating, avg(length) as average_length FROM film
GROUP BY rating;

-- 7) Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, avg(length) as average_length FROM film
GROUP BY rating
HAVING avg(length) > 120;
# there are no films with average duration more than 2 hours

-- 8) List movies and add information of average duration for their rating and release_year language.
SELECT title, rating, release_year, avg(length) OVER (PARTITION BY rating) AS avg_duration, avg(length) OVER (PARTITION BY release_year) AS year FROM film;

-- 9) Which rentals are longer than expected?*/
SELECT rental_id, rental.inventory_id, inventory.film_id, DATEDIFF(return_date, rental_date) AS real_rental_duration, rental_duration 
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id
WHERE DATEDIFF(return_date, rental_date) > rental_duration;
/*SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;*/
