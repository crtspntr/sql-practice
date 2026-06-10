# 04 - Data Analysis

Apply SQL to real-world analysis scenarios. This section uses the Sakila database to explore data, extract insights, and answer business questions.

## 📋 Topics Covered

### 1. **project-1-dataset-eda.sql**
Exploratory Data Analysis of the Sakila dataset:
- Dataset overview and size
- Data type validation
- Distribution analysis
- Identifying outliers and anomalies
- Summary statistics

**Questions**: How many films are in the catalog? What's the rental price range? Which countries have customers?

### 2. **data-cleaning-examples.sql**
Preparing data for analysis:
- Handling missing or NULL values
- Standardizing data formats
- Removing duplicates
- Correcting data inconsistencies
- Data validation techniques

**Sakila Focus**: Customer address data, film descriptions, payment records

### 3. **statistical-queries.sql**
Quantitative analysis:
- Descriptive statistics (mean, median, mode, standard deviation)
- Percentile analysis
- Correlation and trends
- Distribution analysis
- Hypothesis testing queries

**Sakila Examples**: Rental duration trends, payment amount analysis, film rating performance

### 4. **business-questions.sql**
Practical business intelligence queries:
- Revenue analysis and trends
- Customer behavior and lifetime value
- Inventory optimization
- Store performance comparison
- Marketing insights

**Example Questions**:
- Which films generate the most revenue?
- Who are our most valuable customers?
- Are there seasonal rental patterns?
- Which stores are underperforming?

## 🎯 Analysis Workflow

### Step 1: Understand the Data
- Table structure and relationships
- Data types and ranges
- Quality issues
- Time period covered

### Step 2: Ask Questions
- Start broad (overview statistics)
- Narrow to specific scenarios
- Compare segments (stores, categories, time periods)

### Step 3: Write Analysis Queries
- Use GROUP BY and aggregates
- Apply time-based filters
- Join relevant tables
- Calculate metrics and KPIs

### Step 4: Interpret Results
- Look for patterns and anomalies
- Compare to baselines or targets
- Consider business context
- Identify opportunities

## 📊 Key Metrics in Sakila

| Metric | Description | Business Value |
|--------|-------------|----------------|
| Total Revenue | Sum of all payments | Overall business health |
| Customer LTV | Lifetime value per customer | Marketing ROI, retention focus |
| Avg Rental Duration | Days films are rented | Pricing strategy |
| Film Popularity | Rental count per film | Inventory decisions |
| Store Performance | Revenue by location | Resource allocation |
| Customer Retention | Repeat rental rate | Customer satisfaction proxy |

## 💡 Analysis Examples

### Revenue Analysis
```sql
SELECT 
  YEAR(payment_date) as year,
  MONTH(payment_date) as month,
  SUM(amount) as monthly_revenue
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY year, month;
```

### Customer Segmentation
```sql
SELECT 
  c.customer_id,
  COUNT(r.rental_id) as rental_count,
  SUM(p.amount) as total_spent,
  CASE 
    WHEN SUM(p.amount) > 100 THEN 'High Value'
    WHEN SUM(p.amount) > 50 THEN 'Medium Value'
    ELSE 'Low Value'
  END as customer_segment
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id;
```

## ✅ Completion Checklist

- [ ] Understand Sakila data structure and quality
- [ ] Write exploratory analysis queries
- [ ] Identify and handle data quality issues
- [ ] Calculate key business metrics
- [ ] Answer 5+ business questions with SQL
- [ ] Create a summary report of key findings

## 📝 Business Questions to Explore

1. What are the top 10 most-rented films?
2. Who are our top 5 customers by revenue?
3. Which film categories are most popular?
4. What's the average rental duration by category?
5. How does store performance compare?
6. Are there seasonal trends in rentals?
7. What's the customer retention rate?
8. Which films have the highest rental rate?
9. What's the average customer lifetime value?
10. Which cities generate the most revenue?

---

**Status**: In Progress  
**Last Updated**: June 10, 2026
