-- How many sales we have? 
SELECT count(*) AS total_sales FROM retail_sales;

-- How many unique customers we have?
SELECT count(DISTINCT customer_id) AS total_customer FROM retail_sales;

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all trascation where the category is 'Clothing' and the qunantity sold is at least 4 in the month of Nov - 2022
SELECT * FROM retail_sales WHERE category = 'Clothing' AND quantity >=4 AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- Write a SQL query to calculate the total sales and total order for each category
SELECT category, sum(quantity) AS net_sales, count(*) AS total_orders FROM retail_sales GROUP BY category;

-- Write a SQL query o find the average age of customers who purchased items from the 'Beuaty' Category
SELECT AVG(age) AS average_age FROM retail_sales WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale s greater than 1000.
SELECT * FROM retail_sales WHERE total_sale > 1000;

-- Write a SQL query to find the total number of transactions ade by each gender in each category
SELECT category, gender, count(transaction_id) FROM retail_sales GROUP BY category, gender;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year. 
SELECT * FROM (SELECT EXTRACT(YEAR FROM sale_date) AS year, 
EXTRACT(MONTH FROM sale_date) AS month, 
AVG(total_sale) AS average_sale, RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY avg(total_sale) DESC) AS Rank
FROM retail_sales 
GROUP BY month, year) AS R1 WHERE Rank=1;

-- Write a SQL query to find the top 5 customers based on he highest total sales
SELECT customer_id, sum(total_sale) as total_sales FROM retail_sales GROUP BY customer_id ORDER BY sum(total_sale) DESC LIMIT 5;

-- Write a SQL query to find the number of unique cutomers who purchased tems from each category
SELECT DISTINCT category, COUNT(customer_id) FROM retail_sales GROUP BY category;

-- Write a SQL query to create each shift and number of orders (Example: Moring <=12, Afternoon Between 12 and 17 Evening >17)
WITH hourly_sales AS 
(
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE'Evening'
	END AS Shift 
FROM retail_sales 
)
SELECT Shift, count(*) AS total_orders FROM hourly_sales GROUP BY Shift;
		