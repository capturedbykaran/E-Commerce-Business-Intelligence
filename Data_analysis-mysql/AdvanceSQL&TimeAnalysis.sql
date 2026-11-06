USE e_commerce;

-- Which months generate the highest sales?

SELECT 
    purchase_month AS month,
    ROUND(SUM(payment_value), 2) AS total_sales
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY month
ORDER BY total_sales DESC;

-- Which hours have the highest order volume?

SELECT
    purchase_hour AS hour,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY purchase_hour
ORDER BY total_orders DESC;

-- Which weekdays have the highest order volume?

SELECT
    purchase_day AS weekday,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY purchase_day
ORDER BY total_orders DESC;

-- Which regions generate the highest revenue?

SELECT
	region,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY region
ORDER BY total_revenue DESC;

-- Which regions have the highest Average Order Value?

SELECT
    region,
    ROUND(SUM(payment_value) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY region
ORDER BY average_order_value DESC;

-- Which products generate high revenue but low sales volume?

SELECT
    product_id,
    COUNT(*) AS units_sold,
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items
GROUP BY product_id
ORDER BY total_revenue DESC, units_sold ASC
LIMIT 10;

-- Which weight category contributes the most revenue?

SELECT
    p.weight_category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.weight_category
ORDER BY total_revenue DESC;

-- Rank customers by revenue using RANK().

SELECT
    RANK() OVER (
        ORDER BY SUM(p.payment_value) DESC
    ) AS customer_rank,
    c.customer_id,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY customer_rank
LIMIT 10;

-- Calculate month-over-month revenue growth using LAG().

WITH monthly_revenue AS (
    SELECT
        o.purchase_month AS month,
        ROUND(SUM(p.payment_value), 2) AS revenue
    FROM orders o
    JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY o.purchase_month
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        ((revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month)) * 100,
        2
    ) AS month_growth_percent
FROM monthly_revenue
ORDER BY month;


-- Find the cumulative revenue over time using window 

WITH monthly_revenue AS (
    SELECT
        o.purchase_month AS month,
        ROUND(SUM(p.payment_value), 2) AS revenue
    FROM orders o
    JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY o.purchase_month
)

SELECT
    month,
    revenue,
    SUM(revenue) OVER (
        ORDER BY month
    ) AS cumulative_revenue
FROM monthly_revenue
ORDER BY month;












