# 03 - Query Practice

Advanced SQL techniques for writing efficient, powerful queries. This section covers complex queries, window functions, optimization strategies, and real-world business logic patterns.

## 📋 Topics Covered

### 1. **complex-queries.sql**
- Multi-table JOINs (3+ tables)
- Combining multiple conditions and operators
- Correlated subqueries
- Derived tables (subqueries in FROM)
- UNION and UNION ALL
- Set operations

**Sakila Examples**: Finding films by multiple actors, analyzing store-level rental patterns

### 2. **window-functions.sql**
- ROW_NUMBER() - Unique row ranking
- RANK() and DENSE_RANK() - Handling ties
- LEAD() and LAG() - Accessing previous/next rows
- Running totals with SUM() OVER
- Partitioning results
- Frame specifications (ROWS BETWEEN)

**Sakila Examples**: Top rental customers per category, year-over-year revenue comparison

### 3. **optimization-techniques.sql**
- Query execution plans (EXPLAIN)
- Indexing strategies
- Avoiding full table scans
- Optimal JOIN orders
- Aggregation vs. window function trade-offs
- Query refactoring tips

**Sakila Examples**: Optimizing rental reports, efficient revenue queries

### 4. **business-logic-patterns.sql**
- Filtering aggregated results (HAVING)
- Running totals and moving averages
- Top-N queries
- Cohort analysis
- Time-based comparisons
- Customer segmentation

**Sakila Examples**: Top 5 films by revenue, customer lifecycle stages, store performance tiers

## 🎯 Advanced Techniques

### Window Functions
Analyze data across a set of rows without collapsing results:

```sql
SELECT 
  customer_id,
  rental_date,
  ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY rental_date) as rental_sequence
FROM rental;
```

### CTEs for Readability
Break complex queries into readable steps:

```sql
WITH customer_rentals AS (
  SELECT customer_id, COUNT(*) as total_rentals
  FROM rental
  GROUP BY customer_id
)
SELECT * FROM customer_rentals WHERE total_rentals > 10;
```

### Performance Optimization
- Use EXPLAIN to understand query execution
- Create indexes on foreign keys and filtered columns
- Avoid SELECT * in production queries
- Use LIMIT when exploring large datasets
- Consider materialized views for complex aggregations

## 📊 Complexity Progression

1. **Basic**: 2-table JOIN with simple filtering
2. **Intermediate**: 3+ tables, GROUP BY, aggregation
3. **Advanced**: Window functions, CTEs, optimization
4. **Expert**: Complex business logic, performance tuning, scalability

## 💡 Common Patterns in Sakila

### Pattern 1: Top-N Analysis
"Find the top 10 films by rental count"

### Pattern 2: Cohort Analysis
"Group customers by signup month and track retention"

### Pattern 3: Running Metrics
"Calculate cumulative revenue over time"

### Pattern 4: Customer Segmentation
"Classify customers as high/medium/low value"

## ✅ Completion Checklist

- [ ] Write and understand complex multi-table queries
- [ ] Master window functions for analytical queries
- [ ] Use EXPLAIN to optimize queries
- [ ] Apply business logic patterns to Sakila data
- [ ] Refactor queries for readability and performance

---

**Status**: In Progress  
**Last Updated**: June 10, 2026
