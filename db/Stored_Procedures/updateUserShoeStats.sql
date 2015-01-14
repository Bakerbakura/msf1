-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `myshoefits_development`.`updateUserShoeStats` (_custID BIGINT)
BEGIN
	SELECT AVG(Shoes.RealSize), STDDEV_POP(Shoes.RealSize) FROM `myshoefits_development`.`Shoes` AS Shoes WHERE Shoes.OwnerID = _custID INTO @average, @stddev;
	UPDATE `myshoefits_development`.`Customers` AS Customers SET Customers.ShoeSize = @average, Customers.ShoeSizeError = @stddev WHERE Customers.CustID = _custID;
END