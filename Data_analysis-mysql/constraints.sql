CREATE DATABASE E_commerce;
USE E_commerce;
SHOW TABLES;

-- customers
SELECT * FROM customers LIMIT 10;

ALTER TABLE customers
MODIFY customer_id VARCHAR(50) NOT NULL;

ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

-- sellers
SELECT * FROM sellers LIMIT 10;

ALTER TABLE sellers
MODIFY seller_id VARCHAR(50) NOT NULL;

ALTER TABLE sellers
ADD PRIMARY KEY (seller_id);

-- products
SELECT * FROM products LIMIT 10;

ALTER TABLE products
MODIFY product_id VARCHAR(50) NOT NULL;

ALTER TABLE products
ADD PRIMARY KEY (product_id);


-- category_translation
SELECT * FROM category_translation LIMIT 10;
ALTER TABLE category_translation
MODIFY 	product_category_name VARCHAR(100) NOT NULL;

ALTER TABLE category_translation
ADD PRIMARY KEY (product_category_name);


-- orders
ALTER TABLE orders
MODIFY order_id VARCHAR(100) NOT NULL;

ALTER TABLE orders
ADD PRIMARY KEY (order_id);

ALTER TABLE orders
MODIFY customer_id VARCHAR(100) NOT NULL;

ALTER TABLE orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- order_items
ALTER TABLE order_items
MODIFY order_id VARCHAR(100) NOT NULL,
MODIFY order_item_id VARCHAR(100) NOT NULL,
MODIFY product_id VARCHAR(100) NOT NULL,
MODIFY seller_id VARCHAR(100) NOT NULL;

ALTER TABLE order_items
ADD PRIMARY KEY (order_id, order_item_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_seller
FOREIGN KEY (seller_id)
REFERENCES sellers(seller_id);

-- payments
ALTER TABLE payments
MODIFY order_id VARCHAR(100) NOT NULL,
MODIFY payment_sequential VARCHAR(100) NOT NULL;

ALTER TABLE payments
ADD PRIMARY KEY (order_id,payment_sequential);

ALTER TABLE payments
ADD CONSTRAINT fk_payment_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- order_reviews
ALTER TABLE order_reviews
MODIFY order_id VARCHAR(100) NOT NULL,
MODIFY review_id VARCHAR(100) NOT NULL;

ALTER TABLE order_reviews
ADD PRIMARY KEY (review_id,order_id);

ALTER TABLE order_reviews
ADD CONSTRAINT fk_review_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);



