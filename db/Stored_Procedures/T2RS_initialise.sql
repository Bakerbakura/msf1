-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `myshoefits_development`.`T2RS_initialise` ()
BEGIN
	SELECT * FROM T2RS_initialised INTO @initialised;
	IF NOT @initialised THEN
		INSERT INTO `myshoefits_development`.`TypeToRealSize` (Brand, Style, Material, ToMondo1, ToMondo0)
		SELECT Brands.Brand, Styles.Style, Materials.Material, 1.0, 0.0
		FROM `myshoefits_development`.`ShoeBrands` AS Brands, `myshoefits_development`.`ShoeStyles` AS Styles, `myshoefits_development`.`ShoeMaterials` AS Materials;
	END IF;
	
	#UPDATE `mydb`.`Shoes` AS Shoes
	#	SET Shoes.T2RS_ID = (SELECT T2RS.T2RS_ID FROM `mydb`.`TypeToRealSize` AS T2RS
	#		WHERE T2RS.Brand = Shoes.Brand AND T2RS.Style = Shoes.Style AND T2RS.Material = Shoes.Material) WHERE Shoes.T2RS_ID IS NULL;
	
	UPDATE T2RS_initialised SET T2RS_initialised.init = TRUE;
END