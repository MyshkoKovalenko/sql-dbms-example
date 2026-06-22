DROP FUNCTION IF EXISTS calculate_order_total;

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
