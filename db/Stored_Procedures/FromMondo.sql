-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE FUNCTION `myshoefits_development`.`FromMondo` (mondoSize FLOAT, _sizeType VARCHAR(20)) RETURNS FLOAT
BEGIN
	DECLARE tom1, tom0 FLOAT DEFAULT 0.0;
	SELECT Typez.ToMondo1, Typez.ToMondo0 FROM `myshoefits_development`.`SizeTypes` AS Typez WHERE Typez.SizeType = _sizeType INTO tom1, tom0;
	RETURN (mondoSize-@tom0)/@tom1;
END