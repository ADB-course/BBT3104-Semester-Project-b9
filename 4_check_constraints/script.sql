-- Write your SQL code here

CREATE DATABASE IF NOT EXISTS `Gsk`;
USE `Gsk`;

CREATE TABLE Product (
    Medicine_ID INT AUTO_INCREMENT PRIMARY KEY,
    Medicine_Name VARCHAR(100) NOT NULL,
    Manufacture_Date DATE NOT NULL,
    Expiry_Date DATE NOT NULL CHECK (Expiry_Date > Manufacture_Date),
    Medicine_Type VARCHAR(50) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE Customer (
    Client_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact_Info VARCHAR(50) NOT NULL,
    Address TEXT NOT NULL
) ENGINE=InnoDB;


CREATE TABLE `Order` (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Client_ID INT NOT NULL,
    Order_Date DATE NOT NULL,
    Order_Status ENUM('Pending', 'Completed', 'Cancelled') NOT NULL,
    Mode_Of_Payment ENUM('Cash', 'Card', 'Online') NOT NULL,


FOREIGN KEY (Client_ID) REFERENCES Customer(Client_ID) ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Stock_Control (
    Stock_ID INT AUTO_INCREMENT PRIMARY KEY,
    Medicine_ID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Expiration_Date DATE NOT NULL,
    FOREIGN KEY (Medicine_ID) REFERENCES Product(Medicine_ID) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_MedicineName ON Product (Medicine_Name);
CREATE INDEX idx_OrderDate ON `Order` (Order_Date);
CREATE INDEX idx_StockExpiration ON Stock_Control (Expiration_Date);


- Transaction for Adding a New Order
DELIMITER $$

CREATE PROCEDURE AddNewOrder (
    IN p_Client_ID INT,
    IN p_Order_Date DATE,
    IN p_Order_Status ENUM('Pending', 'Completed', 'Cancelled'),
    IN p_Mode_Of_Payment ENUM('Cash', 'Card', 'Online')
)
BEGIN
    START TRANSACTION;

 
    INSERT INTO `Order` (Client_ID, Order_Date, Order_Status, Mode_Of_Payment)
    VALUES (p_Client_ID, p_Order_Date, p_Order_Status, p_Mode_Of_Payment);

    COMMIT;
END $$
DELIMITER ;


