-- Write your SQL code here
CREATE FUNCTION GetExpiringMedicinesReport(cutoffDate DATE)
RETURNS TABLE
AS
RETURN
  SELECT MedicineID, MedicineName, MedicineType, ExpiryDate
  FROM Product
  WHERE ExpiryDate <= cutoffDate;
