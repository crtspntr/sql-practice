# SQL Practice Repository

A comprehensive SQL learning journey focused on MySQL and the **Sakila Sample Database**. This repository documents my progress through SQL fundamentals, database design, advanced queries, and data analysis.

## 🎯 Learning Objectives

- **Master SQL fundamentals**: SELECT, filtering, joins, aggregations, and subqueries
- **Understand database design**: Normalization, relationships, constraints, and best practices
- **Write efficient queries**: Window functions, CTEs, optimization, and complex business logic
- **Analyze data**: Extract insights, perform EDA, and answer business questions
- **Practice version control**: Commit regularly with meaningful messages and use branches for exploration

## 📚 Repository Structure

### [01-fundamentals/](./01-fundamentals/)
Core SQL concepts every developer should master:
- Basic SELECT statements and column operations
- Filtering data with WHERE clauses
- Aggregate functions (COUNT, SUM, AVG, MIN, MAX)
- Joining tables (INNER, LEFT, RIGHT, FULL)
- Subqueries and Common Table Expressions (CTEs)

### [02-database-design/](./02-database-design/)
Understanding database structure and relationships:
- Normalization principles and examples
- Primary and foreign key constraints
- Entity relationships and dependency analysis
- Schema design patterns using Sakila

### [03-query-practice/](./03-query-practice/)
Advanced SQL techniques:
- Complex multi-table queries
- Window functions (ROW_NUMBER, RANK, LAG, LEAD)
- Query optimization and performance tips
- Business logic patterns (running totals, filtering aggregates, etc.)

### [04-data-analysis/](./04-data-analysis/)
Practical analysis using real Sakila data:
- Exploratory Data Analysis (EDA)
- Data cleaning and transformation
- Statistical queries
- Business intelligence questions

## 🗄️ About Sakila

Sakila is a sample MySQL database that models a DVD rental store. It includes:
- **15 tables** with realistic relationships
- 1,000+ films, 6,000+ customers, and rental transaction history
- Perfect for practicing real-world SQL scenarios

**Key tables**: actor, film, film_actor, customer, rental, payment, inventory, store, and more.

**Download**: https://dev.mysql.com/doc/sakila/en/

## 💡 How to Use This Repository

1. **Clone the repository**:
   ```bash
   git clone https://github.com/crtspntr/sql-practice.git
   cd sql-practice
   ```

2. **Set up Sakila**:
   - Download from: https://dev.mysql.com/doc/sakila/en/
   - Load into MySQL: `mysql -u root -p < sakila-schema.sql && mysql -u root -p < sakila-data.sql`

3. **Practice**: Open files in your SQL editor and follow the examples and exercises

4. **Commit your progress**: After completing exercises or adding notes:
   ```bash
   git add .
   git commit -m "Add [topic]: [brief description of what you learned]"
   ```

## 📊 Version Control Best Practices

- **Commit early and often** — Each new concept or practice set = one commit
- **Write descriptive messages** — e.g., "Add INNER JOIN examples: customers with rentals"
- **Use branches** for experimenting — e.g., `git checkout -b window-functions-experiments`
- **Update section READMEs** as you progress — Build a learning narrative

## 🔗 Resources

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Sakila Sample Database Guide](https://dev.mysql.com/doc/sakila/en/)
- [SQL Tutorial - W3Schools](https://www.w3schools.com/sql/)
- [Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/)

## 📝 Progress Tracking

As you complete sections, update this README with your progress:

- [ ] 01-fundamentals
- [ ] 02-database-design
- [ ] 03-query-practice
- [ ] 04-data-analysis

---

**Last Updated**: June 10, 2026  
**Status**: In Progress
