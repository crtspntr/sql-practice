-- ============================================================================
-- SUBQUERIES AND CTEs - FUNDAMENTALS
-- ============================================================================
-- Learn to use subqueries and Common Table Expressions for complex logic
-- Break down complex queries into readable, reusable parts
-- ============================================================================

-- 1. SCALAR SUBQUERY IN SELECT
-- A subquery that returns a single value

SELECT 
  title,
  rental_rate,
  (SELECT AVG(rental_rate) FROM film) AS avg_rental_rate,
  rental_rate - (SELECT AVG(rental_rate) FROM film) AS diff_from_avg
FROM film
LIMIT 10;

-- 2. SUBQUERY IN WHERE CLAUSE
-- Filter based on results from another query

-- Find films with above-average rental rate
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate DESC;

-- Find customers who rented films in the Action category
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name)
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
WHERE f.film_id IN (
  SELECT DISTINCT f2.film_id
  FROM film f2
  INNER JOIN film_category fc ON f2.film_id = fc.film_id
  INNER JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Action'
)
ORDER BY c.customer_id;

-- 3. IN OPERATOR WITH SUBQUERY
-- Check if value exists in a subquery result set

-- Find films that have been rented at least once
SELECT title
FROM film
WHERE film_id IN (
  SELECT DISTINCT f.film_id
  FROM film f
  INNER JOIN inventory i ON f.film_id = i.film_id
  INNER JOIN rental r ON i.inventory_id = r.inventory_id
)
ORDER BY title;

-- 4. NOT IN OPERATOR WITH SUBQUERY
-- Find items NOT matching subquery results

-- Find films that have never been rented
SELECT title
FROM film
WHERE film_id NOT IN (
  SELECT DISTINCT f.film_id
  FROM film f
  INNER JOIN inventory i ON f.film_id = i.film_id
  INNER JOIN rental r ON i.inventory_id = r.inventory_id
);

-- 5. EXISTS - CHECK FOR EXISTENCE
-- More efficient than IN for large datasets

-- Find customers who have made payments
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name)
FROM customer c
WHERE EXISTS (
  SELECT 1
  FROM payment p
  WHERE p.customer_id = c.customer_id
);

-- Find films that exist in inventory for store 1
SELECT DISTINCT f.title
FROM film f
WHERE EXISTS (
  SELECT 1
  FROM inventory i
  WHERE i.film_id = f.film_id
  AND i.store_id = 1
);

-- 6. CORRELATED SUBQUERY
-- Subquery that references columns from outer query

-- Find films with rental rate above category average
SELECT DISTINCT f.title, f.rental_rate, c.name
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE f.rental_rate > (
  SELECT AVG(f2.rental_rate)
  FROM film f2
  INNER JOIN film_category fc2 ON f2.film_id = fc2.film_id
  WHERE fc2.category_id = c.category_id
);

-- 7. SUBQUERY IN FROM CLAUSE (DERIVED TABLE)
-- Use subquery result as a temporary table

SELECT 
  category_stats.category_name,
  category_stats.avg_rental_rate,
  category_stats.film_count
FROM (
  SELECT 
    c.name AS category_name,
    AVG(f.rental_rate) AS avg_rental_rate,
    COUNT(*) AS film_count
  FROM film f
  INNER JOIN film_category fc ON f.film_id = fc.film_id
  INNER JOIN category c ON fc.category_id = c.category_id
  GROUP BY c.name
) AS category_stats
WHERE category_stats.avg_rental_rate > 3.0
ORDER BY category_stats.avg_rental_rate DESC;

-- 8. COMMON TABLE EXPRESSIONS (CTE) - WITH CLAUSE
-- Make complex queries more readable

-- Basic CTE example
WITH customer_rentals AS (
  SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS total_rentals
  FROM customer c
  LEFT JOIN rental r ON c.customer_id = r.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT 
  customer_id,
  customer_name,
  total_rentals
FROM customer_rentals
WHERE total_rentals > 0
ORDER BY total_rentals DESC;

-- 9. MULTIPLE CTEs
-- Define multiple CTEs and combine them

WITH top_films AS (
  SELECT 
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS rental_count
  FROM film f
  LEFT JOIN inventory i ON f.film_id = i.film_id
  LEFT JOIN rental r ON i.inventory_id = r.inventory_id
  GROUP BY f.film_id, f.title
  ORDER BY rental_count DESC
  LIMIT 10
),
category_info AS (
  SELECT 
    fc.film_id,
    c.name AS category_name
  FROM film_category fc
  INNER JOIN category c ON fc.category_id = c.category_id
)
SELECT 
  tf.film_id,
  tf.title,
  tf.rental_count,
  ci.category_name
FROM top_films tf
LEFT JOIN category_info ci ON tf.film_id = ci.film_id
ORDER BY tf.rental_count DESC;

-- 10. CTE FOR COMPLEX BUSINESS LOGIC
-- Segment customers and analyze spending

WITH customer_spending AS (
  SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS rental_count,
    COALESCE(SUM(p.amount), 0) AS total_spent
  FROM customer c
  LEFT JOIN rental r ON c.customer_id = r.customer_id
  LEFT JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY c.customer_id, c.first_name, c.last_name
),
customer_segments AS (
  SELECT 
    customer_id,
    customer_name,
    rental_count,
    total_spent,
    CASE 
      WHEN total_spent > 100 THEN 'High Value'
      WHEN total_spent > 50 THEN 'Medium Value'
      WHEN total_spent > 0 THEN 'Low Value'
      ELSE 'Inactive'
    END AS segment
  FROM customer_spending
)
SELECT 
  segment,
  COUNT(*) AS customer_count,
  AVG(total_spent) AS avg_spending,
  AVG(rental_count) AS avg_rentals
FROM customer_segments
GROUP BY segment
ORDER BY avg_spending DESC;

-- ============================================================================
-- PRACTICE EXERCISES
-- ============================================================================
-- Try these yourself:

-- Exercise 1: Find customers who spent more than the average customer
-- WITH avg_spending AS (
--   SELECT AVG(COALESCE(SUM(p.amount), 0)) as avg_total
--   FROM customer c
--   LEFT JOIN rental r ON c.customer_id = r.customer_id
--   LEFT JOIN payment p ON r.rental_id = p.rental_id
-- )
-- SELECT ... (complete this query!)

-- Exercise 2: Use EXISTS to find films in category 'Drama'
-- SELECT title FROM film f
-- WHERE EXISTS (
--   SELECT 1 FROM film_category fc
--   INNER JOIN category c ON fc.category_id = c.category_id
--   WHERE fc.film_id = f.film_id AND c.name = 'Drama'
-- );

-- Exercise 3: Create a CTE for monthly revenue and find the highest month
-- WITH monthly_revenue AS (
--   SELECT YEAR(payment_date) as year, MONTH(payment_date) as month, SUM(amount) as revenue
--   FROM payment
--   GROUP BY YEAR(payment_date), MONTH(payment_date)
-- )
-- SELECT * FROM monthly_revenue ORDER BY revenue DESC LIMIT 1;
