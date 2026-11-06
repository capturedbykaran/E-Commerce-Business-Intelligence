USE e_commerce;

-- Which payment method is most popular?

SELECT 
	payment_type,
    COUNT(DISTINCT order_id) AS total_orders
FROM payments
GROUP BY payment_type
ORDER BY total_orders DESC
LIMIT 1;

-- Which payment method generates the highest revenue?

SELECT
    payment_type,
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC
LIMIT 1;

--  What is the average payment value?

SELECT 
    ROUND(AVG(payment_value), 2) AS average_payment_value
FROM payments;

-- How do installment payments affect order value?

SELECT
    payment_installments,
    ROUND(AVG(payment_value), 2) AS avg_order_value,
    COUNT(DISTINCT order_id) AS total_orders
FROM payments
GROUP BY payment_installments
ORDER BY payment_installments;

-- What is the average review score?

SELECT ROUND(AVG(review_score),2)  AS average_review_score
FROM order_reviews;

-- Which product categories receive the best ratings?

SELECT 
    p.product_category_name,
    ROUND(AVG(r.review_score), 2) AS average_rating,
    COUNT(r.review_id) AS total_reviews
FROM order_reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING COUNT(r.review_id) >= 50
ORDER BY average_rating DESC, total_reviews DESC
LIMIT 10; 

-- Which sellers receive the best ratings?

SELECT 
    oi.seller_id,
    ROUND(AVG(r.review_score), 2) AS average_rating,
    COUNT(DISTINCT r.order_id) AS total_reviews
FROM order_reviews r
JOIN order_items oi
    ON r.order_id = oi.order_id
GROUP BY oi.seller_id
HAVING COUNT(DISTINCT r.order_id) >= 50
ORDER BY average_rating DESC, total_reviews DESC
LIMIT 10;

-- Does review length correlate with review score?

SELECT
    review_score,
    ROUND(AVG(review_message_length), 2) AS avg_review_length,
    COUNT(*) AS total_reviews
FROM order_reviews
WHERE review_message_length > 0
GROUP BY review_score
ORDER BY review_score;





























