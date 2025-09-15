CREATE TABLE store_data (
    order_id INT,
    order_date DATE,
    region VARCHAR(50),
    product VARCHAR(100),
    qty INT,
    unit_price NUMERIC,
    total NUMERIC
);

SELECT * FROM store_data
LIMIT 10;

1. Region-wise Total Sales

SELECT region, SUM(total) AS total_sales
FROM store_data
GROUP BY region
ORDER BY total_sales DESC;

2.Top 5 Products by Revenue

SELECT product, SUM(total) AS revenue
FROM store_data
GROUP BY product
ORDER BY revenue DESC
LIMIT 5;

3. Monthly Sales Trend

SELECT DATE_TRUNC('month', order_date) AS month, SUM(total) AS monthly_sales
FROM store_data
GROUP BY month
ORDER BY month;

4. Average Order Value

SELECT AVG(total) AS avg_order_value
FROM store_data;

5. Highest Selling Day

SELECT order_date, SUM(total) AS day_sales
FROM store_data
GROUP BY order_date
ORDER BY day_sales DESC
LIMIT 1;

6.Average Selling Price per product

SELECT product, AVG(unit_price) AS avg_price
FROM store_data
GROUP BY product;

7. Region-wise profit

SELECT region, SUM(total) AS total_sales, SUM((unit_price * qty) * 0.2) AS profit
FROM store_data
GROUP BY region
ORDER BY profit DESC;

8. Monthly Growth Rate (MoM sales % change)

SELECT month,
       monthly_sales,
       LAG(monthly_sales) OVER (ORDER BY month) AS prev_month,
       ROUND(((monthly_sales - LAG(monthly_sales) OVER (ORDER BY month)) 
               / LAG(monthly_sales) OVER (ORDER BY month)) * 100, 2) AS growth_rate
FROM (
    SELECT DATE_TRUNC('month', order_date) AS month,
           SUM(total) AS monthly_sales
    FROM store_data
    GROUP BY month
) t;
