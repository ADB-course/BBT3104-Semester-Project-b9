-- Write your SQL code here

--Payment Processing Transcation
START TRANSACTION;
SELECT order_status
FROM Orders
WHERE order_id = 'O001'; 

UPDATE Payment
SET payment_status = 'Completed'
WHERE transaction_id = 'T001' AND payment_status = 'Pending';

IF ROW_COUNT() = 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Payment not processed.';
END IF;

UPDATE Orders
SET order_status = 'Completed'
WHERE order_id = 'O001';

COMMIT;


--Managing Customer Information
START TRANSACTION;

UPDATE Customers
SET customer_address = '123 Wall street, Kayole', 
    customer_contact = 'Jonnah Odongo' -- Replace with new contact
WHERE customer_id = 'C001'; 

COMMIT;


--Cancelling an order
START TRANSACTION;

SELECT order_status
FROM Orders
WHERE order_id = 'O001';

UPDATE Orders
SET order_status = 'Cancelled'
WHERE order_id = 'O001' AND order_status NOT IN ('Completed', 'Cancelled');

IF ROW_COUNT() = 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Order cancellation failed. Order might already be completed or cancelled.';
END IF;

UPDATE Stock_Control
SET stock_quantity = stock_quantity + 10 
WHERE medicine_id = 'M001';

COMMIT;


--Transaction for placing an order
START TRANSACTION;

SELECT stock_quantity
FROM Stock_Control
WHERE medicine_id = 'M001';

UPDATE Stock_Control
SET stock_quantity = stock_quantity - 10 
WHERE medicine_id = 'M001' AND stock_quantity >= 10;

IF ROW_COUNT() = 0 THEN
    ROLLBACK; -- Not enough stock
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Insufficient stock for medicine.';
END IF;

INSERT INTO Orders (order_id, customer_id, order_date, order_status, mode_of_payment)
VALUES ('O001', 'C001', ‘11-11-2024’, 'Pending', 'Credit Card'); 

INSERT INTO Payment (transaction_id, order_id, payment_method, amount_paid, payment_status)
VALUES ('T001', 'O001', 'Credit Card', 500, 'Pending'); 

COMMIT;






