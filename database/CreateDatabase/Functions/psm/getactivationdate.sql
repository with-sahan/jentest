DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `getactivationdate`(orgid int) RETURNS date
BEGIN
    DECLARE response date;
    select activationday into response from subscription.organization where id=orgid;
    /* select '2016-06-08' into response; */
RETURN response;
END$$
DELIMITER ;
