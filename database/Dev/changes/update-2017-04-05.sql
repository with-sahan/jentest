INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reportissueservices/reportissue', 'REPORT_ISSUES');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('1', last_insert_id());
