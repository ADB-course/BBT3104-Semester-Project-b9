-- Write your SQL code here
CREATE PROCEDURE UpdateOrderStatus(IN orderID INT, IN newStatus VARCHAR(20))
BEGIN
  UPDATE `Order`
  SET OrderStatus = newStatus
  WHERE OrderID = orderID;
END;
