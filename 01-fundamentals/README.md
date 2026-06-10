# 01 - SQL Fundamentals

Master the core concepts that every SQL developer needs to know. This section covers the essential building blocks using the Sakila database.

## 📋 Topics Covered

### 1. **basic-select.sql**
- SELECT specific columns and all columns (*)
- Rename columns with AS
- DISTINCT for unique values
- LIMIT for controlling result set size
- ORDER BY ascending and descending

**Example Focus**: Exploring the film and actor tables

### 2. **filtering-data.sql**
- WHERE clause with various operators (=, !=, <, >, <=, >=)
- AND, OR, NOT operators
- IN and BETWEEN operators
- LIKE for pattern matching
- NULL handling with IS NULL / IS NOT NULL

**Example Focus**: Finding specific films, actors, and customers in Sakila

### 3. **aggregate-functions.sql**
- COUNT() - row counting
- SUM(), AVG(), MIN(), MAX()
- GROUP BY for grouping results
- HAVING clause for filtering groups
- Functions with DISTINCT

**Example Focus**: Revenue analysis, film statistics, rental patterns

### 4. **joins.sql**
- INNER JOIN - rows that match both tables
- LEFT JOIN - all rows from left table, matching from right
- RIGHT JOIN - all rows from right table, matching from left
- CROSS JOIN - cartesian product
- Multiple joins in one query

**Example Focus**: Combining actor-film data, customer-rental information, store inventory

### 5. **subqueries-and-ctes.sql**
- Scalar subqueries in SELECT
- Subqueries in WHERE clauses
- IN with subqueries
- EXISTS for existence checking
- Common Table Expressions (WITH clause)
- Recursive CTEs

**Example Focus**: Complex filtering, derived datasets, hierarchical data

## 🎯 Learning Path

1. Start with **basic-select.sql** to understand query structure
2. Move to **filtering-data.sql** to practice WHERE clauses
3. Practice **aggregate-functions.sql** with GROUP BY
4. Master **joins.sql** - critical for multi-table analysis
5. Explore **subqueries-and-ctes.sql** for advanced query patterns

## 💻 Practice Exercises

For each file:
1. Read the examples and comments
2. Execute the provided queries against Sakila
3. Modify queries to explore different aspects of the data
4. Try writing your own variations

## 📊 Sakila Tables Used

- `actor` - Film actors
- `film` - Movie information
- `film_actor` - Many-to-many relationship between actors and films
- `customer` - Customer data
- `rental` - Rental transactions
- `payment` - Payment records
- `inventory` - Film copies in stores
- `store` - Store locations
- `address` - Address information
- `city` - City data

## ✅ Completion Checklist

- [ ] basic-select.sql - Understand SELECT syntax
- [ ] filtering-data.sql - Master WHERE clauses
- [ ] aggregate-functions.sql - Group and summarize data
- [ ] joins.sql - Combine multiple tables
- [ ] subqueries-and-ctes.sql - Advanced query patterns

---

**Status**: In Progress  
**Last Updated**: June 10, 2026
