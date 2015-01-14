-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `myshoefits_development`.`addUser` 
	(_username VARCHAR(30), _email VARCHAR(30), _pword VARCHAR(30), _gender CHAR)
BEGIN
	INSERT INTO `myshoefits_development`.`Customers` VALUES(DEFAULT, _username, _email, PASSWORD(_pword), _gender, NULL, NULL);
END