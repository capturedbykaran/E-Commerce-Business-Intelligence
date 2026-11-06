USE e_commerce;

-- What is the total revenue?
SELECT 
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM payments;

-- What is the monthly revenue trend?

SELECT 
	o.purchase_month AS month,
	ROUND(
		SUM(payment_value), 2
        ) 
        AS total_revenue
FROM orders o 
JOIN payments p
ON o.order_id = p.order_id
GROUP BY month;

-- What is the Average Order Value (AOV)?

SELECT
    ROUND(
        SUM(payment_value) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM payments;

-- Which product categories generate the highest revenue?
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 5;



-- Which products generate the highest revenue?

SELECT
    product_id,
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Which states contribute the most revenue?

SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Which cities contribute the most revenue?

SELECT
    c.customer_city,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_city
ORDER BY total_revenue DESC
LIMIT 10;

-- Which price category generates the highest revenue?

SELECT
	oi.price_category,
	ROUND(SUM(payment_value),2) AS revenue
FROM payments P
JOIN order_items oi
	ON p.order_id = oi.order_id
GROUP BY oi.price_category
ORDER BY revenue DESC;

-- Which products are sold the most?

SELECT
    product_id,
    COUNT(*) AS total_units_sold
FROM order_items
GROUP BY product_id
ORDER BY total_units_sold DESC
LIMIT 10;

-- Which product categories sell the most?

SELECT
    p.product_category_name,
    COUNT(*) AS total_units_sold
FROM order_items oi
JOIN products p
 ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_units_sold DESC
LIMIT 10;