-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE FUNCTION `myshoefits_development`.`preToRealSize` (_id BIGINT, _prerealsize FLOAT) RETURNS FLOAT
BEGIN
	DECLARE c1, c0 FLOAT;
	DECLARE multiple_row_returned CONDITION FOR SQLSTATE '21000';
	DECLARE CONTINUE HANDLER FOR multiple_row_returned SIGNAL multiple_row_returned
		SET MESSAGE_TEXT = 'Error: TypeToRealSize table has multiple entries with the same brand, style and material.';
	
	SELECT T2RS.ToMondo1, T2RS.ToMondo0 INTO c1, c0 FROM `myshoefits_development`.`TypeToRealSize` AS T2RS WHERE T2RS.T2RS_ID = _id;	
	RETURN c0 + _prerealsize*c1;
END