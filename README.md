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

## 1. Total Sales Records

Determine the total number of sales records in the dataset.

```sql
SELECT count(*) AS total_sales
FROM retail_sales;
```

---

## 2. Unique Customers

Determine the total number of unique customers.

```sql
SELECT count(DISTINCT customer_id) AS total_customer
FROM retail_sales;
```

---

# Business Problems & Solutions

## Q1. Retrieve all sales made on **2022-11-05**.

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

---

## Q2. Retrieve all transactions where the category is **Clothing** and the quantity sold is at least **4** during **November 2022**.

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity >=4
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```

---

## Q3. Calculate the total quantity sold and total number of orders for each product category.

```sql
SELECT
category,
sum(quantity) AS net_sales,
count(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

---

## Q4. Find the average age of customers who purchased items from the **Beauty** category.

```sql
SELECT AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```

---

## Q5. Find all transactions where the total sale amount is greater than **1000**.

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

---

## Q6. Find the total number of transactions made by each gender within each product category.

```sql
SELECT
category,
gender,
count(transaction_id)
FROM retail_sales
GROUP BY category, gender;
```

---

## Q7. Calculate the average sale for each month and identify the best-selling month in each year.

```sql
SELECT *
FROM
(
SELECT
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
AVG(total_sale) AS average_sale,
RANK() OVER
(
PARTITION BY EXTRACT(YEAR FROM sale_date)
ORDER BY AVG(total_sale) DESC
) AS Rank
FROM retail_sales
GROUP BY month, year
) AS R1
WHERE Rank = 1;
```

---

## Q8. Find the top 5 customers based on the highest total sales.

```sql
SELECT
customer_id,
sum(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY sum(total_sale) DESC
LIMIT 5;
```

---

## Q9. Find the number of customers who purchased items from each category.

```sql
SELECT DISTINCT
category,
COUNT(customer_id)
FROM retail_sales
GROUP BY category;
```

---

## Q10. Categorise sales into Morning, Afternoon and Evening shifts and calculate the total number of orders in each shift.

```sql
WITH hourly_sales AS
(
SELECT *,
CASE
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS Shift
FROM retail_sales
)

SELECT
Shift,
count(*) AS total_orders
FROM hourly_sales
GROUP BY Shift;
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
