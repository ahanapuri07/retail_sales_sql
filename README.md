# Retail Sales Analysis Using SQL

## Project Overview

This project analyses a retail sales dataset using PostgreSQL to uncover insights into customer behaviour, product performance, and sales trends.

The objective of this project is to demonstrate practical SQL skills by solving real-world business problems commonly encountered by data analysts.

---

# Tools Used

- PostgreSQL 18
- pgAdmin 4
- SQL
- GitHub

---

# Dataset Information

The dataset contains **2,000 retail transactions** including customer demographics, product categories, sales amounts and transaction dates.

| Column | Description |
|---------|-------------|
| transaction_id | Unique transaction ID |
| sale_date | Date of purchase |
| sale_time | Time of purchase |
| customer_id | Customer ID |
| gender | Customer gender |
| age | Customer age |
| category | Product category |
| quantity | Quantity purchased |
| price_per_unit | Price of one item |
| cogs | Cost of goods sold |
| total_sale | Total sale amount |

---

# Database Creation

```sql
CREATE TABLE retail_sales(
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender TEXT,
    age INT,
    category TEXT,
    quantity INT,
    price_per_unit DECIMAL(10,2),
    cogs DECIMAL(10,2),
    total_sale DECIMAL(10,2)
);
```

---

# Data Exploration 

## 1. Count the total number of records

```sql
SELECT COUNT(*) AS total_records
FROM retail_sales;
```

---

## 2. Count the number of unique customers

```sql
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales;
```

---

## 3. Display all unique product categories

```sql
SELECT DISTINCT category
FROM retail_sales;
```

---

# Business Questions

## Question 1
### Retrieve all sales made on 2022-11-05.

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

---

## Question 2
### Retrieve all Clothing transactions where more than four items were sold during November 2022.

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND EXTRACT(MONTH FROM sale_date) = 11
  AND EXTRACT(YEAR FROM sale_date) = 2022;
```

---

## Question 3
### Calculate total sales for each product category.

```sql
SELECT
    category,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;
```

---

## Question 4
### Calculate the average age of customers purchasing Beauty products.

```sql
SELECT
    ROUND(AVG(age),2) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```

---

## Question 5
### Find all transactions where total sales exceeded £1000.

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

---

## Question 6
### Count the number of transactions made by each gender within each product category.

```sql
SELECT
    gender,
    category,
    COUNT(*) AS transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY category;
```

---

## Question 7
### Identify the best-selling month in each year.

```sql
WITH monthly_sales AS
(
SELECT
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
AVG(total_sale) AS avg_sales,
RANK() OVER(
PARTITION BY EXTRACT(YEAR FROM sale_date)
ORDER BY AVG(total_sale) DESC
) AS sales_rank
FROM retail_sales
GROUP BY year, month
)

SELECT *
FROM monthly_sales
WHERE sales_rank = 1;
```

---

## Question 8
### Identify the top five customers based on total spending.

```sql
SELECT
customer_id,
SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;
```

---

## Question 9
### Count the number of unique customers purchasing from each category.

```sql
SELECT
category,
COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

---

## Question 10
### Categorise transactions into Morning, Afternoon and Evening shifts and count transactions in each shift.

```sql
WITH hourly_sales AS
(
SELECT *,
CASE
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift
FROM retail_sales
)

SELECT
shift,
COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;
```

---

# SQL Concepts Demonstrated

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Aggregate Functions
- CASE Statements
- Date Functions
- Common Table Expressions (CTEs)
- Window Functions
- RANK()

---

# Key Insights

- Analysed customer purchasing behaviour.
- Identified the top five customers by revenue.
- Compared revenue across product categories.
- Determined the highest-performing months.
- Analysed shopping patterns across different times of the day.

---

# Author

**Ahana Puri**

BSc Economics, King's College London

Aspiring Data Analyst | SQL | Data Analytics
