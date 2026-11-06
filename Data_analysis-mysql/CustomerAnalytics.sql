USE e_commerce;
SELECT * FROM customers LIMIT 20;

-- How many customers are new vs repeat customers?
SELECT
    CASE
        WHEN order_count = 1 THEN 'New Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT
        unique_customer_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY unique_customer_id
) AS customer_orders
GROUP BY customer_type;

-- Who are the Top 10 customers by revenue?

SELECT
    c.unique_customer_id,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.unique_customer_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Which region has the highest customer base?

SELECT 
	region,
    COUNT(DISTINCT unique_customer_id) AS customer_base
FROM customers
GROUP BY region
ORDER BY customer_base DESC;

-- What is the average purchase frequency?

SELECT
    ROUND(COUNT(o.order_id) / COUNT(DISTINCT c.unique_customer_id), 2) AS avg_purchase_frequency
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;
    
-- Which customers have become inactive?

SELECT
    COUNT(*) AS inactive_customers
FROM (
    SELECT
        c.unique_customer_id
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.unique_customer_id
    HAVING MAX(o.order_purchase_timestamp) <
           DATE_SUB(
               (SELECT MAX(order_purchase_timestamp) FROM orders),
               INTERVAL 6 MONTH
           )
) AS inactive;

-- Which states generate the most orders?

SELECT 
	c.customer_state AS state,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
GROUP BY state
ORDER BY order_count DESC;

-- Which city has the highest customer concentration?

SELECT
    customer_city AS city,
    COUNT(DISTINCT unique_customer_id) AS customer_count
FROM customers
GROUP BY customer_city
ORDER BY customer_count DESC
LIMIT 1;