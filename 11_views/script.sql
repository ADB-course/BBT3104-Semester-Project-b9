-- Write your SQL code here
--View for Expiring Products
CREATE VIEW ExpiringProducts AS
SELECT MedicineID, MedicineName, MedicineType, ExpiryDate
FROM Product
WHERE ExpiryDate <= DATE_ADD(CURDATE(), INTERVAL 30 DAY)

            --View for Customer Order History
CREATE VIEW CustomerOrderHistory AS
SELECT c.ClientID, c.ClientName, o.OrderID, o.OrderDate, o.OrderStatus
FROM Customer c
JOIN Order o ON c.ClientID = o.ClientID;

             --View for Active Products
CREATE VIEW ActiveProducts AS
SELECT 
    Medicine_ID, 
    Medicine_Name, 
    Medicine_Type, 
    Manufacture_Date, 
    Expiry_Date
FROM 
    Product
WHERE 
    Expiry_Date > CURDATE();

           --View for Customer Order Summary
CREATE VIEW CustomerOrderSummary AS
SELECT 
    c.Client_ID,
    c.Name AS CustomerName,
    COUNT(o.Order_ID) AS TotalOrders,
    MAX(o.Order_Date) AS LastOrderDate
FROM 
    Customer c
LEFT JOIN 
    `Order` o 
ON 
    c.Client_ID = o.Client_ID
GROUP BY 
    c.Client_ID, c.Name;

           --View for Order details
CREATE VIEW OrderDetails AS
SELECT 
    o.Order_ID,
    o.Order_Date,
    o.Order_Status,
    o.Mode_Of_Payment,
    c.Name AS CustomerName,
    c.Contact_Info AS CustomerContact
FROM 
    `Order` o
INNER JOIN 
    Customer c 
ON 
    o.Client_ID = c.Client_ID;
