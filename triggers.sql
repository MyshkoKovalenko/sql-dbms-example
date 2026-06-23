DROP FUNCTION IF EXISTS update_all_orders CASCADE;
DROP TRIGGER IF EXISTS t_update_order_total ON order_items;
DROP FUNCTION IF EXISTS log_order CASCADE;
DROP TRIGGER IF EXISTS t_log_order ON orders;

CREATE OR REPLACE FUNCTION update_all_orders()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
    BEGIN

    UPDATE orders o SET total_amount = calculate_order_total(o.order_id)
        WHERE o.order_id = NEW.order_id;
    RETURN NEW;

    COMMIT;
    END;
$$;

CREATE OR REPLACE TRIGGER t_update_order_total AFTER
    INSERT OR
    UPDATE OR
    DELETE
ON order_items FOR EACH ROW
EXECUTE FUNCTION update_all_orders();

CREATE OR REPLACE FUNCTION log_order()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
    BEGIN

    INSERT INTO order_log (order_id, customer_id, action, log_date)
        SELECT NEW.order_id, NEW.customer_id, 'Purchase', NEW.order_date;
    RETURN NEW;

    COMMIT;
    END;
$$;

CREATE OR REPLACE TRIGGER t_log_order AFTER
    INSERT
ON orders FOR EACH ROW
EXECUTE FUNCTION log_order();