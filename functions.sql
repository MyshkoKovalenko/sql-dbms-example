DROP FUNCTION IF EXISTS calculate_order_total;
DROP PROCEDURE IF EXISTS create_order;

CREATE OR REPLACE FUNCTION calculate_order_total(p_order_id int)
RETURNS FLOAT
LANGUAGE SQL
AS $$
    SELECT
        sum(oi.price * oi.quantity) as total_price
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
    HAVING o.order_id = p_order_id
    LIMIT 1
$$;

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