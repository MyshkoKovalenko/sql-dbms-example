DROP PROCEDURE IF EXISTS create_order;
DROP PROCEDURE IF EXISTS add_product_to_order;

CREATE OR REPLACE PROCEDURE create_order(p_customer_id int)
LANGUAGE SQL
AS $$
    INSERT INTO orders (customer_id, order_date, total_amount)
        SELECT
            p_customer_id,
            CURRENT_DATE,
            0
        WHERE p_customer_id IN (SELECT c.customer_id FROM customers c)
$$;

CREATE OR REPLACE PROCEDURE add_product_to_order(
    p_order_id int,
    p_product_id int,
    p_quantity int
)
LANGUAGE SQL
AS $$
    INSERT INTO order_items (order_id, product_id, quantity, price)
    SELECT
        p_order_id,
        p_product_id,
        p_quantity,
        (
            SELECT
                p.price
            FROM products p
            WHERE p.product_id = p_product_id
            LIMIT 1
        )
    WHERE
        p_order_id IN (SELECT o.order_id FROM orders o) AND
        p_product_id IN (SELECT p.product_id FROM products p) AND
        p_quantity <= (SELECT p.stock_quantity FROM products p WHERE p.product_id = p_product_id ) AND
        p_product_id > 0;

    UPDATE products SET stock_quantity = stock_quantity - p_quantity
    WHERE
        products.product_id = p_product_id AND
        p_order_id IN (SELECT o.order_id FROM orders o) AND
        p_product_id IN (SELECT p.product_id FROM products p) AND
        p_quantity <= (SELECT p.stock_quantity FROM products p WHERE p.product_id = p_product_id) AND
        p_product_id > 0;
$$;