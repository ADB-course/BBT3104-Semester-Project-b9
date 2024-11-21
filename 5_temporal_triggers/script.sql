-- Write your SQL code here
DELIMITER $$

  CREATE TRIGGER update_payment_status
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
       IF NEW.order_status = 'Completed' THEN
        UPDATE Payment
        SET payment_status = 'Completed'
        WHERE order_id = NEW.order_id;
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER set_default_order_status
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    -- Set default order status to 'Pending' if not provided
    IF NEW.order_status IS NULL THEN
        SET NEW.order_status = 'Pending';
    END IF;
END$$
DELIMITER ;
