TRUNCATE TABLE customers RESTART IDENTITY CASCADE;
TRUNCATE TABLE order_items RESTART IDENTITY CASCADE;
TRUNCATE TABLE order_log RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE products RESTART IDENTITY CASCADE;

INSERT INTO customers (full_name, email, balance) VALUES
    ('John Smith', 'john.smith@example.com', 150.00),
    ('Anna Brown', 'anna.brown@example.com', 300.00),
    ('Michael Johnson', 'michael.johnson@example.com', 75.50),
    ('Kate Wilson', 'kate.wilson@example.com', 500.00);

INSERT INTO products (product_name, price, stock_quantity) VALUES
    ('Laptop', 1200.00, 10),
    ('Mouse', 25.00, 100),
    ('Keyboard', 70.00, 50),
    ('Monitor', 250.00, 20),
    ('USB-C Cable', 15.00, 200);

CALL create_order(1);
CALL create_order(3);
CALL create_order(1);
CALL create_order(2);

CALL add_product_to_order(1, 1, 6);
CALL add_product_to_order(2, 1, 4);
CALL add_product_to_order(3, 3, 2);
CALL add_product_to_order(4, 4, 5);
CALL add_product_to_order(4, 2, 5);

SELECT * FROM customers;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM order_log;
SELECT * FROM products;