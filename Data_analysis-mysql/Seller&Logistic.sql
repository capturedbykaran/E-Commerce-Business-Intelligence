USE e_commerce;

-- Who are the top sellers by revenue?
SELECT
    oi.seller_id,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM order_items oi
JOIN payments p
    ON oi.order_id = p.order_id
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Who processes the highest number of orders?
SELECT 
	seller_id,
    COUNT(DISTINCT order_id) AS TotalOrders
FROM order_items
GROUP BY seller_id
ORDER BY TotalOrders DESC
LIMIT 10;

-- Which seller has the best average rating?

SELECT
    oi.seller_id,
    ROUND(AVG(ore.review_score), 2) AS average_rating
FROM order_items oi
JOIN order_reviews ore
    ON oi.order_id = ore.order_id
GROUP BY oi.seller_id
ORDER BY average_rating DESC
LIMIT 1;

-- Which seller has the fastest delivery performance?

-- Which seller has the fastest delivery performance?

SELECT
    oi.seller_id,
    ROUND(AVG(TIMESTAMPDIFF(HOUR,
            o.order_purchase_timestamp,
            o.order_delivered_carrier_date)), 2) AS avg_delivery_hours
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_delivered_carrier_date IS NOT NULL
  AND o.order_delivered_carrier_date >= o.order_purchase_timestamp
GROUP BY oi.seller_id
HAVING COUNT(DISTINCT oi.order_id) >= 10
ORDER BY avg_delivery_hours ASC
LIMIT 1;

-- Which seller states generate the highest revenue?

SELECT
    s.seller_state,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
GROUP BY s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- What is the average delivery time?

SELECT
    ROUND(
        AVG(
            TIMESTAMPDIFF(HOUR,
                order_purchase_timestamp,
                order_delivered_customer_date
            ) / 24.0
        ),
        2
    ) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_delivered_customer_date >= order_purchase_timestamp;
  
  
-- What percentage of orders are delivered late?

SELECT
    ROUND(
        COUNT(CASE WHEN delivery_delay_days < 0 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS late_order_percentage
FROM orders;

-- Which states have the longest delivery time?

SELECT
    c.customer_state,
    ROUND(
        AVG(
            TIMESTAMPDIFF(HOUR,
                o.order_purchase_timestamp,
                o.order_delivered_customer_date
            ) / 24.0
        ),
        2
    ) AS avg_delivery_days
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_delivered_customer_date >= o.order_purchase_timestamp
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;

-- Does delivery delay affect review score?

-- Does delivery delay affect review score?

SELECT
	o.delivery_status,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    COUNT(*) AS total_orders
FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id
GROUP BY delivery_status
ORDER BY avg_review_score DESC;




