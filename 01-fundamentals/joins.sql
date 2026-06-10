-- ============================================================================
-- JOIN OPERATIONS - FUNDAMENTALS
-- ============================================================================
-- Master the different types of JOINs to combine data from multiple tables
-- INNER JOIN, LEFT JOIN, RIGHT JOIN, CROSS JOIN
-- ============================================================================

-- 1. INNER JOIN - ROWS THAT MATCH BOTH TABLES
-- Only returns rows where the join condition is TRUE in both tables

SELECT 
  a.actor_id,
  CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
  f.title
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
LIMIT 10;

-- Alternative INNER JOIN syntax
SELECT a.actor_id, a.first_name, f.title
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
LIMIT 10;

-- 2. LEFT JOIN - ALL ROWS FROM LEFT TABLE + MATCHING ROWS FROM RIGHT
-- Returns all rows from the left table, even if no match in right table

-- Find all customers and their rentals (including customers with no rentals)
SELECT 
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  r.rental_id,
  r.rental_date
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
ORDER BY c.customer_id
LIMIT 15;

-- LEFT JOIN with COUNT to find customers with NO rentals
SELECT 
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(r.rental_id) = 0;

-- 3. RIGHT JOIN - ALL ROWS FROM RIGHT TABLE + MATCHING ROWS FROM LEFT
-- Returns all rows from the right table, even if no match in left table

-- Find all films and their actors (including films with no actors)
SELECT 
  f.film_id,
  f.title,
  a.actor_id,
  CONCAT(a.first_name, ' ', a.last_name) AS actor_name
FROM film_actor fa
RIGHT JOIN film f ON fa.film_id = f.film_id
RIGHT JOIN actor a ON fa.actor_id = a.actor_id
LIMIT 10;

-- 4. MULTIPLE JOINS - CONNECT MORE THAN 2 TABLES

-- Get customer information with rental and payment details
SELECT 
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  r.rental_id,
  r.rental_date,
  p.amount,
  p.payment_date
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN payment p ON r.rental_id = p.rental_id
ORDER BY c.customer_id, r.rental_date
LIMIT 20;

-- 5. JOINING MULTIPLE TABLES WITH AGGREGATION
-- Get top films by rental count with category and actor information
SELECT 
  f.film_id,
  f.title,
  c.name AS category,
  COUNT(DISTINCT r.rental_id) AS rental_count,
  COUNT(DISTINCT a.actor_id) AS actor_count
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, c.name
ORDER BY rental_count DESC
LIMIT 10;

-- 6. CROSS JOIN - CARTESIAN PRODUCT
-- Returns every combination of rows from both tables (use with caution on large tables!)

-- Example: Every film in every store (theoretical inventory)
SELECT 
  f.title,
  s.store_id
FROM film f
CROSS JOIN store s
ORDER BY s.store_id, f.title
LIMIT 10;

-- 7. SELF JOIN - JOIN A TABLE TO ITSELF
-- Useful for hierarchical data or comparisons

-- Find actors who share the same first name
SELECT 
  a1.actor_id,
  CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
  a2.actor_id,
  CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM actor a1
INNER JOIN actor a2 ON a1.first_name = a2.first_name
  AND a1.actor_id < a2.actor_id
ORDER BY a1.first_name;

-- 8. COMPLEX MULTI-TABLE JOIN WITH WHERE AND HAVING

-- Find customers who spent more than $50 on PG-13 films
SELECT 
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  COUNT(DISTINCT f.film_id) AS pg13_films_rented,
  SUM(p.amount) AS total_spent_on_pg13
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN payment p ON r.rental_id = p.rental_id
WHERE f.rating = 'PG-13'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(p.amount) > 50
ORDER BY total_spent_on_pg13 DESC;

-- 9. USING ALIASES FOR READABILITY
-- Make complex joins easier to read

SELECT 
  c.customer_id,
  c.first_name,
  c.last_name,
  s.store_id,
  s.manager_staff_id,
  COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN store s ON c.store_id = s.store_id
GROUP BY c.customer_id, c.first_name, c.last_name, s.store_id, s.manager_staff_id
ORDER BY c.customer_id;

-- 10. AVOIDING DUPLICATE RESULTS IN JOINS
-- When multiple matching rows exist, you may get duplicate results

-- Problem: Films with multiple actors show multiple times
SELECT DISTINCT
  f.film_id,
  f.title,
  COUNT(DISTINCT a.actor_id) AS actor_count
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.film_id, f.title
ORDER BY actor_count DESC
LIMIT 10;

-- ============================================================================
-- PRACTICE EXERCISES
-- ============================================================================
-- Try these yourself:

-- Exercise 1: Get all films with their category names (INNER JOIN)
-- SELECT f.title, c.name FROM film f
-- INNER JOIN film_category fc ON f.film_id = fc.film_id
-- INNER JOIN category c ON fc.category_id = c.category_id
-- LIMIT 10;

-- Exercise 2: Find all customers and the count of their rentals (LEFT JOIN)
-- SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name), COUNT(r.rental_id)
-- FROM customer c
-- LEFT JOIN rental r ON c.customer_id = r.customer_id
-- GROUP BY c.customer_id;

-- Exercise 3: Get actor names with the films they appeared in
-- SELECT CONCAT(a.first_name, ' ', a.last_name), f.title
-- FROM actor a
-- INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
-- INNER JOIN film f ON fa.film_id = f.film_id
-- ORDER BY a.last_name, f.title
-- LIMIT 20;

-- Exercise 4: Find rentals with customer info and payment details
-- SELECT c.customer_id, c.first_name, c.last_name, r.rental_date, p.amount
-- FROM rental r
-- INNER JOIN customer c ON r.customer_id = c.customer_id
-- INNER JOIN payment p ON r.rental_id = p.rental_id
-- LIMIT 10;

-- Exercise 5: Compare rentals between two stores
-- SELECT s1.store_id, COUNT(r1.rental_id), COUNT(r2.rental_id)
-- FROM store s1 ... (more complex, try figuring it out!)
