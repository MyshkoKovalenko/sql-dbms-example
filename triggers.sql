DROP TRIGGER IF EXISTS update_order_total ON order_items;
DROP FUNCTION IF EXISTS update_all_orders;

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

CREATE OR REPLACE TRIGGER update_order_total AFTER
    INSERT OR
    UPDATE OR
    DELETE
ON order_items FOR EACH ROW
EXECUTE PROCEDURE update_all_orders();