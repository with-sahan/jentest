DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `isopenisclosed`(IN strIDs VARCHAR(3000))
BEGIN

  DECLARE strLen    INT DEFAULT 0;
  DECLARE SubStrLen INT DEFAULT 0;
  DECLARE stationid INT;
  DECLARE isopen INT DEFAULT 0;
  DECLARE isclose INT DEFAULT 0;

  IF strIDs IS NULL THEN
    SET strIDs = '';
  END IF;

do_this:
  LOOP
    SET strLen = CHAR_LENGTH(strIDs);

    select SUBSTRING_INDEX(strIDs, ',', 1) into stationid;
    SET isopen = isopen+(select psm.isopen(stationid));
    SET isclose = isclose+(select psm.isclose(stationid));

    SET SubStrLen = CHAR_LENGTH(SUBSTRING_INDEX(strIDs, ',', 1)) + 2;
    SET strIDs = MID(strIDs, SubStrLen, strLen);

    IF strIDs = '' THEN
      LEAVE do_this;
    END IF;
  END LOOP do_this;
  
    select isopen as opened,isclose as closed;
END$$
DELIMITER ;
