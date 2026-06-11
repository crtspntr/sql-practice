-- ============================================================================
-- AGGREGATE FUNCTIONS - FUNDAMENTALS
-- ============================================================================
-- Use aggregate functions to summarize data
-- COUNT, SUM, AVG, MIN, MAX with GROUP BY and HAVING
-- ============================================================================

-- 1. COUNT - COUNT ROWS
SELECT COUNT(*) FROM film;  -- Total films
SELECT COUNT(*) FROM actor; -- total actor cp

SELECT COUNT(*) FROM actor_backup;
SHOW TABLES; -- getting tables cp, created docs filee for tis docs/database-schema.md

-- Count specific column (excludes NULL)
SELECT COUNT(email) FROM customer;  -- Customers with email addresses

-- Count distinct values
SELECT COUNT(DISTINCT rating) FROM film;  -- How many different ratings

-- 2. SUM - ADD VALUES
SELECT SUM(amount) FROM payment;  -- Total revenue

-- Sum with WHERE condition
SELECT SUM(amount) FROM payment WHERE payment_date LIKE '2005-05%';

-- 3. AVG - CALCULATE AVERAGE
SELECT AVG(rental_rate) FROM film;  -- Average rental rate

SELECT AVG(length) FROM film WHERE rating = 'PG';  -- Avg length of PG films

-- 4. MIN and MAX - FIND EXTREMES
SELECT MIN(rental_rate), MAX(rental_rate) FROM film;

SELECT MIN(rental_date), MAX(rental_date) FROM rental;  -- Date range

-- 5. GROUP BY - AGGREGATE BY CATEGORIES
-- Summarize data by one or more columns

-- Count films by rating
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- Average rental rate by rating
SELECT rating, AVG(rental_rate) AS avg_rate
FROM film
GROUP BY rating;

-- Multiple GROUP BY columns
SELECT rating, length, COUNT(*) AS film_count
FROM film
GROUP BY rating, CASE 
  WHEN length < 60 THEN 'Short'
  WHEN length < 120 THEN 'Medium'
  ELSE 'Long'
END
ORDER BY rating, length;

-- 6. HAVING - FILTER GROUPS
-- Use WHERE to filter rows BEFORE grouping
-- Use HAVING to filter groups AFTER aggregation

-- Find ratings with MORE than 100 films
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
HAVING COUNT(*) > 100;

-- Find categories with average rental rate > $3
SELECT c.name, AVG(f.rental_rate) AS avg_rate
FROM film_category fc
JOIN film f ON fc.film_id = f.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.rental_rate) > 3.0;

-- 7. COMBINING WHERE AND HAVING
-- WHERE filters before grouping, HAVING filters after

-- Find categories with average rental rate > $3 (only PG-13 films)
SELECT c.name, AVG(f.rental_rate) AS avg_rate, COUNT(*) AS film_count
FROM film_category fc
JOIN film f ON fc.film_id = f.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE f.rating = 'PG-13'
GROUP BY c.name
HAVING COUNT(*) > 5
ORDER BY avg_rate DESC;

-- 8. AGGREGATES WITH DISTINCT
-- Count unique values in aggregation

-- How many different rental rates exist?
SELECT COUNT(DISTINCT rental_rate) FROM film;

-- Total revenue by country
SELECT co.country, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
JOIN address a ON s.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN country co ON ct.country_id = co.country_id
GROUP BY co.country
ORDER BY total_revenue DESC;

-- 9. REAL WORLD EXAMPLES

-- Top 10 customers by total rental spending
SELECT c.customer_id, 
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       COUNT(r.rental_id) AS rental_count,
       SUM(p.amount) AS total_spent
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

-- Film rental statistics
SELECT 
  f.title,
  COUNT(r.rental_id) AS times_rented,
  AVG(f.rental_rate) AS rental_rate,
  f.length AS duration_minutes
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, f.rental_rate, f.length
ORDER BY times_rented DESC
LIMIT 15;

-- Monthly revenue trend
SELECT 
  YEAR(payment_date) AS year,
  MONTH(payment_date) AS month,
  COUNT(*) AS transaction_count,
  SUM(amount) AS monthly_revenue,
  AVG(amount) AS avg_transaction
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY year, month;

-- ============================================================================
-- PRACTICE EXERCISES
-- ============================================================================
-- Try these yourself:

-- Exercise 1: Count how many films are in each rating category
-- SELECT rating, COUNT(*) FROM film GROUP BY rating;

-- Exercise 2: Find the average film length by rating
-- SELECT rating, AVG(length) FROM film GROUP BY rating ORDER BY AVG(length) DESC;

-- Exercise 3: How many rentals did each store have? (Join rental, inventory, store tables)
-- SELECT s.store_id, COUNT(r.rental_id) FROM rental r
-- JOIN inventory i ON r.inventory_id = i.inventory_id
-- JOIN store s ON i.store_id = s.store_id
-- GROUP BY s.store_id;

-- Exercise 4: Find categories with more than 60 films
-- SELECT c.name, COUNT(f.film_id) FROM category c
-- JOIN film_category fc ON c.category_id = fc.category_id
-- JOIN film f ON fc.film_id = f.film_id
-- GROUP BY c.name HAVING COUNT(f.film_id) > 60;

-- Exercise 5: Total payment amount by month (include month name and year)
-- SELECT YEAR(payment_date), MONTH(payment_date), SUM(amount) FROM payment
-- GROUP BY YEAR(payment_date), MONTH(payment_date) ORDER BY YEAR(payment_date), MONTH(payment_date);
