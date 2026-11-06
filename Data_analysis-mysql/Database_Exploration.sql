USE e_commerce;
SHOW TABLES;

-- How many records are in each table? 
SELECT 'customers' AS table_name, COUNT(*) AS total_records
FROM customers
UNION ALL
SELECT 'orders', COUNT(*)
FROM orders
UNION ALL
SELECT 'order_items', COUNT(*)
FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*)
FROM payments
UNION ALL
SELECT 'order_reviews', COUNT(*)
FROM order_reviews
UNION ALL
SELECT 'products', COUNT(*)
FROM products
UNION ALL
SELECT 'sellers', COUNT(*)
FROM sellers
UNION ALL
SELECT 'category_translation', COUNT(*)
FROM category_translation;

-- What is the date range of orders? 
SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM orders;

-- How many unique customers, sellers, products, and categories exist? 
SELECT 'Unique_Customers' AS Metric,
       COUNT(DISTINCT customer_id) AS Count
FROM customers
UNION ALL
SELECT 'Unique_Sellers',
       COUNT(DISTINCT seller_id)
FROM sellers
UNION ALL
SELECT 'Unique_Products',
       COUNT(DISTINCT product_id)
FROM products;

-- What are the distributions of order status, payment types, and review scores? 
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT
    payment_type,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_type
ORDER BY total_payments DESC;

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;


