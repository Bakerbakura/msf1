-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE FUNCTION `myshoefits_development`.`ToMondo` (size FLOAT, _sizeType VARCHAR(20)) RETURNS FLOAT
BEGIN
	SELECT Typez.ToMondo1, Typez.ToMondo0 FROM `myshoefits_development`.`SizeTypes` AS Typez WHERE Typez.SizeType = _sizeType INTO @tom1, @tom0;
	RETURN size*@tom1 + @tom0;
END