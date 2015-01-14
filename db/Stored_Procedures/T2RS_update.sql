-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `myshoefits_development`.`T2RS_update` ()
BEGIN
	DECLARE i INT DEFAULT 1;
	DECLARE n INT DEFAULT 0;
	DECLARE tempT2RSid BIGINT DEFAULT 0;
	
	CALL emptyShoeSizeSweep;
	
	DROP TEMPORARY TABLE IF EXISTS moddedT2RSentries;
	CREATE TEMPORARY TABLE moddedT2RSentries(id BIGINT AUTO_INCREMENT PRIMARY KEY, t2rs_id BIGINT);
	INSERT INTO moddedT2RSentries(t2rs_id) SELECT T2RS.T2RS_ID FROM `myshoefits_development`.`TypeToRealSize` AS T2RS WHERE T2RS.modified = TRUE;
	SELECT COUNT(*) FROM moddedT2RSentries INTO n;
	SET i=1;
	WHILE i<=n DO
		SELECT modd.t2rs_id FROM moddedT2RSentries AS modd WHERE modd.id = i INTO tempT2RSid;
		CALL update_T2RS_entry(tempT2RSid);
		SET i=i+1;
	END WHILE;
	
	BEGIN
		DECLARE done BOOLEAN DEFAULT FALSE;
		DECLARE userID BIGINT;
		DECLARE cur CURSOR FOR SELECT DISTINCT Shoes.OwnerID FROM `myshoefits_development`.`Shoes` AS Shoes, moddedT2RSentries AS modd
			WHERE Shoes.T2RS_ID = modd.t2rs_id;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		OPEN cur;
		
		sweepLoop: LOOP
			FETCH cur INTO userID;
			IF done THEN LEAVE sweepLoop; END IF;
			CALL updateUserShoeStats(userID);
		END LOOP sweepLoop;
		
		CLOSE cur;
	END;
	
	UPDATE `myshoefits_development`.`TypeToRealSize` AS T2RS SET T2RS.modified = FALSE WHERE T2RS.modified = TRUE;	#implicit commit here - error when stored function!
END