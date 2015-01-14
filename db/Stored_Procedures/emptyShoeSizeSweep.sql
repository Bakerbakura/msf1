-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `myshoefits_development`.`emptyShoeSizeSweep` ()
BEGIN
	UPDATE `myshoefits_development`.`Customers` AS Customers
		SET Customers.ShoeSize = (SELECT AVG(Shoes.RealSize) FROM `myshoefits_development`.`Shoes` AS Shoes WHERE Shoes.OwnerID = Customers.CustID),
		Customers.ShoeSizeError = (SELECT STDDEV(Shoes.RealSize) FROM `myshoefits_development`.`Shoes` AS Shoes WHERE Shoes.OwnerID = Customers.CustID)
		WHERE Customers.ShoeSize IS NULL;
END