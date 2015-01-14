-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `myshoefits_development`.`update_T2RS_entry` (IN _T2RS_ID BIGINT)
BEGIN
	DECLARE c0, c1 DOUBLE DEFAULT 0.0;
	DECLARE brand, style, material VARCHAR(30);
	DECLARE row_limit INT DEFAULT 20;
	DECLARE ndiff INT DEFAULT 0;
	
	DECLARE x0, x1, x2 DOUBLE DEFAULT 0.0;
	DECLARE yx0, yx1 DOUBLE DEFAULT 0.0;
	DECLARE recipDenom DOUBLE DEFAULT 0.0;
	
	SELECT T2RS.coeff0, T2RS.coeff1, T2RS.Brand, T2RS.Style, T2RS.Material INTO c0, c1, brand, style, material
		FROM `myshoefits_development`.`TypeToRealSize` AS T2RS WHERE T2RS.T2RS_ID = _T2RS_ID;

	TRUNCATE TABLE T2RS_entryInfo;
	INSERT INTO T2RS_entryInfo(OwnerID, PreSize, ShoeSize) SELECT Shoes.OwnerID, Shoes.PreRealSize, Customers.ShoeSize
		FROM `myshoefits_development`.`Customers` AS Customers, `myshoefits_development`.`Shoes` AS Shoes WHERE Shoes.OwnerID = Customers.CustID
			AND Shoes.Brand = brand AND Shoes.Style = style AND Shoes.Material = material LIMIT row_limit;

	SELECT COUNT(DISTINCT PreSize) FROM T2RS_entryInfo INTO ndiff;
	
	IF ndiff >= 2 THEN
		SELECT COUNT(*), SUM(PreSize), SUM(PreSize*PreSize) FROM T2RS_entryInfo INTO x0, x1, x2;
		SELECT SUM(ShoeSize), SUM(PreSize*ShoeSize) FROM T2RS_entryInfo INTO yx0, yx1;
		
		SET recipDenom = 1.0/(x0*x2-x1*x1);
		
		SET c0 = 0.25*(c0+3.0*(+x2*yx0-x1*yx1)*recipDenom),
			c1 = 0.25*(c1+3.0*(-x1*yx0+x0*yx1)*recipDenom);
	END IF;
	
	UPDATE `myshoefits_development`.`TypeToRealSize` AS T2RS SET T2RS.coeff1 = c1, T2RS.coeff0 = c0 WHERE T2RS.T2RS_ID = _T2RS_ID;
END