-- ============================================================================
-- BASIC SELECT QUERIES - FUNDAMENTALS
-- ============================================================================
-- Master the foundation of SQL: SELECT statement structure and column selection
-- All examples use the Sakila sample database
-- ============================================================================
USE sakila;
-- 1. SELECT ALL COLUMNS (*)
-- Returns every column from the table
SELECT * FROM actor LIMIT 5;
SELECT * FROM actor LIMIT 5;
SELECT * FROM actor LIMIT 5;
SELECT * FROM rental LIMIT 5;
SELECT * FROM payment LIMIT 10;

-- 2. SELECT SPECIFIC COLUMNS
-- More efficient than SELECT * - only retrieve needed data
SELECT actor_id, first_name, last_name FROM actor LIMIT 5;

-- 3. RENAME COLUMNS WITH AS (ALIASING)
-- Make column names more readable or meaningful
SELECT 
  actor_id AS actor_id_pk,
  first_name AS first,
  last_name AS last
FROM actor LIMIT 5;
-- an alias only exists for the duration of the query

-- 4. DISTINCT - REMOVE DUPLICATE VALUES
-- Useful for finding unique values in a column
SELECT DISTINCT rating FROM film;

-- Example: How many different film ratings exist?
SELECT DISTINCT rating FROM film ORDER BY rating;

-- 5. ORDER BY - SORT RESULTS
-- Default is ascending (ASC). Use DESC for descending
SELECT 
  title, 
  rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 5;

-- 6. LIMIT - CONTROL RESULT SET SIZE
-- LIMIT is useful when exploring large tables
SELECT title FROM film LIMIT 10;

-- LIMIT with OFFSET to skip rows
SELECT title FROM film LIMIT 10 OFFSET 5;  -- Skip first 5, get next 10

-- 7. COMBINING MULTIPLE FEATURES
-- Select specific columns, order them, limit results
SELECT 
  title, 
  release_year, 
  rental_duration, 
  rental_rate
FROM film
ORDER BY release_year DESC, rental_rate DESC
LIMIT 15;

-- 8. MATHEMATICAL OPERATIONS IN SELECT
-- Perform calculations on numeric columns
SELECT 
  title,
  rental_rate,
  replacement_cost,
  (replacement_cost - rental_rate) AS profit_per_rental
FROM film
LIMIT 10;

-- 9. STRING OPERATIONS
-- Concatenate columns or work with text
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  actor_id
FROM actor
LIMIT 10;

-- 10. ORDERING BY MULTIPLE COLUMNS
-- First sort by column1, then by column2 within groups
SELECT 
  category_id, 
  film_id, 
  title
FROM film_category
JOIN film ON film_category.film_id = film.film_id
ORDER BY category_id, title
LIMIT 15;

-- ============================================================================
-- PRACTICE EXERCISES
-- ============================================================================
-- Try these yourself:

-- Exercise 1: Select actor_id, first_name, last_name and order by last_name
-- SELECT actor_id, first_name, last_name FROM actor ORDER BY last_name LIMIT 10;
SELECT
  actor_id,
  first_name,
  last_name
FROM actor  
ORDER BY last_name
LIMIT 10;

-- Exercise 2: Select all columns from customer, limit to 5 results
-- SELECT * FROM customer LIMIT 5;
SELECT *
FROM customer LIMIT 5;

-- Exercise 3: Find all unique film ratings in the database
-- SELECT DISTINCT rating FROM film ORDER BY rating;
USE sakila;
SELECT DISTINCT
  rating  
FROM film  
ORDER BY rating;

-- Exercise 4: Get the title and rental_rate of films, ordered by rental_rate (highest first)
-- SELECT title, rental_rate FROM film ORDER BY rental_rate DESC LIMIT 10;
USE sakila;
SELECT
  title,
  rental_rate
FROM film  
ORDER BY rental_rate DESC  
LIMIT 10;

-- Exercise 5: Concatenate actor names and show with actor_id, limit 10
-- SELECT actor_id, CONCAT(first_name, ' ', last_name) AS actor_name FROM actor LIMIT 10;
SELECT
  CONCAT(first_name, ' ', last_name) AS actor_name
FROM actor  
LIMIT 10;