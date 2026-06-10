-- ============================================================================
-- FILTERING DATA WITH WHERE CLAUSE - FUNDAMENTALS
-- ============================================================================
-- Learn to filter results based on conditions
-- Use WHERE to retrieve only the data you need
-- ============================================================================

-- 1. BASIC WHERE CLAUSE
-- Filter rows based on a single condition
SELECT title, rental_rate FROM film WHERE rental_rate > 4.99;

-- Exact match
SELECT * FROM film WHERE rating = 'PG';

-- Not equal
SELECT title FROM film WHERE rating != 'R';

-- 2. COMPARISON OPERATORS
-- =, !=, <, >, <=, >=
SELECT title, length FROM film WHERE length > 120;
SELECT title, release_year FROM film WHERE release_year >= 2006;
SELECT title, rental_rate FROM film WHERE rental_rate <= 2.99;

-- 3. LOGICAL OPERATORS: AND
-- Both conditions must be true
SELECT title, rating, rental_rate 
FROM film 
WHERE rating = 'PG' AND rental_rate > 3.99;

-- Multiple AND conditions
SELECT title, length, rating 
FROM film 
WHERE length > 100 AND rating = 'PG' AND rental_rate > 2.99;

-- 4. LOGICAL OPERATORS: OR
-- At least one condition must be true
SELECT title, rating 
FROM film 
WHERE rating = 'PG' OR rating = 'G';

-- Multiple OR conditions
SELECT title, rating 
FROM film 
WHERE rating IN ('PG', 'G', 'PG-13');  -- Better than multiple ORs

-- 5. LOGICAL OPERATORS: NOT
-- Negate a condition
SELECT title, rating FROM film WHERE NOT rating = 'R';
-- Equivalent to: WHERE rating != 'R'

-- NOT with IN
SELECT title, rating FROM film WHERE rating NOT IN ('NC-17', 'R');

-- 6. IN OPERATOR
-- Check if value is in a list
SELECT title FROM film WHERE rating IN ('PG', 'PG-13', 'G');

-- 7. BETWEEN OPERATOR
-- Filter within a range (inclusive)
SELECT title, rental_rate FROM film WHERE rental_rate BETWEEN 2.99 AND 4.99;

-- Date range
SELECT customer_id, rental_date FROM rental 
WHERE rental_date BETWEEN '2005-05-01' AND '2005-05-31';

-- 8. LIKE OPERATOR - PATTERN MATCHING
-- % = any number of characters
-- _ = single character

-- Films starting with 'A'
SELECT title FROM film WHERE title LIKE 'A%';

-- Films containing 'the'
SELECT title FROM film WHERE title LIKE '%the%';

-- Films ending with 's'
SELECT title FROM film WHERE title LIKE '%s';

-- Films with exactly 5 characters
SELECT title FROM film WHERE title LIKE '_____';

-- 9. IS NULL - FIND MISSING VALUES
-- Check for NULL values
SELECT * FROM customer WHERE email IS NULL;

-- 10. IS NOT NULL - EXCLUDE MISSING VALUES
SELECT customer_id, email FROM customer WHERE email IS NOT NULL;

-- 11. COMPLEX WHERE CLAUSES WITH PARENTHESES
-- Use parentheses to group logical conditions
-- Find films that are (PG or PG-13) AND (cost > $3)
SELECT title, rating, rental_rate 
FROM film 
WHERE (rating = 'PG' OR rating = 'PG-13') AND rental_rate > 3.00;

-- 12. CASE SENSITIVITY
-- MySQL is case-insensitive for string comparisons by default
SELECT title FROM film WHERE rating = 'pg';  -- Works same as 'PG'

-- 13. COMBINING MULTIPLE CONDITIONS - REAL WORLD EXAMPLE
-- Find active customers who rented in the last 30 days
SELECT c.customer_id, c.first_name, c.last_name, r.rental_date
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE c.active = 1 
  AND r.rental_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
ORDER BY r.rental_date DESC;

-- ============================================================================
-- PRACTICE EXERCISES
-- ============================================================================
-- Try these yourself:

-- Exercise 1: Find all films with rating 'NC-17'
-- SELECT * FROM film WHERE rating = 'NC-17';

-- Exercise 2: Find films longer than 150 minutes
-- SELECT title, length FROM film WHERE length > 150;

-- Exercise 3: Find customers whose last name starts with 'S'
-- SELECT first_name, last_name FROM customer WHERE last_name LIKE 'S%';

-- Exercise 4: Find rentals from May 2005
-- SELECT * FROM rental WHERE rental_date BETWEEN '2005-05-01' AND '2005-05-31';

-- Exercise 5: Find all films with rental rate between $3 and $5 that are not rated 'R'
-- SELECT title, rating, rental_rate FROM film WHERE rental_rate BETWEEN 3 AND 5 AND rating != 'R';
