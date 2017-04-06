DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `returnString`(status int, type int) RETURNS varchar(255) CHARSET utf8
BEGIN

if (type=1) then   /* Returns Issue Priority */
	if(status=1) then
		return 'Low';
	elseif(status=2) then
		return 'Medium';
	elseif(status=3) then
		return 'High';
	end if;
elseif (type=2) then  /* Returns Issue Status */
	if(status=0) then
		return 'Open';
	elseif(status=1) then
		return 'Resolved';
    elseif(status=2) then
		return 'Closed';
	elseif(status=3) then
		return 'In Progress';
	elseif(status=4) then
		return 'Escalate';
	end if;
elseif (type=3) then  /* Returns Tracking Status */
	if(status=0) then
		return 'at station';
	elseif(status=1) then
		return 'on the move';
    elseif(status=2) then
		return 'arrived';
	end if;
end if;
END$$
DELIMITER ;
