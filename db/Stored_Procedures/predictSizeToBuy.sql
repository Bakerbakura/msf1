-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE FUNCTION `myshoefits_development`.`predictSizeToBuy` (_custID BIGINT, _brand VARCHAR(30), _style VARCHAR(30), _material VARCHAR(30), _sizeType VARCHAR(20)) RETURNS FLOAT
BEGIN
	SELECT T2RS.coeff0, T2RS.coeff1 FROM `myshoefits_development`.`TypeToRealSize` AS T2RS
		WHERE T2RS.Brand = _brand AND T2RS.Style = _style AND T2RS.Material = _material INTO @c0, @c1;
	SELECT ShoeSize FROM `myshoefits_development`.`Customers` AS Customers WHERE Customers.CustID = _custID INTO @shoesize;
	RETURN FromMondo((@shoesize-@c0)/@c1,_sizeType);
END