/* permissions to EM for view the hourly analysis form*/
SELECT id into @id FROM security.url_permission where url='/reports/hourlyanalysis';
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('2', @id);
