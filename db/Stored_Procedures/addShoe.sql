-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `myshoefits_development`.`addShoe` (_ownerID BIGINT, _brand VARCHAR(30), _style VARCHAR(30),
	_material VARCHAR(30), _size FLOAT, _sizeType VARCHAR(20), _lengthFit VARCHAR(20))
BEGIN
	INSERT INTO `myshoefits_development`.`Shoes` VALUE (DEFAULT, ownerID, NULL, _brand, _style, _material, _size, _sizeType, _lengthFit, NULL, NULL);
END